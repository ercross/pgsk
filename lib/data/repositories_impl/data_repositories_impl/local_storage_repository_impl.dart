import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/repositories/data_repositories/local_storage_repository.dart';


class LocalStorageRepositoryImpl extends LocalStorageRepository{
  
  final FlutterSecureStorage _securedStorage = FlutterSecureStorage();
  static const String apiUrl = ""; //TODO: fix actual apiUrl here

  //To improve security, the authentication token is not stored in a variable
  @override
  Future<String> get authToken async =>  await _securedStorage.read(key: 'authToken');

  @override
  void updateAuthenticationToken(String value) {
    _securedStorage.write(key: 'authToken', value: value);
  }

  @override
  void deleteUserId() {
    _securedStorage.delete(key: 'userId');
  }

  @override
  Future<String> get fetchUserId async => await _securedStorage.read(key: 'userId');

  @override
  void saveUserId(String newUserId) {
    _securedStorage.write(key: 'userId', value: newUserId);
  } 
}