class ServerOfflineException implements Exception {
  final String message;
  ServerOfflineException([this.message = ""]);

  @override
  String toString() {
    return message;
  }
}
