import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/features/product/controller/product_controller.dart';
import 'package:food_app/model/product_model.dart';

class SearchProductDelegates extends SearchDelegate<Product> {
  final WidgetRef _ref;
  SearchProductDelegates({required WidgetRef ref}) : _ref = ref;

  @override
  TextStyle get searchFieldStyle =>
      const TextStyle(color: Colors.grey, fontSize: 16);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return _ref.watch(searchProductProvider(query)).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final product = data[index];
                return ListTile(
                  leading: SizedBox(
                    width: 35,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(product.image),
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.price.toString()),
                  onTap: () {},
                );
              },
            );
          },
          error: (error, _) {
            return ErrorText(text: error.toString());
          },
          loading: () => const LinearProgressIndicator(),
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _ref.watch(searchProductProvider(query)).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final product = data[index];
                return ListTile(
                  leading: SizedBox(
                    width: 35,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(product.image),
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.price.toString()),
                  onTap: () {},
                );
              },
            );
          },
          error: (error, _) {
            return ErrorText(text: error.toString());
          },
          loading: () => const LinearProgressIndicator(),
        );
  }
}
