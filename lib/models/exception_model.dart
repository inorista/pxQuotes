class ExceptionModel implements Exception {
  final String msg;
  const ExceptionModel(this.msg);
  @override
  String toString() => "Exception: $msg";
}
