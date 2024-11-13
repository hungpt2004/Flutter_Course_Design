import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BottomNavbarProvider extends ChangeNotifier {

  int _currentIndex = 0;


  int get currentIndex => _currentIndex;

  // SET PAGE BOTTOM
  Future<void> setPageIndex(int index) async {
    _currentIndex = index;
    notifyListeners();
  }

  static BottomNavbarProvider bottomStateManagement(BuildContext context, {listen = true}) {
    return Provider.of<BottomNavbarProvider>(context, listen: listen);
  }

}