import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/repository/product_repository.dart';
import 'package:food_app/model/product_model.dart';

final productControllerProvider =
    StateNotifierProvider<ProductController, bool>(
  (ref) => ProductController(
    productRepository: ref.read(productRepositoryProvider),
  ),
);

final productListProvider = StreamProvider.autoDispose(
    (ref) => ref.read(productControllerProvider.notifier).fetchAllProduct());

class ProductController extends StateNotifier<bool> {
  final ProductRepository _productRepository;
  ProductController({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(false);

  Stream<List<Product>> fetchAllProduct() {
    return _productRepository.fetchAllProduct();
  }
}
