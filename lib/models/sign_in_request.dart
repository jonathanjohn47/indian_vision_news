// To parse this JSON data, do
//
//     final signInRequest = signInRequestFromJson(jsonString);

import 'dart:convert';

SignInRequest signInRequestFromJson(String str) => SignInRequest.fromJson(json.decode(str));

String signInRequestToJson(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
  String email;
  String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  SignInRequest copyWith({
    String? email,
    String? password,
  }) =>
      SignInRequest(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
