import 'package:flutter/cupertino.dart';
import 'package:pgsk/core/data_repositories/user_account_services_repository.dart';

import '../../controllers/providers/cart.dart';
import '../../core/entities/order.dart';
import '../../core/entities/product.dart';
import '../../core/entities/user.dart';



///So as to implement Singleton for UserAccount, UserAccount can only be acquired and instantiated through AccountFactory
///Please read the comment on AccountFactory
class _UserAccount{

  ///info is made non-final so user can change their info without altering existing account details
  UserInfo info;
  final Cart cart;
  final List<Order> orders;
  final List<Product> wishlist;

  ///UserAccount is the singleton account associated with this user. 
  ///It is automatically instantiated when the app is started for the first time
  ///At that point, this.info is null
  _UserAccount._(this.info, {this.cart, this.orders, this.wishlist});

  //fromMap is placed here rather than inside a UserAccountModel class because _userAccount is private
  _UserAccount.from(Map<String, dynamic> json) :
      info = json['info'],
      cart = json['cart'],
      orders = json['orders'],
      wishlist = json['wishlist'];
    
}


/*
* Account should be singleton, since there can be only one account in the mobile app.
* But because there are instance fields to input while creating the singleton, I resorted to using a custom object factory
* AccountFactory ensures that only one instance of Account is present in the app at any point in time
*
* To ensure that UserAccount is not instantiated without the knowledge of AccountFactory, 
* AccountFactory is placed inside the account.dart file and UserAccount is made private
*/

class AccountFactory with ChangeNotifier{

  ///account contains the userAccount associated with this user
  ///Note that account may be null, which indicates user is not registered 
  ///or if app is unable to fetch accountData from PGSK server
  static _UserAccount account;

  final UserAccountServicesRepository userAccountServicesRepository;
  AccountFactory._(this.userAccountServicesRepository);

  //to ensure that only one AccountFactory is present in memory at any point in time, 
  //AccountFactory can only be obtained through this instance
  static AccountFactory getInstance(UserAccountServicesRepository userAccountServicesRepository) 
      => AccountFactory._(userAccountServicesRepository);

  ///createUserAccount creates a new account. 
  void createUserAccount(UserInfo info, {Cart cart, List<Order> orders, List<Product> wishlist}) {
    account = _UserAccount._(info, cart: cart ?? Cart(), 
                      orders: orders ?? new List<Order>(), 
                      wishlist: wishlist ?? new List<Product>());
    notifyListeners();
  }

  ///fetchAccountData fetches this user's account data from PGSK server
  ///returns null if userId is empty or null
  ///Call AccountFactory.account to fetch the user account data in memory
  void fetchAccountData(String userId) async {
    if (userId == null || userId.isEmpty) return null;
    Map<String, dynamic> accountData = await userAccountServicesRepository.fetchUserAccount(userId);
    account = _UserAccount.from(accountData);
    notifyListeners();
  }

  ///changeUserInfo changes account.userInfo for this user
  void changeUserInfo(UserInfo userInfo) {
    account.info = userInfo;
    notifyListeners();
  }
}