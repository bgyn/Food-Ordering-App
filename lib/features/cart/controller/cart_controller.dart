import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/cart/repository/cart_repository.dart';
import 'package:food_app/model/cart_model.dart';

final cartControllerProvider = StateNotifierProvider((ref) => CartController(
      cartRepository: ref.watch(cartRepositoryProvider),
      ref: ref,
    ));

final cartProvider = StateProvider<CartModel?>((ref) => null);

class CartController extends StateNotifier<bool> {
  final CartRepository _cartRepository;
  final Ref _ref;
  CartController({required CartRepository cartRepository, required Ref ref})
      : _cartRepository = cartRepository,
        _ref = ref,
        super(false);

  void deleteFromCart({
    required String pid,
    required BuildContext context,
  }) async {
    state = true;
    CartModel cart = _ref.read(cartProvider)!;
    cart = cart.copyWith(
      item: cart.item.where((element) => element.pid != pid).toList(),
    );
    state = false;
    final res = await _cartRepository.deleteFromCart(cart);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        _ref.read(cartProvider.notifier).update((state) => cart);
        showSnackBar(context, 'Deleted From cart');
      },
    );
  }

  void clearCart({required BuildContext context}) async {
    CartModel cart = _ref.read(cartProvider)!;
    cart = cart.copyWith(
      item: [],
    );
    final res = await _cartRepository.clearCart(cart);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        _ref.read(cartProvider.notifier).update((state) => cart);
      },
    );
  }

  void addToCart(
      {required BuildContext context,
      required String pid,
      required int price,
      required int quantity}) async {
    state = true;
    CartModel cart = _ref.read(cartProvider)!;
    CartItem cartItem = CartItem(pid: pid, price: price, quantity: quantity);
    cart = cart.copyWith(
      item: cart.item + [cartItem],
    );
    state = false;
    final res = await _cartRepository.addTocart(cart);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        _ref.read(cartProvider.notifier).update((state) => cart);
        showSnackBar(context, 'Added to cart');
      },
    );
  }

  Stream<CartModel?> getUserCart(String uid) {
    return _cartRepository.getUserCart(uid);
  }

  void createCart(BuildContext context, String uid) async {
    final cart = await _cartRepository.createCart(uid: uid);
    cart.fold((l) => showSnackBar(context, l.message),
        (r) => _ref.read(cartProvider.notifier).update((state) => r));
  }
}
