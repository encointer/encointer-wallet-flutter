abstract class ApiResponse<T> {}

class Success<T> extends ApiResponse<T> {
  Success({required this.data});

  T? data;
}

class Failure<T> extends ApiResponse<T> {
  Failure({required this.failureType, this.error});
  FailureType failureType;

  /// if status code is none of 400, 401, 403, 500
  /// we return status code only as error
  /// otherwise, leave it null
  String? error;
}

enum FailureType {
  unknown,
  badRequest,
  noAuthorization,
}
