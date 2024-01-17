import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/cart/controller/cart_controller.dart';
import 'package:food_app/features/product/controller/product_controller.dart';
import 'package:routemaster/routemaster.dart';

class CardProductCard extends ConsumerWidget {
  final String _pid;
  const CardProductCard({super.key, required String pid}) : _pid = pid;

  void navigateToProductDetailScreen(String pid, BuildContext context) {
    Routemaster.of(context).push('/product-detail/$pid');
  }

  void deleteFromCart(
      {required String pid,
      required WidgetRef ref,
      required BuildContext context}) {
    ref
        .read(cartControllerProvider.notifier)
        .deleteFromCart(pid: pid, context: context);
  }

  void decreaseQuantity({
    required String pid,
    required int quantity,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    ref.read(cartControllerProvider.notifier).updateProductQuanitty(
          context: context,
          pid: pid,
          quantity: quantity - 1,
        );
  }

  void increaseQuantity({
    required String pid,
    required int quantity,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    ref.read(cartControllerProvider.notifier).updateProductQuanitty(
          context: context,
          pid: pid,
          quantity: quantity + 1,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getProductByIdProvider(_pid)).when(
          data: (product) {
            final cart = ref.watch(cartProvider)!;
            final index =
                cart.item.indexWhere((element) => element.pid == _pid);
            return Dismissible(
              key: Key(product.pid),
              onDismissed: (direction) => deleteFromCart(
                pid: product.pid,
                ref: ref,
                context: context,
              ),
              child: InkWell(
                onTap: () =>
                    navigateToProductDetailScreen(product.pid, context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return const Loader();
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black, fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Text(
                            "Rs. ${product.price * cart.item[index].quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: cart.item[index].quantity == 1
                                  ? null
                                  : () => decreaseQuantity(
                                      pid: product.pid,
                                      quantity: cart.item[index].quantity,
                                      ref: ref,
                                      context: context),
                              icon: const Icon(Icons.remove)),
                          Text(
                            '${cart.item[index].quantity}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          IconButton(
                            onPressed: cart.item[index].quantity >= 5
                                ? null
                                : () => increaseQuantity(
                                    pid: product.pid,
                                    quantity: cart.item[index].quantity,
                                    ref: ref,
                                    context: context),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, errorStack) {
            return ErrorText(
              text: error.toString(),
            );
          },
          loading: () => const Loader(),
        );
  }
}
