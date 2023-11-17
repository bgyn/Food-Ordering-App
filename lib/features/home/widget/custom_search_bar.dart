import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final searchController = TextEditingController();
  CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      cursorColor: Colors.blue.shade700,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: 'Search',
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue.shade700)),
      ),
    );
  }
}
