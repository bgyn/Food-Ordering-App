import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextFields extends ConsumerWidget {
  final TextEditingController textEditingController;
  final String title;
  final bool obscure;
  const CustomTextFields(
      {super.key,
      required this.textEditingController,
      required this.title,
      required this.obscure});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      obscureText: obscure,
      controller: textEditingController,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        label: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
