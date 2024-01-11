import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/snackbar.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/product/respsitory/product_repository.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/model/user_model.dart';

final productControllerProvider =
    StateNotifierProvider<ProductController, bool>(
  (ref) => ProductController(
    productRepository: ref.read(productRepositoryProvider),
    ref: ref,
  ),
);

final productListProvider = StreamProvider.autoDispose.family(
    (ref, String query) => ref
        .watch(productControllerProvider.notifier)
        .fetchFilterProduct(query: query));

final searchProductProvider = StreamProvider.family((ref, String query) {
  final productController = ref.watch(productControllerProvider.notifier);
  return productController.searchProduct(query);
});

final getProductByIdProvider = StreamProvider.family((ref, String pid) {
  final productController = ref.watch(productControllerProvider.notifier);
  return productController.getProductById(pid);
});

final getAllProduct = StreamProvider((ref) {
  final productController = ref.watch(productControllerProvider.notifier);
  return productController.fetchAllProduct();
});

class ProductController extends StateNotifier<bool> {
  final ProductRepository _productRepository;
  final Ref _ref;
  ProductController(
      {required ProductRepository productRepository, required Ref ref})
      : _productRepository = productRepository,
        _ref = ref,
        super(false);

  Stream<List<Product>> fetchFilterProduct({required String query}) {
    return _productRepository.fetchFilterProduct(query: query);
  }

  Stream<List<Product>> searchProduct(String query) {
    return _productRepository.searchProduct(query);
  }

  Stream<Product> getProductById(String pid) {
    return _productRepository.getProductById(pid);
  }

  Stream<List<Product>> fetchAllProduct() {
    return _productRepository.fetchAllProduct();
  }

  void addToCart({
    required String pid,
    required BuildContext context,
  }) async {
    UserModel user = _ref.read(userProvider)!;
    List<String> updateCart = List.from(user.cart)..add(pid);
    user = user.copyWith(cart: updateCart);
    final result = await _productRepository.addToCart(user: user);
    result.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(userProvider.notifier).update((state) => r);
      showSnackBar(context, "Added to Cart");
    });
  }
}
