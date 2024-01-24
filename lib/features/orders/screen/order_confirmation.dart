import 'package:flutter/material.dart';
import 'package:food_app/core/utils/custom_divider.dart';

class OrderConfirmation extends StatelessWidget {
  final String price;
  const OrderConfirmation({super.key,required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Confirmation",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/checked.png'),
            Column(
              children: [
                Text(
                  "Order Placed",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomDivider(indent: 0, endIndent: 0),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Please keep you amount ready',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Rs. $price',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 16, color: Colors.green))
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Cash On Delivery",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
