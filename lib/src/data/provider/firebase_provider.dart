// ignore_for_file: prefer_final_fields
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';

class ManagerProvider extends GetxController {
  var controlAddClientPage = false.obs;
  //var allClients = <Client>[].obs;
  var foundClients = <Client>[].obs;
  var allServiceOrder = <ServiceOrder>[].obs;

  FirebaseCloudFirestore _firebaseRepository = FirebaseCloudFirestore();

  // @override
  // void onInit() {
  //   print('chamou...');
  //   getAllClientsProvider();
  //   super.onInit();
  // }

  Future<void> getAllClientsProvider() async {
    List<Client> response = await _firebaseRepository.getAllClients();
    response.sort((a, b) => a.name.compareTo(b.name));
    foundClients.value = response;
  }

  Future<void> registerClientProvider({required Client client}) async {
    await _firebaseRepository.registerClient(client: client);
    getAllClientsProvider();
  }

  Future<void> updateClientProvider({required Client client}) async {
    await _firebaseRepository.updateClient(client: client);
    getAllClientsProvider();
  }

  Future<void> deleteProvider({required String id}) async {
    await _firebaseRepository.deleteClient(id: id);
    getAllClientsProvider();
  }

  Future<void> searchClient({required String name}) async {
    List<Client> result = [];
    result = foundClients
        .where((element) =>
            element.name.toString().toLowerCase().contains(name.toLowerCase()))
        .toList();
    foundClients.value = result;
    if (name.isEmpty) {
      await getAllClientsProvider();
    }
  }

  Future<void> getAllServiceOrderProvider() async {
    List<ServiceOrder>? response =
        await _firebaseRepository.getAllServiceOrders();
    if (response != null) {
      allServiceOrder.value = response;
    }
  }
}
