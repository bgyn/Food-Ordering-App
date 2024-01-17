import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/auth/repository/auth_repository.dart';
import 'package:food_app/model/user_model.dart';
import 'package:routemaster/routemaster.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider), ref: ref),
);

final authStateChangeProvider = StreamProvider(
    (ref) => ref.read(authControllerProvider.notifier).authStateChange);

final getUserInfoProvider = FutureProvider(
    (ref) => ref.watch(authControllerProvider.notifier).getcurrentUserInfo());

final userProvider = StateProvider<UserModel?>((ref) => null);

final getUserProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Future<UserModel?> getcurrentUserInfo() async {
    UserModel? user = await _authRepository.getCurrentUserInfo();
    return user;
  }

  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void sigUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final user = await _authRepository.siginInWithEmail(
        email: email, password: password);
    state = false;
    user.fold(
      (l) {
        showSnackBar(context, l.message);
      },
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }

  void loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final user = await _authRepository.loginWithEmail(
      email: email,
      password: password,
    );
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }

  void logOut() {
    _ref.read(userProvider.notifier).update((state) => null);
    _authRepository.logOut();
  }

  void resetPasscode({
    required String email,
    required BuildContext context,
  }) async {
    await _authRepository.resetPasscode(email: email).then(
          (result) => result.fold((l) => showSnackBar(context, l.message), (r) {
            showSnackBar(
              context,
              'Password reset link send to your email!',
            );
            Routemaster.of(context).pop();
          }),
        );
  }
}
