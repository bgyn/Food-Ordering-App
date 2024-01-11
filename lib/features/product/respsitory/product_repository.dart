import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProductRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _product =>
      _firebaseFirestore.collection(FirebaseConstants.productCollection);

  Stream<UserModel> getUserData(String? uid) {
    return _user.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<List<Product>> fetchFilterProduct({required String query}) {
    return _product
        .where('category', isEqualTo: query)
        .snapshots()
        .map((event) {
      return event.docs
          .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Stream<List<Product>> fetchAllProduct() {
    return _product.snapshots().map((event) {
      return event.docs
          .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Stream<List<Product>> searchProduct(String query) {
    return _product
        .where('name',
            isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
            isLessThan: query.isEmpty
                ? null
                : query.substring(0, query.length - 1) +
                    String.fromCharCode(
                      query.codeUnitAt(query.length - 1) + 1,
                    ))
        .snapshots()
        .map((event) {
      List<Product> searchlist = [];
      for (final product in event.docs) {
        searchlist.add(Product.fromMap(product.data() as Map<String, dynamic>));
      }
      return searchlist;
    });
  }

  Stream<Product> getProductById(String pid) {
    return _product
        .doc(pid)
        .snapshots()
        .map((event) => Product.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureEither<UserModel> addToCart({required UserModel user}) async {
    try {
      _user.doc(user.uid).update(user.toMap());
      final userModel = await getUserData(user.uid).first;
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);
}
