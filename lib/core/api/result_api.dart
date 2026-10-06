sealed class ResultApi<T> {
  const ResultApi();
}

class Success<T> extends ResultApi<T> {
  final T data;
  const Success(this.data);
}

class Failure extends ResultApi<Never> {
  final String messageError;
  const Failure(this.messageError);
}
