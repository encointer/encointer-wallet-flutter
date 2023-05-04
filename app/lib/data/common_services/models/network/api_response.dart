abstract class ApiResponse<T> {}

class Success<T> extends ApiResponse<T> {
  T? data;

  Success({required this.data});
}

class Failure<T> extends ApiResponse<T> {
  String error;

  Failure({required this.error});
}
