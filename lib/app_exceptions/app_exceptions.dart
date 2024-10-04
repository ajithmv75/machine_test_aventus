class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class BadRequestException extends ApiException {
  BadRequestException() : super('Bad Request');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super('Unauthorized');
}

class ForbiddenException extends ApiException {
  ForbiddenException() : super('Forbidden');
}

class NotFoundException extends ApiException {
  NotFoundException() : super('Not Found');
}

class MethodNotAllowedException extends ApiException {
  MethodNotAllowedException() : super('Method Not Allowed');
}

class RequestTimeoutException extends ApiException {
  RequestTimeoutException() : super('Request Timeout');
}

class TooManyRequestsException extends ApiException {
  TooManyRequestsException() : super('Too Many Requests');
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException() : super('Internal Server Error');
}

class BadGatewayException extends ApiException {
  BadGatewayException() : super('Bad Gateway');
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException() : super('Service Unavailable');
}

class GatewayTimeoutException extends ApiException {
  GatewayTimeoutException() : super('Gateway Timeout');
}

class UnexpectedErrorException extends ApiException {
  final int statusCode;
  UnexpectedErrorException(this.statusCode) : super('Unexpected Error: $statusCode');
}
