import 'package:dio/dio.dart';
import 'package:form_without_connection/data/responses/register_response.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  static const String register = "/register";

  factory AppApi(Dio dio) = _AppApi;

  
  @POST(register)
  Future<RegisterResponse> registerCustomer(
    @Body() Map<String, dynamic> body,
  );
  // @MultiPart()
  // @POST(register)
  // Future<RegisterResponse> registerCustomer(
  //   @Part() Map<String, dynamic> body,
  // );
}
