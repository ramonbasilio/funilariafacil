import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Car {
  final String model;
  final String brand;
  final String color;
  final String year;
  final String notes;
  Car({
    required this.model,
    required this.brand,
    required this. color,
    required this.year,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': model,
      'brand': brand,
      'year': year,
      'notes': notes,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      model: map['name'] as String,
      color: map['color'] as String,
      brand: map['brand'] as String,
      year: map['year'] as String,
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);
}
