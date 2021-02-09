import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/data_repositories/e_commerce_services_repository.dart';
import '../../../core/entities/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final ECommerceServicesRepository eCommerceServicesRepository;

  OrderCubit(this.eCommerceServicesRepository) : super(OrderInitial());

  void createNewOrder(Order newOrder) async{
    bool orderIsCreated = await eCommerceServicesRepository.createNewOrder(newOrder);
    if (orderIsCreated) emit(NewOrderAdded(newOrder));
    else emit(OrderError("error creating your order. Please retry"));
  }

  void markOrderSatisfied(String orderId)  async{
    bool done = await eCommerceServicesRepository.markOrderSatisfied(orderId);
    if (done) emit(OrderSatisfied(orderId));
    else emit(OrderError("internet connection error"));
  }

  void cancelOrder (String orderId) async {
    bool orderisCanceled = await eCommerceServicesRepository.cancelOrder(orderId);
    if (orderisCanceled) emit(OrderCanceled(orderId));
    else emit(OrderError("error canceling your order. Please retry"));
  }
}
