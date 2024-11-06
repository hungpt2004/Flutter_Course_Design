import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {

  bool _isLoading = false;
  int _currentIndex = 0;

  bool get isLoading => _isLoading;
  int get currentIndex => _currentIndex;

  // START LOADING
  Future<void> loading() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }

  // SET PAGE BOTTOM
  Future<void> setPageIndex(int index) async {
    _currentIndex = index;
    notifyListeners();
  }


  static LoadingProvider of(BuildContext context, {listen = true}){
    return Provider.of(context,listen: listen);
  }

}