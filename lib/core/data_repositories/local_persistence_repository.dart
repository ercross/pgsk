abstract class LocalPersistenceRepository {

  ///fetchAuthToken fetches the authentication token from the local persistence storage
  Future<String> fetchAuthToken();

  ///fetchServerApiUrl fetches the url of the web server fronting GPSK database
  Future<String> fetchServerApiUrl();
}