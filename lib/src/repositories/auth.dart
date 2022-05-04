import 'package:flutter/material.dart';
import 'package:my_movies_app/src/services/auth.dart';

class AuthRepository {
  late AuthService authService = AuthService();

  Future<String> login(
          {required BuildContext context,
          required String email,
          required String password}) async =>
      await authService.login(
          context: context, email: email, password: password);

  Future<void> logOut() async => await authService.logout();
}
