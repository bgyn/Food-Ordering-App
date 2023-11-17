import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabControllerProvider =
    StateNotifierProvider<TabController, int>((ref) => TabController());

class TabController extends StateNotifier<int> {
  TabController() : super(0);
  void onTabChange(int index) {
    state = index;
  }
}
