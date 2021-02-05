import 'package:equatable/equatable.dart';

//TODO: replace with the actual payment option
enum PaymentOption{
  paypal,
  stripe,
  paystack,
}

class BillingInfo extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}