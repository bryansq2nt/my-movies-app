
import 'dart:convert';


String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.email,
    required this.token,
  });

  String email;
  String token;


  Map<String, dynamic> toJson() => {
    "email": email,
    "token": token,
  };
}
