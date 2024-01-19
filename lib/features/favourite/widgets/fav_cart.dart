import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/favourite/controller/favourite_controller.dart';
import 'package:food_app/features/product/controller/product_controller.dart';
import 'package:routemaster/routemaster.dart';

class FavCard extends ConsumerWidget {
  final String pid;
  const FavCard({super.key, required this.pid});

  void navigateToproductDetail(BuildContext context, String pid) {
    Routemaster.of(context).push('/product-detail/$pid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userFavouriteProvider);
    return ref.watch(getProductByIdProvider(pid)).when(
          data: (product) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () => navigateToproductDetail(context, pid),
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
                title: SizedBox(
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
                subtitle: Text(
                  "Rs. ${product.price}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            );
          },
          error: (error, errorStack) {
            return ErrorText(text: error.toString());
          },
          loading: () => const Loader(),
        );
  }
}
