import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/user_profile/widget/custom_card.dart';
import 'package:routemaster/routemaster.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({super.key, required this.uid});

  void navigateToEditProfile(String uid, BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  void navigateToOrders(BuildContext context, String uid) {
    Routemaster.of(context).push('/orders/$uid');
  }

  void navigateToPendingReview() {}

  void navigateToFaq() {}

  void navigateToHelp() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(getUserProvider(uid)).when(
            data: (user) {
              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Profile',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Personal Detail',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        TextButton(
                          onPressed: () =>
                              navigateToEditProfile(user!.uid, context),
                          child: const Text("change"),
                        )
                      ],
                    ),
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            user?.profilePic == null
                                ? Image.asset(
                                    'assets/images/user.png',
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                user!.name == 'Untitled'
                                    ? const Text(
                                        "Name",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        user.name,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                Text(
                                  user.email,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                user.phoneNo == 'Untitled'
                                    ? const Text(
                                        "Number",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        user.phoneNo,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                user.address == 'Untitled'
                                    ? const Text(
                                        "Address",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        user.address,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomCard(
                      title: 'Orders',
                      onTap: () => navigateToOrders(context, uid),
                    ),
                    CustomCard(
                        title: 'Pending reviews',
                        onTap: navigateToPendingReview),
                    CustomCard(title: 'Faq', onTap: navigateToFaq),
                    CustomCard(title: 'Help', onTap: navigateToHelp),
                  ],
                ),
              );
            },
            error: (error, errorStack) {
              return ErrorText(text: error.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
