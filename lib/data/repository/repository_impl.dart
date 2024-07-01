import 'package:dartz/dartz.dart';
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

  const RepositoryImpl(
    this.remoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, RegisterResponseModel>> registerCustomerRepository(
      RegisterRequest registerRequest) async {
    try {
      final bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        // return connection error
        return const Left(
          Failure(
            code: 408,
            message: 'No internet connection, please try again later.',
          ),
        );
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
}