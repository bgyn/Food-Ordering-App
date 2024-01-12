import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/utils/divider.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';

class UserInfoCard extends ConsumerWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Address Detail",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black, fontSize: 14),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "change",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 30, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                    ),
              ),
              const CustomDivider(),
              Text(
                user.address,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                    ),
              ),
              const CustomDivider(),
              Text(
                user.phoneNo,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
