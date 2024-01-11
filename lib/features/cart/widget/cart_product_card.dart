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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getProductByIdProvider(_pid)).when(
          data: (product) {
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
                  child: ListTile(
                    leading: Container(
                      height: 100,
                      width: 60,
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
                    title: Text(product.name),
                    subtitle: Text("Rs. ${product.price}"),
                    trailing: Icon(Icons.add),
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
