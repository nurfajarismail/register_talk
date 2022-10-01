// To parse this JSON data, do
//
//     final resRegister = resRegisterFromJson(jsonString);

import 'dart:convert';

ResRegister resRegisterFromJson(String str) =>
    ResRegister.fromJson(json.decode(str));

String resRegisterToJson(ResRegister data) => json.encode(data.toJson());

class ResRegister {
  ResRegister({
    this.value,
    this.message,
  });

  int? value;
  String? message;

  factory ResRegister.fromJson(Map<String, dynamic> json) => ResRegister(
        value: json["value"] == null ? null : json["value"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "message": message == null ? null : message,
      };
}
