import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/services/instagrameur.dart';
import 'package:instore/services/global.dart';
import 'screens/splash_screen.dart';

void main() {
  Get.put(GlobalController());
  Get.put(InstagrameurController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instore',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
