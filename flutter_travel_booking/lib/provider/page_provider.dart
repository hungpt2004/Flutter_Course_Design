import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageProvider extends StateNotifier<int>{

  PageProvider() : super(0);

  void toggleChangePage(int index) {
    state = index;
  }

}
final pageProvider = StateNotifierProvider<PageProvider, int>((ref) => PageProvider());