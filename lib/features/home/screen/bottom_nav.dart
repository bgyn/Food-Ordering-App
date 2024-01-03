import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/constants/constants.dart';
import 'package:food_app/features/home/controller/tab_controller.dart';
import 'package:food_app/features/home/drawer/profile_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:routemaster/routemaster.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav({super.key});

  void navigateToCartScreen(BuildContext context) {
    Routemaster.of(context).push('/cart');
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const screen = widgetList;
    int index = ref.watch(tabControllerProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => navigateToCartScreen(context),
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      drawer: const ProfileDrawer(),
      body: screen[index],
      bottomNavigationBar: GNav(
        activeColor: Theme.of(context).primaryColor,
        color: Colors.grey,
        tabs: const [
          GButton(
            icon: Icons.home_outlined,
          ),
          GButton(
            icon: Icons.favorite_outline,
          ),
          GButton(
            icon: Icons.history,
          ),
        ],
        onTabChange: (index) {
          ref.read(tabControllerProvider.notifier).onTabChange(index);
        },
        selectedIndex: index,
      ),
    );
  }
}
