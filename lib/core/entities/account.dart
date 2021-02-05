import 'cart.dart';
import 'order.dart';
import 'product.dart';
import 'user.dart';

///To implement Singleton for UserAccount, UserAccount can only be acquired and instantiated through AccountFactory
///Please read the comment on AccountFactory
class _UserAccount {

  ///info is made non-final so user can change their info without altering existing account details
  UserInfo info;
  final Cart cart = Cart();
  final List<Order> pendingOrders = List<Order>();
  final List<Product> wishlist = List<Product>();

  _UserAccount(this.info);
}


/*
* Account should be singleton, since there can be only one account in the mobile app.
* But since there are instance fields to input while creating the singleton, I resorted to using a custom object factory
* AccountFactory ensures that only one instance of Account is present in the app at any point in time
*
* To ensure that UserAccount is not instantiated without the knowledge of AccountFactory, 
* AccountFactory is placed inside the account.dart file and UserAccount is made private
*/

class AccountFactory {
  static _UserAccount _account;

  AccountFactory._();

  ///createUserAccount creates a new account if the 
  _UserAccount createUserAccount(UserInfo info) {
    if (_account != null) return _account;
    else return _UserAccount(info);
  }

  void changeUserInfo(UserInfo info) {
    _account.info = info;
  }

  ///myAccount is null if user has not previously created an account
  ///returns userAccount otherwise
  _UserAccount get userAccount => _account;
}