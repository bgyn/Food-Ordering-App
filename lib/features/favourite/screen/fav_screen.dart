import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavScreen extends ConsumerWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text('Fav Screen',style: TextStyle(color: Colors.black),);
  }
}