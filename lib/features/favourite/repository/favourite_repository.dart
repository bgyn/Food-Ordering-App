import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/firebase_constant.dart';
import 'package:food_app/core/faliure.dart';
import 'package:food_app/core/provider/firebase_provider.dart';
import 'package:food_app/core/typedef.dart';
import 'package:food_app/model/favourite_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

final favouriteRepositoryProvider = Provider((ref) => FavouriteRepository(
    firebaseFirestore: ref.read(firebaseFirestoreProvider)));

class FavouriteRepository {
  final FirebaseFirestore _firebaseFirestore;
  FavouriteRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _favourite =>
      _firebaseFirestore.collection(FirebaseConstants.favouriteCollection);

  FutureEither<FavouriteModel> intializeFavourite(String uid) async {
    try {
      FavouriteModel favModel;
      QuerySnapshot favouriteQuery =
          await _favourite.where('uid', isEqualTo: uid).get();
      if (favouriteQuery.docs.isEmpty) {
        favModel = FavouriteModel(
          fid: const Uuid().v4(),
          uid: uid,
          pid: [],
        );
        _favourite.doc(favModel.fid).set(favModel.toMap());
      } else {
        favModel = await getUserFavourite(uid).first;
      }
      return right(favModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  FutureEither<FavouriteModel> updateFavourite(
      String uid, FavouriteModel favouriteModel) async {
    try {
      FavouriteModel favModel;
      await _favourite.doc(favouriteModel.fid).update(favouriteModel.toMap());
      favModel = await getUserFavourite(uid).first;
      return right(favModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Faliure(e.toString()));
    }
  }

  Stream<FavouriteModel> getUserFavourite(String uid) {
    return _favourite.where('uid', isEqualTo: uid).snapshots().map((event) =>
        event.docs
            .map(
                (e) => FavouriteModel.fromMap(e.data() as Map<String, dynamic>))
            .first);
  }
}
