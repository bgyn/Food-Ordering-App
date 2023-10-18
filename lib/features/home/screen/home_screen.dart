import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(user!.email)),
          TextButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logOut();
            },
            child: const Text("Log Out"),
          )
        ],
      ),
    );
  }
}
