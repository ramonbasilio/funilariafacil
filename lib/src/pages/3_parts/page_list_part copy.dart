import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/cartPart.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/provider/common_provider.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/data/provider/listPart_provider.dart';

class PageListPart extends StatefulWidget {
  const PageListPart({super.key});

  @override
  State<PageListPart> createState() => _PageListPartState();
}

class _PageListPartState extends State<PageListPart> {
  ManagerProvider clientController = Get.put(ManagerProvider());
  ListPartController listPartController = Get.find();
  List<Part> selectedParts = [];
  List<Part> parts = [];

  @override
  void initState() {
    parts = clientController.allParts;
    clientController.getAllPartsProvider();
    super.initState();
    for (var i in listPartController.partItemsList) {
      print('Nome da peça: ${i.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Flexible(
              child: ListView.builder(
                itemCount: parts.length,
                itemBuilder: (context, index) {
                  final item = parts[index];
                  final isSelected = selectedParts.contains(item);
                  return Column(
                    children: [
                      ListTile(
                        onLongPress: (() {
                          _showDetailPart(context, parts[index]);
                        }),
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedParts.remove(parts[index]);
                              } else {
                                selectedParts.add(parts[index]);
                              }
                            });
                          },
                          child: Icon(
                            isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                        ),
                        title: Text(parts[index].namePart),
                      ),
                      const Divider()
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade100),
            onPressed: () {
              //clientController.listParts.value = selectedParts;
              List<CartPart> cartPartList = [];
              if (listPartController.partItemsList.isEmpty) {
                print('Lista listPartController.partItemsList estava vazia');
                int id = 0;
                for (var part in selectedParts) {
                  CartPart cartPart = CartPart(
                      name: part.namePart,
                      quantity: part.quantityPart,
                      index: id,
                      price: part.pricePart);
                  id++;
                  cartPartList.add(cartPart);
                }
                listPartController.partItemsList.value = cartPartList;
              }

              if (listPartController.partItemsList.isNotEmpty &&
                  selectedParts.isNotEmpty) {
                    print('Lista listPartController.partItemsList NÃO estava vazia');
                cartPartList = listPartController.partItemsList;
                int id = cartPartList.length + 1;
                for (var part in selectedParts) {
                  CartPart cartPart = CartPart(
                      name: part.namePart,
                      quantity: part.quantityPart,
                      index: id,
                      price: part.pricePart);
                  id++;
                  cartPartList.add(cartPart);
                }
                // listPartController.partItemsList.value = cartPartList;
              }

              // Get.off(() => PageConfirmationPart(part: _cartPartList));
              Get.back();
            },
            child: const Text('Utilizar no orçamento'),
          ),
        ),
      ),
    );
  }

  void _showDetailPart(BuildContext context, Part part) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Detalhes do item',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Text('Nome da peça: ${part.namePart}'),
              Text('Detalhes: ${part.detailsPart}'),
              Text('Unidade de medida: ${part.quantityPart}'),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Editar'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Apagar'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
