import 'package:dartz/dartz.dart';
import 'package:form_without_connection/app/app_preferences.dart';
import 'package:form_without_connection/data/mapper/register_response_mapper.dart';
import 'package:form_without_connection/data/network/error_handler.dart';
import 'package:form_without_connection/data/network/failures/failure.dart';
import 'package:form_without_connection/data/network/network_info/network_info.dart';
import 'package:form_without_connection/data/remote_data_source/remote_data_source.dart';
import 'package:form_without_connection/data/repository/repository.dart';
import 'package:form_without_connection/data/request/register_request.dart';
import 'package:form_without_connection/domain/models/register_response_model.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AppPreferences appPreferences;

  const RepositoryImpl(
    this.remoteDataSource,
    this.networkInfo,
    this.appPreferences,
  );

  @override
  Future<Either<Failure, RegisterResponseModel>> registerCustomerRepository(
      RegisterRequest registerRequest) async {
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        // return connection error
        await checkForFormList(registerRequest);
        return Right(
          RegisterResponseModel(
            status: 200,
            message: 'Form saved successfully, it will be sent when the connection is restored.',
          ),
        );
      } 

      List<String> formList = await appPreferences.getListFormWithoutWifi();
      if (formList.isNotEmpty) {
        await sendForms();
      }

      final response = await remoteDataSource.registerCustomerRDS(registerRequest);

      if (response.status != 200) {
        // return error
        return Left(
          Failure(
            code: 409,
            message: response.message ?? 'Error in the request, please try again later.',
          ),
        );
      }
      return Right(response.toDomain());
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }

  Future<void> checkForFormList(RegisterRequest registerRequest) async {
    // check for form list
    List<String> formList = await appPreferences.getListFormWithoutWifi();

    // return error
    String form = registerRequest.toEncodedJson();
    formList.add(form);
    await appPreferences.saveListFormWithoutWifi(formList);
  }

  Future<void> sendForms() async {
    // check for form list
    List<String> formList = await appPreferences.getListFormWithoutWifi();

    await appPreferences.clearListFormWithoutWifi();
    
    // if form list is empty do nothing
    if (formList.isEmpty) return;

    // send forms
    for (String form in formList) {
      final registerRequest = RegisterRequest.fromEncodedJson(form);
      await registerCustomerRepository(registerRequest);
    }
  }
}
