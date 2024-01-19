import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/favourite/controller/favourite_controller.dart';
import 'package:food_app/features/favourite/widgets/fav_cart.dart';

class FavScreen extends ConsumerWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favItems = ref.read(userFavouriteProvider)!.pid;
    return favItems.isEmpty
        ? const Center(
            child: Text("Fav is empty"),
          )
        : ListView.builder(
            itemCount: favItems.length,
            itemBuilder: (context, index) {
              return FavCard(
                pid: favItems[index],
              );
            },
          );
  }
}
