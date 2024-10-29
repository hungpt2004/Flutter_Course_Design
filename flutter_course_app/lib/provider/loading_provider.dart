import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {

  bool _isLoading = false;
  bool _isLoading1 = false;
  bool _isLoading2 = false;

  bool get isLoading => _isLoading;
  bool get isLoading1 => _isLoading1;
  bool get isLoading2 => _isLoading2;

  Future<void> loading() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> tabViewLoading(int index) async {
    if(index == 1) {
      _isLoading1 = true;
      notifyListeners();
    }
    if(index == 2) {
      _isLoading2 = true;
      notifyListeners();
    }
  }

  static LoadingProvider stateLoadingProvider(BuildContext context, {listen = true}){
    return Provider.of(context,listen: listen);
  }

}