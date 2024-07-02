import 'package:dartz/dartz.dart';
import 'package:form_without_connection/data/network/failures/failure.dart';
import 'package:form_without_connection/data/repository/repository.dart';
import 'package:form_without_connection/data/request/register_request.dart';
import 'package:form_without_connection/domain/models/register_response_model.dart';
import 'package:form_without_connection/domain/use_cases/base_use_case.dart';

class RegisterUseCase implements BaseUseCase<RegisterRequest, RegisterResponseModel> {
  final Repository repository;

  const RegisterUseCase(this.repository);
  // this is the function that will be called from the UI
  @override
  Future<Either<Failure, RegisterResponseModel>> execute(RegisterRequest input) async {
    // first we get the device info

    // then we call the repository to login the customer
    final response = await repository.registerCustomerRepository(
      input,
    );

    return response;
  }
}
