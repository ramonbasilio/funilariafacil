// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Part2 {
  final String id;
  final String name;
  final double price;
  bool isAdded;

  Part2(
      {required this.id,
      required this.name,
      required this.price,
      this.isAdded = false});
}

class PartsProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final List<Part2> _parts = [
    Part2(id: '1', name: 'Peça A', price: 50.0),
    Part2(id: '2', name: 'Peça B', price: 75.0),
    Part2(id: '3', name: 'Peça C', price: 75.0),
    Part2(id: '4', name: 'Peça D', price: 75.0),
    Part2(id: '5', name: 'Peça E', price: 75.0),
  ];

  List<Part2> listPartSelected = [];
  List<Part2> get allParts => _parts;
  List<Part2> get notAddedparts =>
      _parts.where((part) => !part.isAdded).toList();
  List<Part2> get addedParts => _parts.where((part) => part.isAdded).toList();

  void addPartToBudget(Part2 part) {
    part.isAdded = true;
    notifyListeners();
  }

  void removePartFromBudget(Part2 part) {
    part.isAdded = false;
    notifyListeners();
  }

  void togglePartSelection(Part2 part) {
    if (listPartSelected.contains(part)) {
      listPartSelected.remove(part);
      removePartFromBudget(part);
    } else {
      listPartSelected.add(part);
      addPartToBudget(part);
    }
    notifyListeners();
  }
}
