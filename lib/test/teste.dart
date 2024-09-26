// import 'dart:ffi';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:servicemangerapp/src/data/model/client.dart';
// import 'package:servicemangerapp/src/data/model/service_order.dart';
// import 'package:servicemangerapp/src/data/provider/listPart_Provider.dart';
// import 'package:servicemangerapp/src/pages/2_pages_buttom/page_my_service_orders/page_share_service_order.dart';
// import 'package:servicemangerapp/src/pages/widgets/camera_widget_2.dart';
// import 'package:servicemangerapp/src/pdf/genarate_pdf.dart';
// import 'package:servicemangerapp/src/pdf/view_pdf_2.dart';

// class Pagina0 extends StatelessWidget {
//   const Pagina0({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: ElevatedButton(
//               onPressed: () {
//                 //listPartGetx.setList(selectedParts);
//                 Get.to(() => PaginaInicial());
//               },
//               child: Text('Ir para pagina inicial')),
//         ),
//       ),
//     );
//   }
// }

// class PaginaInicial extends StatefulWidget {
//   const PaginaInicial({super.key});

//   @override
//   State<PaginaInicial> createState() => _PaginaInicialState();
// }

// class _PaginaInicialState extends State<PaginaInicial> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     Pagina2(),
//     Teste(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Peças'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: <Widget>[
//           BottomNavigationBar(
//             selectedLabelStyle:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             backgroundColor: Colors.grey.shade300,
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: SizedBox.shrink(),
//                 label: 'Cadastro',
//               ),
//               BottomNavigationBarItem(
//                 icon: SizedBox.shrink(),
//                 label: 'Lista de Peças',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.black,
//             onTap: _onItemTapped,
//           ),
//           Expanded(
//             child: Center(
//               child: _widgetOptions.elementAt(_selectedIndex),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Pagina2 extends StatelessWidget {
//   const Pagina2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: ElevatedButton(
//               onPressed: () {
//                 //listPartGetx.setList(selectedParts);
//                 Get.to(() => Pagina0());
//               },
//               child: Text('Voltar')),
//         ),
//       ),
//     );
//   }
// }

// class Teste extends StatefulWidget {
//   const Teste({super.key});

//   @override
//   State<Teste> createState() => _TesteState();
// }

// class _TesteState extends State<Teste> {
//   List<String> parts = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
//   List<String> selectedParts = [];

//   @override
//   Widget build(BuildContext context) {
//     ListPartProviderTeste myProvider =
//         Provider.of<ListPartProviderTeste>(context, listen: false);
//     selectedParts = myProvider.listPartSelected;

//     print('1----');
//     for (var i in selectedParts) {
//       print(i);
//     }
//     print('2----');

//     return Scaffold(
//       body: Column(
//         children: [
//           Flexible(
//             child: ListView.builder(
//               itemCount: parts.length,
//               itemBuilder: (context, index) {
//                 String item = parts[index];
//                 bool isSelected = selectedParts.contains(item);
//                 return Column(
//                   children: [
//                     ListTile(
//                       onTap: () {
//                         // setState(() {
//                         //   if (isSelected) {
//                         //     selectedParts.remove(parts[index]);
//                         //   } else {
//                         //     selectedParts.add(parts[index]);
//                         //   }
//                         // });
//                       },
//                       trailing: Icon(
//                         isSelected
//                             ? Icons.check_box
//                             : Icons.check_box_outline_blank,
//                       ),
//                       title: Text(parts[index]),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: ElevatedButton(
//                 onPressed: () {
//                   myProvider.setList(selectedParts);
//                   //listPartGetx.setList(selectedParts);
//                   Get.back();
//                 },
//                 child: Text('Voltar')),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: ElevatedButton(
//                 onPressed: () {
//                   //myProvider.setList(selectedParts);
//                   //listPartGetx.setList(selectedParts);
//                   Get.to(() => Pagina2());
//                 },
//                 child: Text('PAgina 2')),
//           )
//         ],
//       ),
//     );
//   }
// }
