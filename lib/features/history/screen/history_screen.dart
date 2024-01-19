import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/orders/controller/order_controller.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat dateFormat = DateFormat("dd MMM yyyy");
    final uid = ref.read(userProvider)!.uid;
    return ref.watch(getUserDeliveredOrderProvider(uid)).when(
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
              });
        },
        error: (error, errorStack) {
          return ErrorText(text: error.toString());
        },
        loading: () => const Loader());
  }
}
