import 'package:dartz/dartz.dart';
import 'package:form_without_connection/data/network/failures/failure.dart';
import 'package:form_without_connection/data/request/register_request.dart';
import 'package:form_without_connection/domain/models/register_response_model.dart';

abstract class Repository {
  Future<Either<Failure, RegisterResponseModel>> registerCustomerRepository(
    RegisterRequest registerRequest,
  );
}
