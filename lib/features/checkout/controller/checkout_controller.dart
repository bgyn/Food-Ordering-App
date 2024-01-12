import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/payment_constant.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/checkout/repository/checkout_repository.dart';
import 'package:food_app/model/order_model.dart';

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
    required String paymentMethod,
    required String paymentStaus,
    required DateTime timestamp,
    required Double amount,
    required String uid,
  }) async {
    state = true;
    final user = _ref.read(userProvider)!;
    final OrderModel order = OrderModel(
      productId: productId,
      orderStatus: orderStatus,
      paymentMethod: paymentMethod,
      paymentStatus: PaymentStatus.pending,
      timestamp: timestamp,
      amount: amount,
      uid: user.uid,
    );
    final res = await _checkoutRepository.placeOrder(order: order);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, "Order Placed Successfully!"),
    );
  }
}
