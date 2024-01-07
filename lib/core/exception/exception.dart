class ServerException implements Exception{
  final String errorMessage;
  final String errorCode;

  ServerException({
    required this.errorMessage,
    required this.errorCode});
}