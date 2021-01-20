import 'package:controlapp/classes/systemTF.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  TFModel system;

  setNewSystem(TFModel newSystem) {
    if (system != newSystem) {
      system = newSystem;
      notifyListeners();
    }
  }
}
