// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  bool success;
  String message;
  int userId;

  SignUpResponse({
    required this.success,
    required this.message,
    required this.userId,
  });

  SignUpResponse copyWith({
    bool? success,
    String? message,
    int? userId,
  }) =>
      SignUpResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        userId: userId ?? this.userId,
      );

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    success: json["success"],
    message: json["message"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "user_id": userId,
  };
}
