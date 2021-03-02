import '../../entities/user.dart';

///TODO: To ensure users have access to the same services both on mobile and web platform,
///concrete implementations should ensure that changes through any of the methods in this repository be persisted 
///both on in-memory data as well as on remote db
abstract class UserAccountServicesRepository{

  ///fetchUserAccount fetches the account info from PGSK server
  Future<Map<String, dynamic>> fetchUserAccount(String userId);

  ///isRegisteredUser allows to customize the UI i.e., display or not to display some features if users is registered
  bool get isRegisteredUser;

  ///changeUserInfo updates the existing information of this user and persists changes locally and on the server
  Future<bool> changeUserInfo (UserInfo userInfo);

  ///register registers a user to PGSK platform 
  ///Returns UserInfo, which now contains the id, if registration is successful, null otherwise
  ///concrete implementation must save user on localPersistenceRepository
  Future<UserInfo> register(UserInfo user);
  
  ///signIn signs existing user into the app. 
  ///Returns an authentication token if provided credential is correct or signIn is successful, null otherwise
  ///concrete implementations must invoke localPersistenceRepository.updateAuthenticationToken to persist the token locally
  Future<String> signIn({String email, String password});

  ///isAuthenticated checks if user has a valid authentication token. 
  ///Returns true if token is valid, false otherwise
  ///concrete implementation should check return value of LocalPersistenceRepository.fetchAuthToken
  ///null return valued indicates user is not authenticated
  Future<bool> isAuthenticated (String token);

  ///signOut signs out the user. 
  ///Note that concrete implementations must destroy the persisted authentication token
  void signOut();

  ///deleteAccount deletes this user's account.
  ///To ensure that no password is persisted locally, customer is prompted to enter registration details,
  ///which is sent to the backend server immediately and clean out from the memory
  ///Concrete implementation should clear out password from memory immediately after use
  ///concrete implementation must check if user isRegisteredUser
  Future<bool> deleteAccount ({String email, String password});
}