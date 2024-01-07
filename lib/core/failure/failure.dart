import '../exception/exception.dart';

abstract class  Failure{}
class ServerFailure implements Failure{
  final String failureMessage;
  final String failureCode;

  factory ServerFailure.fromServerException(ServerException exception){
    return ServerFailure(
        failureMessage: exception.errorMessage,
        failureCode: exception.errorCode);
  }

  ServerFailure({required this.failureMessage,
    required this.failureCode});
}
