import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserInfo extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final int phoneNumber;

  ///isCustomers is true if user has previously purchased a product on PGSK platform
  final bool isCustomer;

  const UserInfo({
    this.id,
    @required this.isCustomer,
    @required this.email, 
    @required this.firstName, 
    @required this.lastName, 
    @required this.phoneNumber}); 

  @override
  List<Object> get props => [id, 
                             email, 
                             firstName, 
                             lastName, 
                             phoneNumber
  ];

}