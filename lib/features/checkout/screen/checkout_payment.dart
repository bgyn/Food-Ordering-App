import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/checkout/controller/checkout_controller.dart';
import 'package:food_app/features/checkout/widget/delivery_method_card.dart';
import 'package:food_app/features/checkout/widget/payment_method_card.dart';

class CheckoutPayment extends ConsumerStatefulWidget {
  const CheckoutPayment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckoutDeliveryState();
}

class _CheckoutDeliveryState extends ConsumerState<CheckoutPayment> {
  @override
  void initState() {
    ref.read(checkoutConrollerProvider.notifier).getAmount(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Payement",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontSize: 30,
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            const PaymentMethodCard(),
            const SizedBox(
              height: 30,
            ),
            const DeliveryMethodCard(),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                ),
                Consumer(builder: (context, ref, child) {
                  final totalAmount = ref.watch(totalAmountPovider);
                  return Text(
                    'Rs. ${totalAmount.toString()}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(
                    top: 15, bottom: 10, left: 15, right: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: const Center(child: Text("Proceed to payment")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
