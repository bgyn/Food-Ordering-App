import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/home/widget/product_card.dart';
import 'package:food_app/features/product/controller/product_controller.dart';

class SeeMore extends ConsumerWidget {
  const SeeMore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(getAllProduct).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ProductCard(product: data[index]);
              },
            );
          },
          error: (error, _) {
            return ErrorText(text: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
