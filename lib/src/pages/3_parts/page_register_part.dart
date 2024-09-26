import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_list_part.dart';
import 'package:servicemangerapp/src/pages/widgets/camera/camera_init_mult_img.dart';
import 'package:servicemangerapp/src/pages/widgets/camera/camera_init_one_img.dart';
import 'package:servicemangerapp/src/pages/widgets/camera_widget_3.dart';

class PageRegisterPart extends StatefulWidget {
  const PageRegisterPart({super.key});

  @override
  State<PageRegisterPart> createState() => _PageRegisterPartState();
}

class _PageRegisterPartState extends State<PageRegisterPart> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();

  final List<String> _unidades = ['Kg', 'Litro', 'Metro', 'Unidade', 'Caixa'];
  String stringImagePath = '';
  bool isChecked = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _priceController.addListener(() {
  //     String sanitizedText =
  //         _priceController.text.replaceAll(RegExp(r'[^0-9,.]'), '');
  //     sanitizedText = sanitizedText.replaceAll(',', '.');
  //     if (sanitizedText != _priceController.text) {
  //       _priceController.value = TextEditingValue(
  //         text: sanitizedText,
  //         selection: TextSelection.fromPosition(
  //           TextPosition(offset: sanitizedText.length),
  //         ),
  //       );
  //     }
  //   });
  // }

  double parseToDouble(String input) {
    // Remove espaços em branco
    input = input.trim();
    input = input.replaceAll(RegExp(r'[^0-9,.]'), '');
    input = input.replaceAll(',', '.');
    // Tenta converter a entrada para double
    try {
      return double.parse(input);
    } catch (e) {
      throw FormatException("Valor inválido: $input");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Peça',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da peça';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'Detalhes',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os detalhes';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  _showUnitBottomSheet(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _unitController,
                    decoration: const InputDecoration(
                      labelText: 'Unidade de medida',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione a unidade';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  value = value.replaceAll(',', '.');
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor numérico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              //const SizedBox(height: 24),
              CameraInitOneImg(
                finalReturn: (String value) {
                  stringImagePath = value;
                },
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.8,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text('Salvar na lista de peças')
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100),
                onPressed: () async {
                  Part part = Part(
                      name: _nameController.text,
                      detail: _detailsController.text,
                      unit: _unitController.text,
                      price: parseToDouble(_priceController.text));
                  await FirebaseCloudFirestore()
                      .registerPart(part: part)
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Peça salva com sucesso!')),
                    );
                  });
                },
                child: const Text('Salvar / Utilizar no orçamento'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUnitBottomSheet(BuildContext context) {
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
                  'Unidade de medido do item',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _unidades.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_unidades[index]),
                      onTap: () {
                        setState(() {
                          _unitController.text = _unidades[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
