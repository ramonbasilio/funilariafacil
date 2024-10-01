// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:servicemangerapp/src/data/model/car.dart';
import 'package:servicemangerapp/src/data/model/client.dart';

class ServiceOrderNew {
  final String id;
  final Client client;
  final Car car;
  final String description;
  final List<String> pathImages;
  final String pathSign;
  final String date;

  ServiceOrderNew({
    required this.id,
    required this.client,
    required this.car,
    required this.description,
    required this.pathImages,
    required this.pathSign,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'client': client.toMap(),
      'car': car.toMap(),
      'description': description,
      'pathImages': pathImages,
      'pathSign': pathSign,
      'date': date,
    };
  }

  factory ServiceOrderNew.fromMap(Map<String, dynamic> map) {
    return ServiceOrderNew(
      id: map['id'] as String,
      client: Client.fromMap(map['client'] as Map<String, dynamic>),
      car: Car.fromMap(map['car'] as Map<String, dynamic>),
      description: map['description'] as String,
      pathImages: List<String>.from((map['pathImages'])),
      pathSign: map['pathSign'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceOrderNew.fromJson(String source) =>
      ServiceOrderNew.fromMap(json.decode(source) as Map<String, dynamic>);
}
