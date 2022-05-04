part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class LoginInitialState extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class LoginErrorState extends AuthenticationState {}

class LoggedInState extends AuthenticationState {}

class NotLoggedInState extends AuthenticationState {}
