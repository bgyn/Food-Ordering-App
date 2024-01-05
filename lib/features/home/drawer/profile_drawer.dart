import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});
  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToUserProfile(String uid, BuildContext context) {
    Routemaster.of(context).push('/user-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    return Drawer(
      width: 250,
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                navigateToUserProfile(user!.uid, context);
              },
              child: user?.profilePic == null
                  ? SizedBox(
                      child: Image.asset(
                        'assets/images/user.png',
                      ),
                    )
                  : Container(
                      width: 80,
                      height: 80,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: user!.profilePic!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
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
