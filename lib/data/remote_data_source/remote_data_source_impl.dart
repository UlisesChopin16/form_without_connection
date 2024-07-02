import 'package:form_without_connection/data/network/apis/app_api.dart';
import 'package:form_without_connection/data/remote_data_source/remote_data_source.dart';
import 'package:form_without_connection/data/request/register_request.dart';
import 'package:form_without_connection/data/responses/register_response.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppApi appApi;

  const RemoteDataSourceImpl(
    this.appApi,
  );

  
  // @override
  // Future<RegisterResponse> registerCustomerRDS(RegisterRequest registerRequest) async {
  //   final response = await appApi.registerCustomer(registerRequest.toJsonWithImage());
  //   return response;
  // }

  @override
  Future<RegisterResponse> registerCustomerRDS(RegisterRequest registerRequest) async {
    final response = await appApi.registerCustomer(registerRequest.toJson());
    return response;
  }
}
