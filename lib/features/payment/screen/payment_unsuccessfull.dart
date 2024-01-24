import 'package:flutter/material.dart';

class PaymentUnsuccessful extends StatelessWidget {
  final String error;
  const PaymentUnsuccessful({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset('assets/images/cancel.png'),
              const SizedBox(
                height: 30,
              ),
              Text(
                error,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
              )
            ],
          )),
    );
  }
}
