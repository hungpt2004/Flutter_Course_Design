import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {

  bool _isLoading = false;
  int? _currentIndex;

  bool get isLoading => _isLoading;
  int? get currentIndex => _currentIndex;

  // START LOADING
  Future<void> loading() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
  }

  // READ DOCS
  void toggleExpanded(int index) async {
    if(_currentIndex == index) {
      _currentIndex = null;
    } else {
      _currentIndex = index;
    }
    notifyListeners();
  }

  static LoadingProvider stateLoadingProvider(BuildContext context, {listen = true}){
    return Provider.of(context,listen: listen);
  }

}