import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/car.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/page_add_car_os.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/widget/camera.dart';
import 'package:servicemangerapp/src/pages/widgets/signatureWidget.dart';

class TestNewPageMakeSo extends StatefulWidget {
  int numberServiceOrder;
  TestNewPageMakeSo({required this.numberServiceOrder, super.key});

  @override
  State<TestNewPageMakeSo> createState() => _TestNewPageMakeSoState();
}

class _TestNewPageMakeSoState extends State<TestNewPageMakeSo> {
  final ManagerProvider managerProvider = Get.find();

  var nameCar = ''.obs;
  var brandCar = ''.obs;
  var colorCar = ''.obs;
  var yearCar = ''.obs;
  var notesCar = ''.obs;
  var description = ''.obs;

  final _formKey = GlobalKey<FormState>();

  List<File> listImagePath = [];
  List<int> listSignData = [];

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildClientSection(),
                const SizedBox(height: 10),
                buildCarSection(),
                const SizedBox(height: 10),
                buildDescriptionSection(),
                const SizedBox(height: 10),
                buildPhotoSection(),
                const SizedBox(height: 10),
                buildSignatureSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade700),
        child: ElevatedButton(
          onPressed: _validateAndSave,
          child: const Text('Salvar Ordem de Serviço'),
        ),
      ),
    );
  }

  Widget buildClientSection() {
    var nameClient = ''.obs;
    var phoneClient = ''.obs;
    var emailClient = ''.obs;
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Cliente', style: TextStyle(fontSize: 20)),
                IconButton(
                  iconSize: 30,
                  onPressed: () async {
                    managerProvider.controlAddClientPage.value = true;
                    client = await Get.to(() => PageListClientes());
                    if (client != null) {
                      nameClient.value = client!.name;
                      phoneClient.value = client!.phone;
                      emailClient.value = client!.email;
                    }
                    managerProvider.controlAddClientPage.value = false;
                  },
                  icon: const Icon(Icons.add),
                ),
                if (client == null)
                  const Text(' Adicione um cliente',
                      style: TextStyle(color: Colors.red)),
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
            ),
          ],
        ));
  }

  Widget buildCarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Carro', style: TextStyle(fontSize: 20)),
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
                }
              },
              icon: const Icon(Icons.add),
            ),
            if (car == null)
              const Text(' Adicione um carro',
                  style: TextStyle(color: Colors.red)),
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
      ],
    );
  }

  Widget buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text('Descrição', style: TextStyle(fontSize: 20)),
          ],
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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Descrição do defeito:'),
              TextFormField(
                //controller: descriptionController,
                onChanged: (value) {
                  description.value = value;
                },
                minLines: 1,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira a descrição do defeito';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Fotos do Carro', style: TextStyle(fontSize: 20)),
          ],
        ),
        Camera(
          finalReturn: (List<File> value) {
            listImagePath = value;
          },
        ),
        if (listImagePath.isEmpty)
          const Text('Insira pelo menos uma foto',
              style: TextStyle(color: Colors.red)),
      ],
    );
  }

  Widget buildSignatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Assinatura', style: TextStyle(fontSize: 20)),
          ],
        ),
        Signaturewidget(
          dataSign: (uint8List) {
            setState(() {
              if (uint8List.isEmpty) {
                listSignData.clear();
              } else {
                listSignData = uint8List;
              }
            });
          },
        ),
        if (listSignData.isEmpty)
          const Text('Assine e confirme', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  void _validateAndSave() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid ||
        client == null ||
        car == null ||
        listImagePath.isEmpty ||
        listSignData.isEmpty) {
      setState(() {
        // trigger re-rendering to show validation errors
      });
      return;
    }

    // Salvar a ordem de serviço
    // Aqui você pode adicionar a lógica de salvamento da ordem de serviço
  }
}
