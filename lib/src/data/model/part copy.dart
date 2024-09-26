// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Part {
  String id;
  String name;
  String detail;
  String unit;
  double price;
  int quantity;
  Part({
    required this.name,
    required this.price,
    required this.detail,
    required this.unit,
    String? id,
    this.quantity = 1,
  }) : id = const Uuid().v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'detail': detail,
      'unit': unit,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
        name: map['name'] as String,
        detail: map['details'] ?? 'Sem notas',
        price: map['price'] as double,
        unit: map['unit'] as String,
        id: map['id'],
        quantity: map['quantity'] ?? 1);
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) =>
      Part.fromMap(json.decode(source) as Map<String, dynamic>);
}
