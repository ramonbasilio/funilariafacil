import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:servicemangerapp/src/data/model/car.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/page_add_car_os.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/widget/camera.dart';
import 'package:servicemangerapp/src/pages/widgets/signatureWidget.dart';

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
  var notesCar = ''.obs;
  var discription = ''.obs;

  var clientValidation = false.obs;

  List<File> listImagePath = [];
  List<int> listSignData = [];

  //RxBool validateClientControll = false.obs;

  Client? client;
  Car? car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordem de Serviço - 12345'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
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
                        clientValidation.value = true;
                      }
                      managerProvider.controlAddClientPage.value = false;
                    },
                    icon: const Icon(Icons.add),
                  ),
                  // validateClientControll.value
                  //     ? const Text(
                  //         'Adicione um cliente',
                  //         style: TextStyle(color: Colors.red),
                  //       )
                  //     : const SizedBox.shrink()
                ],
              ),
              Obx(() => Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: clientValidation.value
                              ? Colors.green
                              : Colors.black,
                          width: 5.0,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Nome: ${nameClient.value}'),
                        Text('Telefone: ${phoneClient.value}'),
                        Text('Email: ${emailClient.value}')
                      ],
                    ),
                  )),
              Row(
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
                          //validateClientControll.value = false;
                        }
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
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
                      Text('Notas: ${notesCar.value}'),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Descrição do defeito',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
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
                      onChanged: (value) {
                        discription.value = value;
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Fotos do Carro',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Camera(finalReturn: (List<File> value) {
                listImagePath = value;
              }),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Assinatura',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Signaturewidget(
                dataSign: (uint8List) {
                  setState(() {
                    if (uint8List.isEmpty) {
                      listSignData.clear();
                    } else {
                      for (var x in uint8List) {
                        listSignData.add(x);
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
        decoration: BoxDecoration(color: Colors.grey.shade700),
        child: ElevatedButton(
          onPressed: () {
            if (client != null) {
              clientValidation.value = true;
            }
          },
          child: const Text('Salvar Ordem de Serviço'),
        ),
      ),
    );
  }
}
