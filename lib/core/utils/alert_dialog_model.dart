import 'package:flutter/material.dart';

class AlertDialogModel<T> {
  final String title;
  final String message;
  final Map<String, T> buttons;
  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 24,
                  ),
            ),
            content: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
            ),
            actions: buttons.entries.map((e) {
              return TextButton(
                onPressed: () {
                  Navigator.of(context).pop(e.value);
                },
                child: Text(e.key),
              );
            }).toList(),
          );
        });
  }
}
