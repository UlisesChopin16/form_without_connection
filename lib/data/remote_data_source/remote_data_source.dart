import 'package:form_without_connection/data/request/register_request.dart';
import 'package:form_without_connection/data/responses/register_response.dart';

abstract class RemoteDataSource {
  Future<RegisterResponse> registerCustomerRDS(RegisterRequest registerRequest);
}