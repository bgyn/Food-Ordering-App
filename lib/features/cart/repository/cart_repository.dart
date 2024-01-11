import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

final cartRepositoryProvider = Provider(
  (ref) => CartRepository(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class CartRepository {
  final FirebaseFirestore _firebaseFirestore;
  CartRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  Stream<UserModel> getUserData(String? uid) {
    return _user.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureEither<UserModel> updateCart({required UserModel user}) async {
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
}
