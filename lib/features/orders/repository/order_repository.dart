import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/model/new_order_model.dart';

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

  Stream<List<OrdersModel>> getUserOrders(String uid) {
    return _order
        .where('userId', isEqualTo: uid)
        .where('orderStatus', isNotEqualTo: 'delivered')
        .snapshots()
        .map(
      (event) {
        return event.docs
            .map((e) => OrdersModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
      },
    );
  }

  Stream<List<OrdersModel>> getUserDeliveredOrder(String uid) {
    return _order
        .where('userId', isEqualTo: uid)
        .where('orderStatus', isEqualTo: 'delivered')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => OrdersModel.fromMap(e.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }
}
