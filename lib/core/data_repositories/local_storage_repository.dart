abstract class LocalStorageRepository {

  ///fetchAuthToken fetches the authentication token from the local persistence storage
  ///returns null if user has not been authenticated before
  Future<String> get authToken;

  ///updateAuthenticationToken updates the local copy of the authentication token as value
  ///The web server is implemented such that GPSK mobile apps need to re-authenticate every 3 months
  ///Kindly check the server documentation for detailed info
  void updateAuthenticationToken(String value);

  Future<String> get fetchUserId;

  ///deleteUserId must be called once user initiates deleteAccount.
  ///This prevents user from viewing info of the new account the deleted userId would be allocated to
  void deleteUserId();

  ///saveUserId saves the userId of this user. Once saved cannot be modified. 
  ///Invoke deleteUserId to delete the saved userId in the event the user deletes their account
  void saveUserId(String newUserId);
}