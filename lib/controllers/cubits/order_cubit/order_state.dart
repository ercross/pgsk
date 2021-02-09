part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class NewOrderAdded extends OrderState {
  final Order newOrder;

  const NewOrderAdded(this.newOrder);

  @override
  List<Object> get props => [newOrder];
}

class OrderCanceled extends OrderState {
  final String orderId;

  const OrderCanceled(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class OrderSatisfied extends OrderState {
  final String orderId;

  const OrderSatisfied(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class OrderError extends OrderState {
  final String message;

  ///OrderError is emitted for any failed operation involving an order
  const OrderError(this.message);

  @override
  List<Object> get props => [message];
}