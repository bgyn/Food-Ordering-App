import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/provider/storage_repository.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/user_profile/repository/user_profile_repository.dart';
import 'package:food_app/model/user_model.dart';
import 'package:routemaster/routemaster.dart';

final userProfileControllerProvider = StateNotifierProvider(
  (ref) {
    return UserProfileController(
      userProfileRepository: ref.read(userProfileRepositoryProvider),
      ref: ref,
      storageRepository: ref.read(storageRepositoryProvider),
    );
  },
);

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  UserProfileController(
      {required UserProfileRepository userProfileRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _userProfileRepository = userProfileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void editProfile({
    required File? profileFile,
    required String name,
    required String phoneNumber,
    required String address,
    required BuildContext context,
  }) async {
    UserModel userModel = _ref.read(userProvider)!;
    state = true;
    if (profileFile != null) {
      final res = await _storageRepository.storeField(
        path: 'users/profile',
        id: userModel.uid,
        file: profileFile,
      );
      res.fold((l) => showSnackBar(context, l.message), (r) {
        userModel = userModel.copyWith(profilePic: r);
      });
    }
    if (name != userModel.name) {
      userModel = userModel.copyWith(name: name);
    }
    if (phoneNumber != userModel.phoneNo) {
      userModel = userModel.copyWith(phoneNo: phoneNumber);
    }

    if (address != userModel.address) {
      userModel = userModel.copyWith(address: address);
    }
    state = false;
    final result = await _userProfileRepository.editUserProfile(userModel);
    result.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        Routemaster.of(context).pop;
      },
    );
  }
}
