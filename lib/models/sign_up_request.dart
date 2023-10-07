// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) => SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  String firstName;
  String lastName;
  String email;
  String password;

  SignUpRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  SignUpRequest copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) =>
      SignUpRequest(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
  };
}
