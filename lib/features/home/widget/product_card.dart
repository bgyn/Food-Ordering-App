import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/model/product_model.dart';

class ProductCard extends ConsumerWidget {
  final Product _product;
  const ProductCard({super.key, required Product product}) : _product = product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width * 1;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: width * 0.6,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 130,
                width: 130,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                ),
                child: CachedNetworkImage(
                  imageUrl: _product.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Loader();
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                _product.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Rs.${_product.price.toString()}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
