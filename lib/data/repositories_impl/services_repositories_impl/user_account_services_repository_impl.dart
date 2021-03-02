import 'package:http/http.dart' as http;

import '../../../core/entities/user.dart';
import '../../../core/repositories/services_repository/user_account_services_repository.dart';
import '../data_repositories_impl/local_storage_repository_impl.dart';


class UserAccountServicesRepositoryImpl extends UserAccountServicesRepository {
  final String accountApi = LocalStorageRepositoryImpl.apiUrl + "/account";

  @override
  Future<bool> changeUserInfo(UserInfo userInfo) {
    
  }

  @override
  Future<bool> deleteAccount({String email, String password}) async {
    final http.Response response = await http.delete(accountApi, headers: {'email': email,
      'password': password});
    
  }

  @override
  Future<Map<String, dynamic>> fetchUserAccount (String userId) async {
    final http.Response response = await http.get(accountApi);
  }

  @override
  Future<bool> isAuthenticated(String token) {
    
  }

  @override
  bool get isRegisteredUser => throw UnimplementedError();

  @override
  Future<UserInfo> register(UserInfo user) {
    
  }

  @override
  Future<String> signIn({String email, String password}) {
    
  }

  @override
  void signOut() {
    
  }

}