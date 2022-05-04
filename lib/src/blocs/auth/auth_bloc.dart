import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/src/repositories/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_events.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository = AuthRepository();
  late SharedPreferences _preferences;

  AuthenticationBloc() : super(LoginInitialState()) {
    on<AuthenticationInit>(_onInit);
    on<LoginRequestedEvent>(_onLogin);
    on<LogoutRequestedEvent>(_onLogout);
  }

  void _onInit(
      AuthenticationInit event, Emitter<AuthenticationState> emit) async {
    try {
      _preferences = await SharedPreferences.getInstance();
      String? token = _preferences.getString('token');
      if (token != null) {
        emit(LoggedInState());
      } else {
        emit(NotLoggedInState());
      }
    } catch (error) {
      add(LogoutRequestedEvent(event.context));
      if (error.runtimeType.toString() == Error().runtimeType.toString()) {
        return _onLoginError('Unhandled Error.', event.context, emit);
      }
      return _onLoginError(error.toString(), event.context, emit);
    }
  }

  void _onLogin(
      LoginRequestedEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(LoginLoadingState());
      String token = await _authRepository.login(
          context: event.context, email: event.email, password: event.password);
      _preferences.setString('token', token);
      emit(LoggedInState());
      Navigator.pushNamedAndRemoveUntil(
          event.context, '/home', (route) => false);
    } catch (error) {
      if (error.runtimeType.toString() == Error().runtimeType.toString()) {
        return _onLoginError('Unhandled Error.', event.context, emit);
      }
      return _onLoginError(error.toString(), event.context, emit);
    }
  }

  void _onLogout(
      LogoutRequestedEvent event, Emitter<AuthenticationState> emit) async {
    await _authRepository.logOut();
    emit(NotLoggedInState());
    Navigator.pushNamedAndRemoveUntil(
        event.context, '/login', (route) => false);
  }

  void _onLoginError(String error, BuildContext context, emit) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        error,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      elevation: 10.0,
    ));
  }
}
