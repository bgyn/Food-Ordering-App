import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/payment_constant.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/checkout/widget/payment_method_card.dart';
import 'package:food_app/features/payment/repository/payment_repository.dart';
import 'package:food_app/model/payment_model.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

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
      required String orderId,
      required BuildContext context}) async {
    PaymentModel paymentModel;
    paymentModel = PaymentModel(
      paymentId: const Uuid().v4(),
      orderId: orderId,
      paymentMethod: _ref.read(paymentMethodProvider),
      amount: price,
      status: PaymentStatus.processing,
    );
    final res = _paymentRepsitory.payWithEsewa(
        price: price, orderId: orderId, productName: productName);
    _paymentRepsitory.initializePayment(paymentModel);
    res.fold((l) {
      showSnackBar(context, l.toString());
    }, (r) {
      Routemaster.of(context).push('/payment-successfull');
    });
  }
}
