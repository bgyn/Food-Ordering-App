import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/cart/repository/cart_repository.dart';
import 'package:food_app/model/user_model.dart';

final cartControllerProvider = StateNotifierProvider((ref) => CartController(
      cartRepository: ref.watch(cartRepositoryProvider),
      ref: ref,
    ));

class CartController extends StateNotifier<bool> {
  final CartRepository _cartRepository;
  final Ref _ref;
  CartController({required CartRepository cartRepository, required Ref ref})
      : _cartRepository = cartRepository,
        _ref = ref,
        super(false);

  void deleteFromCart(
      {required String pid, required BuildContext context}) async {
    UserModel user = _ref.read(userProvider)!;
    List<String> updateCart = List.from(user.cart)..remove(pid);
    user = user.copyWith(cart: updateCart);
    final result = await _cartRepository.updateCart(user: user);
    result.fold(
      (l) => showSnackBar(context, l.toString()),
      (r) {
        _ref.read(userProvider.notifier).update((state) => r);
        showSnackBar(context, 'Deleted');
      },
    );
  }

  void clearCart({required BuildContext context}) async {
    UserModel user = _ref.read(userProvider)!;
    user = user.copyWith(cart: []);
    final result = await _cartRepository.updateCart(user: user);
    result.fold(
      (l) => showSnackBar(context, l.toString()),
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }
}
