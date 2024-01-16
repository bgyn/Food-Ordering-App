import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/orders/controller/order_controller.dart';
import 'package:food_app/features/product/controller/product_controller.dart';
import 'package:intl/intl.dart';

class OrderScreen extends ConsumerWidget {
  final String uid;
  const OrderScreen({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat dateFormat = DateFormat("dd MMM yyyy");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Orders"),
      ),
      body: ref.watch(getUserOrderProvider(uid)).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: ref
                          .watch(
                              getProductByIdProvider(data[index].productId[0]))
                          .when(
                            data: (product) {
                              return Container(
                                width: 60,
                                height: 100,
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
                              );
                            },
                            error: (error, errorStack) {
                              return ErrorText(text: error.toString());
                            },
                            loading: () => const Loader(),
                          ),
                      title: Text(
                        data[index].orderStatus,
                      ),
                      subtitle: Text(
                        "Order ID : ${data[index].orderId}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                      ),
                      trailing: Text(
                        dateFormat.format(data[index].timestamp),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, errorStack) {
            return ErrorText(text: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
