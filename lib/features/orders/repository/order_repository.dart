import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/model/order_model.dart';

final orderRepositoryProvider = Provider(
  (ref) => OrderRepository(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class OrderRepository {
  final FirebaseFirestore _firebaseFirestore;
  OrderRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _order =>
      _firebaseFirestore.collection(FirebaseConstants.orderCollection);

  Stream<List<OrderModel>> getUserOrders(String uid) {
    return _order.where('uid', isEqualTo: uid).snapshots().map(
      (event) {
        return event.docs
            .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
      },
    );
  }
}
