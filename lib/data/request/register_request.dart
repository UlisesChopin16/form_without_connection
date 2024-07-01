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

import 'package:form_without_connection/domain/use_cases/register_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    @JsonKey(name: 'country_mobile_code') String? countryMobileCode,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'mobile_number') String? mobileNumber,
    @JsonKey(name: 'profile_picture') String? profilePicture,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  factory RegisterRequest.fromRegisterUseCaseInput(RegisterUseCaseInput input) => RegisterRequest(
    email: input.email,
    countryMobileCode: input.countryMobileCode,
    userName: input.userName,
    password: input.password,
    mobileNumber: input.mobileNumber,
    profilePicture: input.profilePicture,
  );
}