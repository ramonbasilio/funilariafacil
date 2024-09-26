import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/provider/listPart_Provider.dart';
import 'package:servicemangerapp/test/model.dart';

class PaginaDeProdutos extends StatefulWidget {
  const PaginaDeProdutos({super.key});

  @override
  State<PaginaDeProdutos> createState() => _PaginaDeProdutosState();
}

class _PaginaDeProdutosState extends State<PaginaDeProdutos> {
  //List<Part> selectedParts = [];

  @override
  Widget build(BuildContext context) {
    PartsProvider partsProvider = Provider.of<PartsProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: partsProvider.allParts.length,
              itemBuilder: (context, index) {
                Part2 part = partsProvider.allParts[index];

                bool isSelected = partsProvider.listPartSelected.contains(part);

                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        partsProvider.togglePartSelection(part);
                      },
                      trailing: Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      title: Text(part.name),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () {
                  List<Part2> temp = partsProvider.addedParts;
                  for (var i in temp) {
                    print('Peças: ${i.name}');
                  }
                  Get.back();
                },
                child: Text('Voltar')),
          ),
        ],
      ),
    );
  }
}
