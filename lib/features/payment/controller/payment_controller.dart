import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/payment_constant.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/checkout/controller/checkout_controller.dart';
import 'package:food_app/features/payment/repository/payment_repository.dart';
import 'package:food_app/model/order_model.dart';

final paymentControllerProvider = StateNotifierProvider(
  (ref) => PaymentController(
    paymentRepsitory: ref.read(paymentRepsitoryProvider),
    ref: ref,
  ),
);

class PaymentController extends StateNotifier<bool> {
  final PaymentRepsitory _paymentRepsitory;
  final Ref _ref;
  PaymentController(
      {required PaymentRepsitory paymentRepsitory, required Ref ref})
      : _paymentRepsitory = paymentRepsitory,
        _ref = ref,
        super(false);

  void payWithEsewa(
      {required int price,
      required String productName,
      required String productId,
      required OrderModel orderModel,
      required BuildContext context}) async {
    OrderModel order;
    final res = _paymentRepsitory.payWithEsewa(
        price: price, productId: productId, productName: productName);
    res.fold((l) {
      order = orderModel.copyWith(
        paymentStatus: PaymentStatus.pending,
      );
      _ref.read(checkoutConrollerProvider.notifier).updateOrder(context, order);
      showSnackBar(context, l.toString());
    }, (r) {
      order = orderModel.copyWith(paymentStatus: PaymentStatus.completed);
      _ref.read(checkoutConrollerProvider.notifier).updateOrder(context, order);
    });
  }
}
