class NoInternetConnectionException implements Exception {

  final String _message = "No internet connection detected";

  const NoInternetConnectionException();

  String get message => _message;
}