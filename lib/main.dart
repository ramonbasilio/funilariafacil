import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/provider/listPart_Provider.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servicemangerapp/src/data/ProviderCarDetails/ProviderCarDetails.dart';
import 'package:servicemangerapp/src/pages/0_pages_login/page_splash/page_splash.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_part.dart';
import 'package:servicemangerapp/test/home_teste.dart';
import 'package:servicemangerapp/test/model.dart';
import 'package:servicemangerapp/test/teste.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => ListPartProvider2()),
        ChangeNotifierProvider(
            create: (context) => PartsProvider()), //ProviderCarDetails
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            primary: Colors.grey.shade900, seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: PageSplash(),
    );
  }
}
