import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/orders/controller/order_controller.dart';
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
        title: Text(
          "My Orders",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black, fontSize: 24),
        ),
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
                        dateFormat.format(data[index].createdAt),
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
