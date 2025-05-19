typedef DSResultAsyncCallback<T, R> = Future<DSResult<R>> Function(T value);

class DSResult<T> {
  final T? data;
  final String? errorMessage;
  final bool isSuccess;
  const DSResult.success({this.data})
      : errorMessage = null,
        isSuccess = true;
  const DSResult.error({this.errorMessage})
      : data = null,
        isSuccess = false;
}
