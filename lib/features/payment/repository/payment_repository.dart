import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/esewa_credential.dart';
import 'package:food_app/core/faliure.dart';
import 'package:fpdart/fpdart.dart';

final paymentRepsitoryProvider = Provider(
  (ref) => PaymentRepsitory(),
);

class PaymentRepsitory {
  Either payWithEsewa(
      {required int price,
      required String productId,
      required String productName}) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: EsewaCredential.clientId,
          secretId: EsewaCredential.secretId,
        ),
        esewaPayment: EsewaPayment(
          productId: productId,
          productName: productName,
          productPrice: price.toString(),
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
          // verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
          throw data;
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
          throw data;
        },
      );
      return right("Payment Successful");
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }
  // void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
  //   var response = await callVerificationApi(result);
  //   if (response.statusCode == 200) {
  //     var map = {'data': response.data};
  //     final sucResponse = EsewaPaymentSuccessResponse.fromJson(map);
  //     debugPrint("Response Code => ${sucResponse.data}");
  //     if (sucResponse.data[0].transactionDetails.status == 'COMPLETE') {
  //      //TODO Handle Txn Verification Success
  //       return;
  //     }
  //     //TODO Handle Txn Verification Failure
  //   } else {
  //     //TODO Handle Txn Verification Failure
  //   }
  // }
}
