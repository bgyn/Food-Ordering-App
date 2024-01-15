import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/payment_constant.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/cart/controller/cart_controller.dart';
import 'package:food_app/features/checkout/repository/checkout_repository.dart';
import 'package:food_app/features/checkout/widget/delivery_method_card.dart';
import 'package:food_app/features/checkout/widget/payment_method_card.dart';
import 'package:food_app/model/order_model.dart';
import 'package:routemaster/routemaster.dart';

final currentOrderIdProvider = StateProvider<String?>((ref) => null);

final checkoutConrollerProvider = StateNotifierProvider((ref) =>
    CheckoutConroller(
        checkoutRepository: ref.read(checkoutRepositoryProvider), ref: ref));

final totalAmountPovider = StateProvider<int?>((ref) => null);

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
    required List<String> productId,
    required String orderStatus,
    required DateTime timestamp,
    required int amount,
    required String uid,
  }) async {
    state = true;
    final user = _ref.read(userProvider)!;
    final OrderModel order = OrderModel(
      productId: productId,
      orderStatus: orderStatus,
      paymentMethod: _ref.read(paymentMethodProvider),
      deliveryMethod: _ref.read(deliverMethodProvider),
      paymentStatus: PaymentStatus.pending,
      timestamp: timestamp,
      amount: amount,
      uid: user.uid,
    );
    final res = await _checkoutRepository.placeOrder(order: order);
    state = false;
    res.fold(
      (l) {
        showSnackBar(context, l.message);
      },
      (r) {
        _ref.read(cartControllerProvider.notifier).clearCart(context: context);
        _ref
            .read(currentOrderIdProvider.notifier)
            .update((state) => order.orderId);
      },
    );
  }

  void getAmount(BuildContext context) async {
    final user = _ref.read(userProvider)!;
    final res = await _checkoutRepository.getAmount(user.cart);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(totalAmountPovider.notifier).update((state) => r);
    });
  }

  void updateOrder(BuildContext context, OrderModel order) async {
    final res = await _checkoutRepository.updateOrder(order);
    res.fold((l) => showSnackBar(context, l.message), (r) => {});
  }

  void updatePaymentStatus(
      BuildContext context, String orderId, String paymentStatus) async {
    final res =
        await _checkoutRepository.updatePaymentStatus(orderId, paymentStatus);
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }
}
