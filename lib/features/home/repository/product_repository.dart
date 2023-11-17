import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/model/product_model.dart';

final productRepositoryProvider = Provider((ref) =>
    ProductRepository(firebaseFirestore: ref.read(firebaseFirestoreProvider)));

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProductRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _product =>
      _firebaseFirestore.collection(FirebaseConstants.productCollection);

  Stream<List<Product>> fetchAllProduct() {
    return _product.snapshots().map(
          (event) => event.docs
              .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
              .toList(),
        );
  }
}
