import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'error_model.dart';
part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) = UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unprocessableEntity(String reason) = UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    List<ErrorModel> listOfErrors = List.from(response?.data).map((e) => ErrorModel.fromJson(e)).toList();
    String allErrors = listOfErrors.map((e) => " ${e.message}  ").toString().replaceAll("(", "").replaceAll(")", "");
    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(allErrors);
      case 404:
        return NetworkExceptions.notFound(allErrors);
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(allErrors);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        var responseCode = statusCode;
        return NetworkExceptions.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions? networkExceptions;
        if (error is DioException) { // DioError → DioException in 5.0+
          switch (error.type) {
            case DioExceptionType.cancel: // "cancel" → "canceled"
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout: // "connectTimeout" → "connectionTimeout"
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.connectionError: // "other" → "connectionError"
              networkExceptions = const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse: // "response" → "badResponse"
              networkExceptions = NetworkExceptions.handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            default: // Handle new or unknown cases
              networkExceptions = const NetworkExceptions.unexpectedError();
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions ;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    if (networkExceptions is NotImplemented) return "Not Implemented";
    if (networkExceptions is RequestCancelled) return "Request Cancelled";
    if (networkExceptions is InternalServerError) return "Internal Server Error";
    if (networkExceptions is NotFound) return networkExceptions.reason;
    if (networkExceptions is ServiceUnavailable) return "Service unavailable";
    if (networkExceptions is MethodNotAllowed) return "Method Not Allowed";
    if (networkExceptions is BadRequest) return "Bad request";
    if (networkExceptions is UnauthorizedRequest) return networkExceptions.reason;
    if (networkExceptions is UnprocessableEntity) return networkExceptions.reason;
    if (networkExceptions is UnexpectedError) return "Employee not found";
    if (networkExceptions is RequestTimeout) return "Connection request timeout";
    if (networkExceptions is NoInternetConnection) return "No internet connection";
    if (networkExceptions is Conflict) return "Error due to a conflict";
    if (networkExceptions is SendTimeout) return "Send timeout in connection with API server";
    if (networkExceptions is UnableToProcess) return "Unable to process the data";
    if (networkExceptions is DefaultError) return networkExceptions.error;
    if (networkExceptions is FormatException) return "Unexpected error occurred";
    if (networkExceptions is NotAcceptable) return "Not acceptable";

    return "Unknown error";
  }

}