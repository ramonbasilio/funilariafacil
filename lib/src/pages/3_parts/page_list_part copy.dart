// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:servicemangerapp/src/data/model/cartPart.dart';
// import 'package:servicemangerapp/src/data/model/part.dart';
// import 'package:servicemangerapp/src/data/provider/common_provider.dart';
// import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
// import 'package:servicemangerapp/src/data/provider/listPart_Getx.dart';
// import 'package:servicemangerapp/src/data/provider/listPart_Provider.dart';
// import 'package:servicemangerapp/src/data/provider/provider.dart';

// class PageListPart2 extends StatefulWidget {
//   const PageListPart2({super.key});

//   @override
//   State<PageListPart2> createState() => _PageListPart2State();
// }

// class _PageListPart2State extends State<PageListPart2> {
//   ManagerProvider clientController = Get.find();
//   ListPartControllerGext listPartController = Get.find();
//   List<Part> selectedParts = [];
//   List<Part> parts = [];

//   Future<void> callParts() async {
//     await clientController.getAllPartsProvider();
//   }

//   @override
//   void initState() {
//     callParts();
//     parts = clientController.allParts;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ListPartProvider2 listPartController2 =
//         Provider.of<ListPartProvider2>(context, listen: false);
//     selectedParts = listPartController2.listPartSelected;
//     print('1----');
//     for (var i in selectedParts) {
//       print(i.name);
//     }
//     print('2----');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lista de peças'),
//       ),
//       body: Column(
//         children: [
//           Flexible(
//             child: ListView.builder(
//               itemCount: parts.length,
//               itemBuilder: (context, index) {
//                 Part item = parts[index];
//                 bool isSelected =
//                     listPartController2.listPartSelected.contains(item);
//                 return Column(
//                   children: [
//                     ListTile(
//                       onLongPress: (() {
//                         _showDetailPart(context, parts[index]);
//                       }),
//                       onTap: () {
//                         setState(() {
//                           if (isSelected) {
//                             //selectedParts.remove(parts[index]);
//                             listPartController2.listPartSelected
//                                 .remove(parts[index]);
//                           } else {
//                             //selectedParts.add(parts[index]);
//                             listPartController2.listPartSelected
//                                 .add(parts[index]);
//                           }
//                         });
//                       },
//                       trailing: Icon(
//                         isSelected
//                             ? Icons.check_box
//                             : Icons.check_box_outline_blank,
//                       ),
//                       title: Text(parts[index].name),
//                     ),
//                     const Divider()
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 50,
//         margin: const EdgeInsets.all(10),
//         child: SizedBox(
//           width: double.maxFinite,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green.shade100),
//             onPressed: () {
//               List<CartPart> cartPartList = [];
//               if (listPartController.partItemsList.isEmpty) {
//                 int id = 0;
//                 for (var part in listPartController2.listPartSelected) {
//                   CartPart cartPart = CartPart(
//                       name: part.name,
//                       quantity: part.quantity,
//                       index: id,
//                       price: part.price);
//                   id++;
//                   cartPartList.add(cartPart);
//                 }
//                 listPartController.partItemsList.value = cartPartList;
//               }

//               if (cartPartList.isEmpty) {
//                 cartPartList = listPartController.partItemsList;
//                 int id = cartPartList.length + 1;
//                 for (var part in selectedParts) {
//                   CartPart cartPart = CartPart(
//                       name: part.name,
//                       quantity: part.quantity,
//                       index: id,
//                       price: part.price);
//                   id++;
//                   cartPartList.add(cartPart);
//                 }
//               }

//               // Get.off(() => PageConfirmationPart(part: _cartPartList));
//               //listPartController.selectedItemsParts.value = selectedParts;
//               listPartController2.setList(selectedParts);
//               Get.back();
//             },
//             child: const Text('Utilizar no orçamento'),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showDetailPart(BuildContext context, Part part) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return SizedBox(
//           height: 200,
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                 child: Text(
//                   'Detalhes do item',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//               Text('Nome da peça: ${part.name}'),
//               Text('Detalhes: ${part.detail}'),
//               Text('Unidade de medida: ${part.quantity}'),
//               Row(
//                 children: [
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text('Editar'),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text('Apagar'),
//                   )
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
