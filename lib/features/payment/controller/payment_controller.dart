import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/payment_constant.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/checkout/controller/checkout_controller.dart';
import 'package:food_app/features/payment/repository/payment_repository.dart';
import 'package:routemaster/routemaster.dart';

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
      required String orderId,
      required BuildContext context}) async {
    final res = _paymentRepsitory.payWithEsewa(
        price: price, productId: productId, productName: productName);
    res.fold((l) {
      showSnackBar(context, l.toString());
    }, (r) {
      _ref
          .read(checkoutConrollerProvider.notifier)
          .updatePaymentStatus(context, orderId, PaymentStatus.completed);
      Routemaster.of(context).pop();
    });
  }
}
