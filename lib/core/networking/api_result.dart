import 'network_exceptions.dart';

abstract class ApiResult<T> {
  const ApiResult();

  R when<R>({
    required R Function(T data) success,
    required R Function(NetworkExceptions error) failure,
  });
}

class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(NetworkExceptions error) failure,
  }) {
    return success(data);
  }
}

class Failure<T> extends ApiResult<T> {
  final NetworkExceptions error;

  const Failure(this.error);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(NetworkExceptions error) failure,
  }) {
    return failure(error);
  }
}