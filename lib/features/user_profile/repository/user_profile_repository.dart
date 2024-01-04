import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

final userProfileRepositoryProvider = Provider(
  (ref) => UserProfileRepository(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class UserProfileRepository {
  final FirebaseFirestore _firebaseFirestore;
  UserProfileRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  FutureVoid editUserProfile(UserModel userModel) async {
    try {
      return right(_user.doc(userModel.uid).update(userModel.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Faliure(
          e.toString(),
        ),
      );
    }
  }

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);
}
