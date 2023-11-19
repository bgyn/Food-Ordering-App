import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/delegates/search_product_delegates.dart';

class CustomSearchBar extends ConsumerWidget {
  final searchController = TextEditingController();
  CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(Icons.search),
            SizedBox(
              width: 10,
            ),
            Text(
              "Search",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ],
        ),
      ),
      onTap: () {
        showSearch(
            context: context, delegate: SearchProductDelegates(ref: ref));
      },
    );
  }
}
