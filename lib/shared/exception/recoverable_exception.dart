class RecoverableException implements Exception{
  const  RecoverableException(this.message);

  final String message;

  @override
  String toString() => "RecoverableException: $message";
}
