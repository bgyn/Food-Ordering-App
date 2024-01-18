import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/orders/repository/order_repository.dart';
import 'package:food_app/model/new_order_model.dart';

final orderControllerProvider = StateNotifierProvider((ref) =>
    OrderController(orderRepository: ref.read(orderRepositoryProvider)));

final getUserOrderProvider = StreamProvider.family((ref, String uid) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.getUserOrder(uid);
});

class OrderController extends StateNotifier<bool> {
  final OrderRepository _orderRepository;
  OrderController({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(false);

  Stream<List<OrdersModel>> getUserOrder(String uid) {
    return _orderRepository.getUserOrders(uid);
  }
}
