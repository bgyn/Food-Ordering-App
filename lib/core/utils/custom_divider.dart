import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double indent;
  final double endIndent;
  const CustomDivider({super.key, required this.indent,required this.endIndent});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      indent: indent,
      endIndent: endIndent,
      height: 20,
      thickness: 1,
    );
  }
}
