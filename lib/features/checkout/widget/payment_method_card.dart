import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/payment_constant.dart';
import 'package:food_app/core/utils/custom_divider.dart';

final paymentMethodProvider =
    StateProvider<String>((ref) => PaymentMethod.esewa);

class PaymentMethodCard extends ConsumerWidget {
  const PaymentMethodCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryMethod = ref.watch(paymentMethodProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black, fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                title: const Text('Esewa'),
                value: PaymentMethod.esewa,
                groupValue: deliveryMethod,
                onChanged: (value) {
                  ref
                      .read(paymentMethodProvider.notifier)
                      .update((state) => value.toString());
                },
              ),
              const CustomDivider(
                indent: 70,
                endIndent: 20,
              ),
              RadioListTile(
                title: const Text('Cash on Delivery'),
                value: PaymentMethod.cashOnDelivery,
                groupValue: deliveryMethod,
                onChanged: (value) {
                  ref
                      .read(paymentMethodProvider.notifier)
                      .update((state) => value.toString());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
