import '../entities/user.dart';

///TODO: To ensure users have access to the same services both on mobile and web platform,
///concrete implementations should ensure that changes through any of the methods in this repository be persisted 
///both on in-memory data as well as on remote db
abstract class UserAccountServicesRepository{

  ///isRegisteredUser allows to customize the UI i.e., display or not to display some features if users is registered
  bool get isRegisteredUser;

  Future<bool> changeUserInfo (UserInfo userInfo);

  ///register registers a user to PGSK platform 
  ///Returns true if registration attempt is successful, false otherwise
  Future<bool> register(UserInfo user);
  
  ///signIn signs existing user into the app. 
  ///Returns true if provided credential is correct, false otherwise
  Future<bool> signIn({String email, String password});

  ///isAuthenticated checks if user has a valid authentication token. 
  ///Returns true if token is valid, false otherwise
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