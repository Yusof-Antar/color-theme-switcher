import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorChanger with ChangeNotifier {
  int primary = Colors.teal.value;
  int secondary = Colors.amber.value;
  ColorChanger({
    required this.primary,
    required this.secondary,
  });

  void changePrimaryColor(int prim) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    primary = prim;
    prefs.setInt('Primary', primary);
    notifyListeners();
  }

  void changeSecondaryColor(int second) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    secondary = second;
    prefs.setInt('Secondary', second);
    notifyListeners();
  }

  int get getPrimary => primary;
  int get getSecondary => secondary;
}
