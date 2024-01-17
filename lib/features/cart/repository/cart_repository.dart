import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

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

  CollectionReference get _cart =>
      _firebaseFirestore.collection(FirebaseConstants.cartCollection);

  Stream<UserModel> getUserData(String? uid) {
    return _user.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureVoid clearCart(CartModel updateCart) async {
    try {
      return right(_cart.doc(updateCart.cid).update(updateCart.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureEither<CartModel> createCart({required String uid}) async {
    try {
      CartModel cartModel;
      QuerySnapshot cartQuery = await _cart.where('uid', isEqualTo: uid).get();
      if (cartQuery.docs.isEmpty) {
        cartModel = CartModel(
          cid: const Uuid().v4(),
          uid: uid,
          item: <CartItem>[],
        );
        await _cart.doc(cartModel.cid).set(cartModel.toMap());
      } else {
        cartModel = await getUserCart(uid).first;
      }
      return right(cartModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureVoid addTocart(CartModel updatedCart) async {
    try {
      return right(_cart.doc(updatedCart.cid).update(updatedCart.toMap()));
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

  Stream<CartModel> getUserCart(String uid) {
    return _cart.where('uid', isEqualTo: uid).snapshots().map((event) {
      return event.docs
          .map((e) => CartModel.fromMap(e.data() as Map<String, dynamic>))
          .first;
    });
  }

  FutureVoid deleteFromCart(CartModel updatedCart) async {
    try {
      return right(_cart.doc(updatedCart.cid).update(updatedCart.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureVoid updateProductQuantity(CartModel updatedCart) async {
    try {
      return right(_cart.doc(updatedCart.cid).update(updatedCart.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }
}
