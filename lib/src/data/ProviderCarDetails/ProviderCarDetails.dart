import 'package:flutter/material.dart';

class ProviderCarDetails extends ChangeNotifier {
  String selectedBrand = '';
  String selectedModel = '';
  String selectedYear = '';
  String selectedColor = '';

  void setBrand(String data) {
    selectedBrand = data;
    notifyListeners();
  }
}
