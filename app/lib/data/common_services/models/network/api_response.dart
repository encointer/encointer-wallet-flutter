// abstract class ApiResponse<T> {}

// class Success<T> extends ApiResponse<T> {
//   Success({required this.data});

//   T? data;
// }

// class Failure<T> extends ApiResponse<T> {
//   Failure({required this.failureType, this.error});
//   FailureType failureType;

//   /// Contains the http status code for unknown errors, otherwise it is null.
//   String? error;
// }

// enum FailureType {
//   /// Represents http error 400
//   badRequest,

//   /// Represents http errors 401, 403
//   noAuthorization,
//   // Unknown error
//   unknown,
// }
