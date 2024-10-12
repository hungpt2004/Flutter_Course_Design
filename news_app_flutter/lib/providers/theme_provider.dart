import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {

  bool isDark = false;

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  static ThemeProvider of(BuildContext context, {listen = true}){
    return Provider.of(context, listen: listen);
  }

}
