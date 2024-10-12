import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/model/car.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/service_order_new.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';
import 'package:servicemangerapp/src/data/repository/firebase_storage.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/page_add_car_os.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/widget/camera.dart';
import 'package:servicemangerapp/src/pages/widgets/signatureWidget.dart';

import '../../../data/repository/firebase_cloud_firestore.dart';

class NewPageMakeSo extends StatefulWidget {
  int numberServiceOrder;
  NewPageMakeSo({required this.numberServiceOrder, super.key});

  @override
  State<NewPageMakeSo> createState() => _NewPageMakeSoState();
}

class _NewPageMakeSoState extends State<NewPageMakeSo> {
  ManagerProvider managerProvider = Get.find();

  var nameClient = ''.obs;
  var phoneClient = ''.obs;
  var emailClient = ''.obs;
  var nameCar = ''.obs;
  var brandCar = ''.obs;
  var colorCar = ''.obs;
  var yearCar = ''.obs;
  var date = ''.obs;
  var notesCar = ''.obs;
  var description = ''.obs;

  var clientValidation = false.obs;
  var carValidation = false.obs;
  var descriptionValidation = false.obs;
  var photosCarValidation = false.obs;
  var signValidation = false.obs;
  var loading = false.obs;

  TextEditingController descriptionController = TextEditingController();

  List<File> listImagePath = [];
  List<int> listSignData = [];

  Client? client;
  Car? car;

  @override
  Widget build(BuildContext context) {
    MyProvider value = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordem de Serviço - ${widget.numberServiceOrder}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() => Row(
                    children: [
                      const Text(
                        'Cliente',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () async {
                          managerProvider.controlAddClientPage.value = true;
                          client = await Get.to(() => PageListClientes());
                          if (client != null) {
                            nameClient.value = client!.name;
                            phoneClient.value = client!.phone;
                            emailClient.value = client!.email;
                            clientValidation.value = false;
                          }
                          managerProvider.controlAddClientPage.value = false;
                        },
                        icon: const Icon(Icons.add),
                      ),
                      clientValidation.value
                          ? const Text(
                              'Adicione um cliente',
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox.shrink()
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: const Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade300,
                ),
                height: 100,
                width: double.infinity,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Nome: ${nameClient.value}'),
                        Text('Telefone: ${phoneClient.value}'),
                        Text('Email: ${emailClient.value}')
                      ],
                    )),
              ),
              Obx(() => Row(
                    children: [
                      const Text(
                        'Carro',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                          iconSize: 30,
                          onPressed: () async {
                            car = await Get.to(() => const PageAddCarOs());
                            if (car != null) {
                              nameCar.value = car!.model;
                              brandCar.value = car!.brand;
                              yearCar.value = car!.year;
                              notesCar.value = car!.notes;
                              colorCar.value = car!.color;
                              date.value = car!.date;
                              carValidation.value = false;
                            }
                          },
                          icon: const Icon(Icons.add)),
                      carValidation.value
                          ? const Text(
                              'Adicione um carro',
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox.shrink()
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: const Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade300,
                ),
                height: 200,
                width: double.infinity,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Carro: ${nameCar.value}'),
                      Text('Marca: ${brandCar.value}'),
                      Text('Cor: ${colorCar.value}'),
                      Text('Ano: ${yearCar.value}'),
                      Text('Data entrada na oficina: ${date.value}'),
                      Text('Notas: ${notesCar.value}'),
                    ],
                  ),
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Descrição',
                          style: TextStyle(fontSize: 20),
                        ),
                        descriptionValidation.value
                            // ignore: prefer_const_constructors
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: const Text(
                                  'Insira a descrição do defeito',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  )),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade300,
                ),
                //margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Descrição do defeito:',
                    ),
                    TextFormField(
                      controller: descriptionController,
                      onChanged: (value) {
                        descriptionValidation.value = false;
                        description.value = value;
                      },
                      minLines: 1,
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Fotos do Carro',
                          style: TextStyle(fontSize: 20),
                        ),
                        photosCarValidation.value
                            ? const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Insira pelo menos uma foto',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  )),
              Camera(finalReturn: (List<File> value) {
                listImagePath = value;
                if (listImagePath.isNotEmpty) {
                  photosCarValidation.value = false;
                }
              }),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Assinatura',
                          style: TextStyle(fontSize: 20),
                        ),
                        signValidation.value
                            ? const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Assine e confirme',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  )),
              Signaturewidget(
                dataSign: (uint8List) {
                  setState(() {
                    if (uint8List.isEmpty) {
                      listSignData.clear();
                    } else {
                      for (var x in uint8List) {
                        listSignData.add(x);
                        signValidation.value = false;
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade800),
        child: Obx(() => ElevatedButton(
              onPressed: () async {
                if (client == null) {
                  clientValidation.value = true;
                } else {
                  clientValidation.value = false;
                }
                if (car == null) {
                  carValidation.value = true;
                } else {
                  carValidation.value = false;
                }
                if (descriptionController.text.isEmpty) {
                  descriptionValidation.value = true;
                } else {
                  descriptionValidation.value = false;
                }

                if (listSignData.isEmpty) {
                  signValidation.value = true;
                } else {
                  signValidation.value = false;
                }
                if (listImagePath.isEmpty) {
                  photosCarValidation.value = true;
                } else {
                  photosCarValidation.value = false;
                }

                if (!clientValidation.value &&
                    !carValidation.value &&
                    !descriptionValidation.value &&
                    !signValidation.value &&
                    !photosCarValidation.value) {
                  loading.value = true;

                  await Firebasetorage().uploadImageStorage(
                    pathList: listImagePath,
                    signList: listSignData,
                    context: context,
                  );

                  ServiceOrderCar serviceOrderNew = ServiceOrderCar(
                      id: widget.numberServiceOrder.toString(),
                      client: client!,
                      car: car!,
                      description: descriptionController.text,
                      pathImages: value.getList(),
                      pathSign: value.getUrl(),
                      date: car!.date);

                  await FirebaseCloudFirestore().registerReceiverOrderCar(
                      receiverDoc: serviceOrderNew, context: context);

                  loading.value = false;
                }
              },
              child: loading.value
                  ? CircularProgressIndicator()
                  : Text('Salvar Ordem de Serviço'),
            )),
      ),
    );
  }
}
