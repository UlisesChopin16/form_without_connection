// Map<String, dynamic> toJson() {
//   return {
//     'country_mobile_code': countryMobileCode,
//     'user_name': userName,
//     'email': email,
//     'password': password,
//     'mobile_number': mobileNumber,
//     'profile_picture': profilePicture,
//   };
// }

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const RegisterRequest._();

  const factory RegisterRequest({
    @JsonKey(name: 'country_mobile_code') String? countryMobileCode,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'mobile_number') String? mobileNumber,
    @JsonKey(name: 'profile_picture') String? profilePicture,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  factory RegisterRequest.fromEncodedJson(String jsonEn) {
    return RegisterRequest.fromJson(json.decode(jsonEn) as Map<String, dynamic>);
  }

  Map<String, dynamic> toJsonWithImage() {
    final map = toJson();
    final fileImage = File(profilePicture!);
    if (!fileImage.existsSync()) {
      return map;
    }

    map['profile_picture'] = MultipartFile.fromBytes(
      fileImage.readAsBytesSync(),
      filename: profilePicture!.split('/').last,
      contentType: MediaType('image', 'jpg'),
    );

    return map;
  }

  String toEncodedJson() {
    return json.encode(toJson());
  }
}
