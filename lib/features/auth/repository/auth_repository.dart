import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/user_model.dart';
import 'package:fpdart/fpdart.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      firebaseAuth: ref.read(firebaseAuthProvider),
      firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ));

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  AuthRepository(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firebaseFirestore})
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<UserModel> getCurrentUserInfo() async {
    UserModel user;
    final userInfo = await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    user = UserModel.fromMap(userInfo.data() as Map<String, dynamic>);
    return user;
  }

  Stream<UserModel> getUserData(String? uid) {
    return _user.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureEither<UserModel> siginInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel;
      if (credential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          uid: credential.user!.uid,
          email: email,
          cart: [],
        );
        await _user.doc(credential.user!.uid).set(userModel.toMap());
      } else {
        return left(Faliure('Email is already taken'));
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw e.message!;
      } else {
        throw e.message!;
      }
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureEither<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel;
      if (credential.additionalUserInfo!.isNewUser) {
        throw 'No user found';
      } else {
        userModel = await getUserData(_firebaseAuth.currentUser!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw e.message!;
      } else if (e.code == 'wrong-password') {
        throw e.message!;
      } else {
        throw e.message!;
      }
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  void logOut() async {
    await _firebaseAuth.signOut();
  }
}
