import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/favourite/repository/favourite_repository.dart';
import 'package:food_app/model/favourite_model.dart';

final userFavouriteProvider = StateProvider<FavouriteModel?>((ref) => null);

final favouriteControllerProvider = StateNotifierProvider(
  (ref) => FavouriteController(
      favouriteRepository: ref.read(favouriteRepositoryProvider), ref: ref),
);

class FavouriteController extends StateNotifier<bool> {
  final FavouriteRepository _favouriteRepository;
  final Ref _ref;
  FavouriteController({
    required FavouriteRepository favouriteRepository,
    required Ref ref,
  })  : _favouriteRepository = favouriteRepository,
        _ref = ref,
        super(false);

  void intializeFavourite(BuildContext context, String uid) async {
    final res = await _favouriteRepository.intializeFavourite(uid);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => _ref.read(userFavouriteProvider.notifier).update((state) => r),
    );
  }

  void updateFavourite(BuildContext context, String uid, String pid) async {
    state = true;
    FavouriteModel favModel = _ref.read(userFavouriteProvider)!;
    List<String> updatedPid = List.from(favModel.pid);
    int index = favModel.pid.indexWhere((element) => element == pid);
    if (index != -1) {
      updatedPid.remove(pid);
      favModel = favModel.copyWith(pid: updatedPid);
    } else {
      updatedPid.add(pid);
      favModel = favModel.copyWith(pid: updatedPid);
    }
    final res = await _favouriteRepository.updateFavourite(uid, favModel);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => _ref.read(userFavouriteProvider.notifier).update((state) => r),
    );
  }
}
