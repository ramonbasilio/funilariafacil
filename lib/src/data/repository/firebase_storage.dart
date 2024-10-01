import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';
import 'package:uuid/uuid.dart';

class Firebasetorage {
  final _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final String? _emailUser;

  String urlString = '';

  Firebasetorage() {
    _emailUser = _firebaseAuth.currentUser!.email;
  }

  Future<void> uploadImage(
      {required List<File> pathList,
      required List<int> signList,
      required String clientId,
      required String numberDoc,
      required String clientName,
      required BuildContext context}) async {
    Uint8List uint8List = Uint8List.fromList(signList);
    List<String> listString = [];

    if (context.mounted) {
      MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);

      try {
        Reference myRef1 = _firebaseStorage.ref().child(
            '/$_emailUser/$clientId/$numberDoc/sign/sign-$clientName.jpg');
        await myRef1.putData(uint8List);
        urlString = await myRef1.getDownloadURL();
      } on FirebaseException catch (e) {
        print('Erro ao salvar assinatura: $e');
      }

      for (var x in pathList) {
        File file = File(x.path);
        String nameFile = x.path.split('/').last;
        Reference myRef = _firebaseStorage
            .ref()
            .child('/$_emailUser/$clientId/$numberDoc/images/$nameFile');
        await myRef.putFile(file);
        String temp = await myRef.getDownloadURL();
        listString.add(temp);
      }
      myProvider.addPathList(listString, urlString);
    }
  }

  void uploadImageStorage(
      {required List<File> pathList,
      required List<int> signList,
      required BuildContext context}) async {
    Uint8List uint8List = Uint8List.fromList(signList);
    List<String> listString = [];

    if (context.mounted) {
      MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);

      try {
        Reference myRef1 =
            _firebaseStorage.ref().child('$_emailUser/sign/${const Uuid().v4()}.jpg');
        await myRef1.putData(uint8List);
        urlString = await myRef1.getDownloadURL();
        print('salvo com sucesso');
      } on FirebaseException catch (e) {
        print('Erro ao salvar assinatura: $e');
      }

      for (var x in pathList) {
        File file = File(x.path);
        String nameFile = x.path.split('/').last;
        Reference myRef = _firebaseStorage.ref().child('$_emailUser/images/$nameFile');
        await myRef.putFile(file);
        String temp = await myRef.getDownloadURL();
        listString.add(temp);
      }
      myProvider.addPathList(listString, urlString);
    }
  }

  //   Future<void> uploadImage(
  //     {required List<String> pathList,
  //     required List<int> signList,
  //     required String clientId,
  //     required String numberDoc,
  //     required String clientName,
  //     required BuildContext context}) async {
  //   Uint8List uint8List = Uint8List.fromList(signList);

  //   if (context.mounted) {
  //     MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);

  //     try {
  //       Reference myRef = _firebaseStorage.ref().child(
  //           '/$_emailUser/$clientId/$numberDoc/sign/sign-$clientName.jpg');
  //       await myRef.putData(uint8List);
  //       urlString = await myRef.getDownloadURL();
  //     } on FirebaseException catch (e) {
  //       print('Erro ao salvar assinatura: $e');
  //     }

  //     for (var path in pathList) {
  //       if (path.isEmpty) {
  //         listString.add('');
  //       } else {
  //         File file = File(path);
  //         String nameFile = path.split('/').last;
  //         try {
  //           Reference myRef = _firebaseStorage
  //               .ref()
  //               .child('/$_emailUser/$clientId/$numberDoc/images/$nameFile');
  //           await myRef.putFile(file);
  //           String temp = await myRef.getDownloadURL();
  //           listString.add(temp);
  //         } on FirebaseException catch (e) {
  //           print('Erro ao salvar imagens: $e');
  //         }
  //       }
  //     }
  //     myProvider.addPathList(listString, urlString);
  //   }
  // }
}
