import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/product/respsitory/product_repository.dart';
import 'package:food_app/model/product_model.dart';

final productControllerProvider =
    StateNotifierProvider<ProductController, bool>(
  (ref) => ProductController(
    productRepository: ref.read(productRepositoryProvider),
  ),
);

final productListProvider = StreamProvider.autoDispose.family(
    (ref, String query) => ref
        .watch(productControllerProvider.notifier)
        .fetchAllProduct(query: query));

final searchProductProvider = StreamProvider.family((ref, String query) {
  final productController = ref.watch(productControllerProvider.notifier);
  return productController.searchProduct(query);
});

final getProductByIdProvider = StreamProvider.family((ref, String pid) {
  final productController = ref.watch(productControllerProvider.notifier);
  return productController.getProductById(pid);
});

class ProductController extends StateNotifier<bool> {
  final ProductRepository _productRepository;
  ProductController({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(false);

  Stream<List<Product>> fetchAllProduct({required String query}) {
    return _productRepository.fetchAllProduct(query: query);
  }

  Stream<List<Product>> searchProduct(String query) {
    return _productRepository.searchProduct(query);
  }

  Stream<Product> getProductById(String pid) {
    return _productRepository.getProductById(pid);
  }
}
