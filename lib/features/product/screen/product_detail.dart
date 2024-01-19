import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/cart/controller/cart_controller.dart';
import 'package:food_app/features/favourite/controller/favourite_controller.dart';
import 'package:food_app/features/product/controller/product_controller.dart';

class ProductDetail extends ConsumerWidget {
  final String _pid;
  const ProductDetail({
    super.key,
    required String pid,
  }) : _pid = pid;

  void addToCart(
      {required WidgetRef ref,
      required String pid,
      required int price,
      required BuildContext context}) {
    ref.read(cartControllerProvider.notifier).addToCart(
          context: context,
          pid: pid,
          price: price,
        );
  }

  void favourite({
    required WidgetRef ref,
    required BuildContext context,
    required String uid,
    required String pid,
  }) {
    ref
        .read(favouriteControllerProvider.notifier)
        .updateFavourite(context, uid, pid);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer(builder: (context, ref, child) {
            final isContain = ref.watch(userFavouriteProvider);
            return IconButton(
              onPressed: () => favourite(
                ref: ref,
                context: context,
                uid: ref.read(userProvider)!.uid,
                pid: _pid,
              ),
              icon: isContain!.pid.contains(_pid)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_outline),
            );
          })
        ],
      ),
      body: ref.watch(getProductByIdProvider(_pid)).when(
            data: (product) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rs. ${product.price.toString()}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Food Info',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.grey.shade700, fontSize: 18),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          // padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () => addToCart(
                                ref: ref,
                                pid: product.pid,
                                price: product.price,
                                context: context),
                            child: Text(
                              'Add to cart',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
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
          ),
    );
  }
}
