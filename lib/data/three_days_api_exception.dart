class ThreeDaysApiException implements Exception {
  final String message;

  ThreeDaysApiException(this.message);

  @override
  String toString() {
    return 'ThreeDaysApiException{message: $message}';
  }
}
