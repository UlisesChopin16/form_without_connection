import 'package:dartz/dartz.dart';
import 'package:form_without_connection/data/network/failures/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
