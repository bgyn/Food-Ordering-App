import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/cart/controller/cart_controller.dart';
import 'package:food_app/features/checkout/repository/checkout_repository.dart';
import 'package:food_app/model/new_order_model.dart';
import 'package:uuid/uuid.dart';

final currentOrderIdProvider = StateProvider<String?>((ref) => null);

final checkoutConrollerProvider = StateNotifierProvider(
  (ref) => CheckoutConroller(
      checkoutRepository: ref.read(checkoutRepositoryProvider), ref: ref),
);

final totalAmountPovider = StateProvider<int>((ref) => 0);

class CheckoutConroller extends StateNotifier<bool> {
  final CheckoutRepository _checkoutRepository;
  final Ref _ref;
  CheckoutConroller({
    required CheckoutRepository checkoutRepository,
    required Ref ref,
  })  : _checkoutRepository = checkoutRepository,
        _ref = ref,
        super(false);

  void placeOrder({
    required BuildContext context,
    required String orderId,
    required int orderTotal,
    required String orderStatus,
    required String deliveryMethod,
    required DateTime createdAt,
  }) async {
    state = true;
    final user = _ref.read(userProvider)!;
    final cartItem = _ref.read(cartProvider)!.item;
    List<String> productId = <String>[];
    for (final item in cartItem) {
      productId.add(item.pid);
    }
    final OrdersModel order = OrdersModel(
      orderId: const Uuid().v4(),
      userId: user.uid,
      orderTotal: orderTotal,
      orderStatus: orderStatus,
      deliveryMethod: deliveryMethod,
      createdAt: createdAt,
      productId: productId,
    );
    final res = await _checkoutRepository.placeOrder(order: order);
    state = false;
    res.fold(
      (l) {
        showSnackBar(context, l.message);
      },
      (r) {
        _ref.read(cartControllerProvider.notifier).clearCart(context: context);
      },
    );
  }

  void getAmount() {
    final cartItems = _ref.read(cartProvider)!.item;
    if (cartItems.isEmpty) {
      _ref.read(totalAmountPovider.notifier).update((state) => 0);
    } else {
      final amount = _checkoutRepository.getAmount(cartItems);
      _ref.read(totalAmountPovider.notifier).update((state) => amount);
    }
  }
}
