import 'package:flutter/material.dart';
import 'package:food_app/core/utils/custom_divider.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment Confirmation",
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
                  "Payment Successful",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Transaction Number : ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                ),
                const CustomDivider(indent: 0, endIndent: 0),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Amount paid',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Rs. ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16, color: Colors.green),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Payed by',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Esewa',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                        )
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
