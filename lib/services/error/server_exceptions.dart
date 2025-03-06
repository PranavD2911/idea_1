abstract class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);
  @override
  String toString() {
    return "Exception: $message";
  }
}

class ForbiddenException extends ServerException {
  ForbiddenException([super.message]);
}

class ConflictException extends ServerException {
  ConflictException([super.message]);
}

class InternalServerErrorException extends ServerException {
  InternalServerErrorException([super.message]);
}

class ServiceUnavailableException extends ServerException {
  ServiceUnavailableException([super.message]);
}

class NotFoundException extends ServerException {
  NotFoundException([super.message]);
}

class NotConnectedException extends ServerException {
  NotConnectedException([super.message]);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException([super.message]);
}

class CacheException extends ServerException {
  CacheException([super.message]);
}

class ItemNotFoundException extends ServerException {
  ItemNotFoundException([super.message]);
}

class FetchDataException extends ServerException {
  FetchDataException([super.message]);
}

class BadRequestException extends ServerException {
  BadRequestException(super.message);
}

class InvalidInputException extends ServerException {
  InvalidInputException([super.message]);
}
