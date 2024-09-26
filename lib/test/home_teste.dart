import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/test/product_page.dart';

class HomeTeste extends StatelessWidget {
  const HomeTeste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () {
                Get.to(() => PaginaDeProdutos());
              },
              child: const Text('Ir para de produtos')),
        ),
      ),
    );
  }
}
