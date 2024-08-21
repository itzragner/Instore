import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/routes.dart';
import 'package:instore/services/instagrameur.dart';
import 'package:instore/services/global.dart';
import 'screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/product_screen.dart';
import 'screens/profil_screen.dart';

import 'screens/splash_screen.dart';
import 'screens/login_instascreen.dart';
import 'screens/sign_upinstascreen.dart';

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
      initialRoute: '/',
      getPages: routes,
      title: 'Instore',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
