import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/constants.dart';

final indexProvider = StateProvider<int>((ref) => 0);

class CustomScrollableMenu extends ConsumerWidget {
  const CustomScrollableMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(indexProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menuList.asMap().entries.map((entry) {
          int index = entry.key;
          String e = entry.value;
          return GestureDetector(
            onTap: () {
              ref.read(indexProvider.notifier).update((state) => index);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: index == currentIndex
                      ? const BorderSide(color: Colors.blue, width: 2)
                      : BorderSide.none,
                ),
              ),
              child: Center(
                child: Text(
                  e,
                  style: index == currentIndex
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.blue, fontSize: 17)
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black, fontSize: 17),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
