class ServerException implements Exception {
  final String message;
  final int? statusCode;
  
  ServerException({required this.message, this.statusCode});
}

class CacheException implements Exception {
  final String message;
  
  CacheException(this.message);
}

class NetworkException implements Exception {
  final String message;
  
  NetworkException(this.message);
}

class AuthenticationException implements Exception {
  final String message;
  
  AuthenticationException(this.message);
}

class ValidationException implements Exception {
  final String message;
  
  ValidationException(this.message);
}
