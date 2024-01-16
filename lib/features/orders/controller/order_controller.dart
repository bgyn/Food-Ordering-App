import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/orders/repository/order_repository.dart';
import 'package:food_app/model/order_model.dart';

final orderControllerProvider = StateNotifierProvider((ref) => OrderController(
    orderRepository: ref.read(orderRepositoryProvider), ref: ref));

final getUserOrderProvider = StreamProvider.family((ref, String uid) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.getUserOrder(uid);
});

class OrderController extends StateNotifier<bool> {
  final OrderRepository _orderRepository;
  final Ref _ref;
  OrderController({required OrderRepository orderRepository, required Ref ref})
      : _orderRepository = orderRepository,
        _ref = ref,
        super(false);

  Stream<List<OrderModel>> getUserOrder(String uid) {
    return _orderRepository.getUserOrders(uid);
  }
}
