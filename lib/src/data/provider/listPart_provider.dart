// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/cartPart.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/provider/listPart_Getx.dart';

class ListPartProvider2 extends ChangeNotifier {
  List<CartPart2> partsCart2 = [];
  List<Part> listPartSelected = [];
  bool isSelected = false;

  void setIsSelected(bool value) {
    isSelected = value;
    notifyListeners();
  }

  void setAllParts(List<Part> part) {
    partsCart2 = [];
    for (var i in part) {
      CartPart2 cartPart2 = CartPart2(
        part: i,
        quantity: 1,
        price: i.price,
        id: i.id,
      );
      partsCart2.add(cartPart2);
    }
  }

  void addPartToBudget(String id) {
    for (var i in partsCart2) {
      if (i.id == id) {
        i.isAdded = true;
      }
    }
    notifyListeners();
  }

  void removePartFromBudget(String id) {
    for (var i in partsCart2) {
      if (i.id == id) {
        i.isAdded = false;
      }
    }
    notifyListeners();
  }

  void togglePartSelection(Part part, String id) {
    if (listPartSelected.contains(part)) {
      listPartSelected.remove(part);
      //removePartFromBudget(id);
    } else {
      listPartSelected.add(part);
      //addPartToBudget(id);
    }
    notifyListeners();
  }
}
