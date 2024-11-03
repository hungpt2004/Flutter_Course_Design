import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BottomNavbarProvider extends ChangeNotifier {

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setPageIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  static BottomNavbarProvider bottomStateMangement(BuildContext context, {listen = true}) {
    return Provider.of<BottomNavbarProvider>(context, listen: listen);
  }

}