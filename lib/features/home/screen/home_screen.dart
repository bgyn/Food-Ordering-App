import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/core/constants/constants.dart';
import 'package:food_app/features/product/controller/product_controller.dart';
import 'package:food_app/features/home/widget/custom_scrollable_menu.dart';
import 'package:food_app/features/home/widget/custom_search_bar.dart';
import 'package:food_app/features/home/widget/product_card.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void navigateToSeeMore(BuildContext context) {
    Routemaster.of(context).push('/see-more');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Delicious\nfood for you",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomSearchBar(),
        const SizedBox(
          height: 20,
        ),
        const CustomScrollableMenu(),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: GestureDetector(
                onTap: () => navigateToSeeMore(context),
                child: Text(
                  'see more',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                ))),
        const SizedBox(
          height: 20,
        ),
        Consumer(
          builder: (context, ref, child) {
            final productIndex = ref.watch(indexProvider);
            return LimitedBox(
              maxHeight: 260,
              child:
                  ref.watch(productListProvider(menuList[productIndex])).when(
                        data: (data) {
                          return ListView.builder(
                            itemCount: data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ProductCard(product: data[index]);
                            },
                          );
                        },
                        error: (error, errorStack) {
                          return ErrorText(
                            text: error.toString(),
                          );
                        },
                        loading: () => const Loader(),
                      ),
            );
          },
        ),
      ],
    );
  }
}
