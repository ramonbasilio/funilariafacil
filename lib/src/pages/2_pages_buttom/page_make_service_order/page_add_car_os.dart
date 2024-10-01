import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/constants.dart';
import 'package:servicemangerapp/src/data/model/car.dart';
import 'package:servicemangerapp/src/data/ProviderCarDetails/ProviderCarDetails.dart';
import 'package:servicemangerapp/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageAddCarOs extends StatefulWidget {
  const PageAddCarOs({super.key});

  @override
  State<PageAddCarOs> createState() => _PageAddCarOsState();
}

class _PageAddCarOsState extends State<PageAddCarOs> {
  String? selectedBrand;
  String? selectedModel;
  String? selectedYear;
  String? selectedColor;
  TextEditingController notesController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final List<String> carBrands = Constants.carsBrand;
  final List<String> carsChevrolet = Constants.carsChevrolet;
  final List<String> carsFiat = Constants.carsFiat;
  final List<String> carsHonda = Constants.carsHonda;
  final List<String> carsHyundai = Constants.carsHyundai;
  final List<String> carsJeep = Constants.carsJeep;
  final List<String> carsRenault = Constants.carsRenault;
  final List<String> carsToyota = Constants.carsToyota;
  final List<String> carsVolkswagen = Constants.carsVolkswagen;

  List<String> carModels = [];

  @override
  Widget build(BuildContext context) {
    if (carBrands.isNotEmpty) {
      Utils.sortList(carBrands);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Selection Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Campo de seleção para marcas
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Marca do carro'),
                value: selectedBrand,
                items: carBrands.map((String brand) {
                  return DropdownMenuItem<String>(
                    value: brand,
                    child: Text(brand),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBrand = value;
                    selectedModel =
                        null; // Resetar o modelo quando mudar a marca
                    carModels = getModelList(selectedBrand);
                    if (carModels.isNotEmpty) {
                      carModels.sort((b, a) => b.compareTo(a));
                    }
                  });
                },
              ),
              const SizedBox(height: 16),

              // Campo de seleção para modelo
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Modelo do carro'),
                value: selectedModel,
                items: carModels.isNotEmpty
                    ? carModels.map((String model) {
                        return DropdownMenuItem<String>(
                          value: model,
                          child: Text(model),
                        );
                      }).toList()
                    : null,
                onChanged: (value) {
                  setState(() {
                    selectedModel = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Campo de inserção do ano
              TextFormField(
                inputFormatters: [MaskedInputFormatter('####')],
                decoration: const InputDecoration(labelText: 'Ano do carro'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cor do carro'),
                onChanged: (value) {
                  setState(() {
                    selectedColor = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.datetime,
                inputFormatters: [MaskedInputFormatter('##/##/####')],
                controller: dateController,
                decoration:
                    const InputDecoration(labelText: 'Data entrada na oficina'),
              ),
              const SizedBox(height: 16),
              // Campo para notas
              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notas'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // Ação ao pressionar o botão, como salvar os dados
                  print('Marca: $selectedBrand');
                  print('Modelo: $selectedModel');
                  print('Ano: $selectedYear');
                  print('Notas: ${notesController.text}');

                  if (selectedBrand!.isNotEmpty &&
                      selectedModel!.isNotEmpty &&
                      selectedColor!.isNotEmpty &&
                      dateController.text.isNotEmpty &&
                      selectedYear!.isNotEmpty) {
                    Car car = Car(
                        model: selectedBrand!,
                        brand: selectedModel!,
                        color: selectedColor!,
                        year: selectedYear!,
                        date: dateController.text,
                        notes: notesController.text == ''
                            ? 'Sem notas'
                            : notesController.text);
                    Get.back(result: car);
                  } else {
                    print('Dados faltantes');
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para retornar a lista de modelos de acordo com a marca selecionada
  List<String> getModelList(String? brand) {
    switch (brand) {
      case 'Chevrolet':
        return carsChevrolet;
      case 'Fiat':
        return carsFiat;
      case 'Honda':
        return carsHonda;
      case 'Jeep':
        return carsJeep;
      case 'Renault':
        return carsRenault;
      case 'Toyota':
        return carsToyota;
      case 'Volkswagen':
        return carsVolkswagen;
      case 'Hyundai':
        return carsHyundai;

      default:
        return [];
    }
  }
}
