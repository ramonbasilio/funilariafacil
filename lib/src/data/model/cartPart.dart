import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:servicemangerapp/src/data/model/part.dart';

class CartPart {
  String name;
  RxInt quantity;
  double price;
  int index;

  CartPart(
      {required this.name,
      required int quantity,
      required this.index,
      required this.price})
      : quantity = quantity.obs;
}

class CartPart2 {
  Part part;
  String id;
  RxInt quantity;
  double price;
  bool isAdded;

  CartPart2(
      {required this.part,
      required this.id,
      required int quantity,
      required this.price,
      this.isAdded = false})
      : quantity = quantity.obs;
}
