import 'dart:convert';

class Error400 {
  final int statusCode;
  final String errorMessage;

  Error400({this.errorMessage, this.statusCode});

  factory Error400.fromRawJson(String source) =>
      Error400.fromJson(jsonDecode(source));

  factory Error400.fromJson(Map<String, dynamic> json) {
    return Error400(
      statusCode: json['cod'],
      errorMessage: json['message'],
    );
  }
}
