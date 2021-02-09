import 'package:equatable/equatable.dart';

import '../../core/entities/user.dart';

class UserInfoModel extends Equatable {
  final Map<String, dynamic> map;

  const UserInfoModel(this.map);

  ///map should be empty and ensure map is initialized before assigning it to from().
  UserInfoModel.from(UserInfo user, this.map) {
    map.putIfAbsent('id', ()=> user.id);
    map.putIfAbsent('isCustomer', ()=> user.isCustomer);
    map.putIfAbsent('email', ()=> user.email);
    map.putIfAbsent('firstName', ()=>user.firstName);
    map.putIfAbsent('lastName', ()=>user.lastName);
    map.putIfAbsent('phoneNumber', ()=>user.phoneNumber);
  }

  UserInfo toUserInfo() => UserInfo(
    id: map['id'],
    isCustomer: map['isCustomer'],
    email: map['email'],
    firstName: map['firstName'],
    lastName: map['lastName'],
    phoneNumber: map['phoneNumber']
  );

  @override
  List<Object> get props => [map];
}