import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/esewa_credential.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/payment_model.dart';
import 'package:fpdart/fpdart.dart';

final paymentRepsitoryProvider = Provider(
  (ref) => PaymentRepsitory(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class PaymentRepsitory {
  final FirebaseFirestore _firebaseFirestore;
  PaymentRepsitory({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  Either payWithEsewa(
      {required int price,
      required String orderId,
      required String productName}) {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: EsewaCredential.clientId,
          secretId: EsewaCredential.secretId,
        ),
        esewaPayment: EsewaPayment(
          productId: orderId,
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
      return right('Payment Successfull');
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  // void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
  //   var response = await callVerificationApi(result);
  //   if (response.statusCode == 200) {
  //     var map = {'data': response.data};
  //     final sucResponse = EsewaPaymentSuccessResponse.fromJson(map as <>);
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

  FutureVoid initializePayment(PaymentModel paymentModel) async {
    try {
      return right(
          _payment.doc(paymentModel.paymentId).set(paymentModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  CollectionReference get _payment =>
      _firebaseFirestore.collection(FirebaseConstants.paymentCollection);
}
