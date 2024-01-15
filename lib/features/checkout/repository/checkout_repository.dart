import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/order_model.dart';
import 'package:fpdart/fpdart.dart';

final checkoutRepositoryProvider = Provider(
  (ref) => CheckoutRepository(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class CheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;
  CheckoutRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _order =>
      _firebaseFirestore.collection(FirebaseConstants.orderCollection);

  CollectionReference get _product =>
      _firebaseFirestore.collection(FirebaseConstants.productCollection);

  FutureVoid placeOrder({required OrderModel order}) async {
    try {
      return right(_order.doc(order.orderId).set(order.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Faliure(e.toString()),
      );
    }
  }

  FutureEither<int> getAmount(List<String> pid) async {
    try {
      int totalamount = 0;
      for (final element in pid) {
        DocumentSnapshot productSnapshot = await _product.doc(element).get();
        if (productSnapshot.exists) {
          int price = productSnapshot['price'];
          totalamount += price;
        } else {
          throw '$pid product missing';
        }
      }
      return right(totalamount);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureVoid updateOrder(OrderModel order) async {
    try {
      return right(_order.doc(order.orderId).update(order.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureVoid updatePaymentStatus(String orderId, String paymentStatus) async {
    try {
      return right(
          _order.doc(orderId).update({'paymentStatus': paymentStatus}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }
}
