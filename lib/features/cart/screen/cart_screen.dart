import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/cart/widget/cart_product_card.dart';
import 'package:routemaster/routemaster.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  void navigateToCheckoutDelivery(BuildContext context) {
    Routemaster.of(context).push('/checkout-delivery');
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userProvider);
    List<String> productList = ref.read(userProvider)!.cart;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return CardProductCard(
                  pid: productList[index],
                );
              },
            ),
          ),
          InkWell(
            onTap: () => navigateToCheckoutDelivery(context),
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(100)),
              child: const Center(child: Text("Complete Order")),
            ),
          )
        ],
      ),
    );
  }
}
