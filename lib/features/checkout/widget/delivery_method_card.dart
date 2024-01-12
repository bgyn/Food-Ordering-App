import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deliverMethodProvider = StateProvider<String>((ref) => 'door-delivery');

class DeliveryMethodCard extends ConsumerWidget {
  const DeliveryMethodCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryMethod = ref.watch(deliverMethodProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Method",
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
                title: const Text('Door Delivery'),
                value: 'door-delivery',
                groupValue: deliveryMethod,
                onChanged: (value) {
                  ref
                      .read(deliverMethodProvider.notifier)
                      .update((state) => value.toString());
                },
              ),
              RadioListTile(
                title: const Text('Pick Up'),
                value: 'pick-up',
                groupValue: deliveryMethod,
                onChanged: (value) {
                  ref
                      .read(deliverMethodProvider.notifier)
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
