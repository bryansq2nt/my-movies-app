import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio = Dio();

  Future<String> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      Response response = await dio.post("https://reqres.in/api/login",
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        return throw "Sorry an error has occurred while we try to login you.";
      }
    } on DioError catch (e) {
      log("Dio Error occurred: $e");
      return throw "Sorry an error has occurred while we try to login you.";
    } catch (error, stacktrace) {
      log("Error occurred: $error stackTrace: $stacktrace");
      return throw "Sorry an error has occurred while we try to login you.";
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
