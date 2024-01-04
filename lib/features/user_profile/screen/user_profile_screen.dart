import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/user_profile/widget/custom_card.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({super.key, required this.uid});

  void navigateToOrders() {}

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
                          onPressed: () {},
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
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user!.profilePic!),
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
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomCard(title: 'Orders', onTap: navigateToOrders),
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
