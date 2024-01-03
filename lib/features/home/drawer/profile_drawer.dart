import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});
  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    return Drawer(
      width: 250,
      child: SafeArea(
        child: Column(
          children: [
            user?.profilePic == null
                ? SizedBox(
                    child: Image.asset(
                      'assets/images/user.png',
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(user!.profilePic!),
                  ),
            IconButton(
              onPressed: () => logout(ref),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
