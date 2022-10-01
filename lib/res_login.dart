// To parse this JSON data, do
//
//     final resLogin = resLoginFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

ResLogin resLoginFromJson(String str) => ResLogin.fromJson(json.decode(str));

String resLoginToJson(ResLogin data) => json.encode(data.toJson());

class ResLogin {
  ResLogin({
    this.value,
    this.message,
    this.name,
    this.email,
    this.id,
  });

  int? value;
  String? message;
  String? name;
  String? email;
  String? id;

  factory ResLogin.fromJson(Map<String, dynamic> json) => ResLogin(
        value: json["value"] == null ? null : json["value"],
        message: json["message"] == null ? null : json["message"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "message": message == null ? null : message,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "id": id == null ? null : id,
      };
}
