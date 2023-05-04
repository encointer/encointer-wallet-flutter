abstract class ApiResponse<T> {}

class Success<T> extends ApiResponse<T> {
  Success({required this.data});

  T? data;
}

class Failure<T> extends ApiResponse<T> {
  Failure({required this.error});

  String error;
}
