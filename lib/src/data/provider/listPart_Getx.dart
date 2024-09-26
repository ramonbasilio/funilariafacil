import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/cartPart.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';

class ListPartControllerGext extends GetxController {
  FirebaseCloudFirestore _firebaseRepository = FirebaseCloudFirestore();

  var partItemsList = <CartPart>[].obs;
  var selectedParts = <Part>[].obs;
  var totalPrice = 0.0.obs;
  var allParts = <Part>[].obs;
  var listParts = <Part>[].obs;

  void addItem(CartPart part) {
    partItemsList.add(part);
    updatePriceTotal();
  }

  void removeItem(CartPart part) {
    partItemsList.remove(part);
    updatePriceTotal();
  }

  void updateItemQuantity(CartPart part, int quantity) {
    int index =
        partItemsList.indexWhere((element) => element.index == part.index);
    if (index != -1) {
      partItemsList[index].quantity.value = quantity;
      updatePriceTotal();
    }
  }

  void updatePriceTotal() {
    totalPrice.value = partItemsList.fold(
        0, (sum, item) => sum + (item.price * item.quantity.value));
  }

  void togglePartSelection(Part part) {
    if (selectedParts.contains(part)) {
      selectedParts.remove(part);
    } else {
      selectedParts.add(part);
    }
  }

  bool isPartSelected(Part part) {
    return selectedParts.contains(part);
  }

  Future<List<Part>> getAllPartsProvider() async {
    List<Part>? response = await _firebaseRepository.getAllParts();
    allParts.value = response!;
    return response;
  }

  void removeItemListPart(Part part) {
    listParts.remove(part);
    print('Lista atualizada de itens: $listParts');
  }
}
