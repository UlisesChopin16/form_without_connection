import 'package:form_without_connection/app/extensions.dart';
import 'package:form_without_connection/data/responses/register_response.dart';
import 'package:form_without_connection/domain/models/register_response_model.dart';

extension RegisterResponseMapper on RegisterResponse {
  RegisterResponseModel toDomain() {
    return RegisterResponseModel(
      status: status.orZero(),
      message: message.orEmpty(),
    );
  }
}