import 'dart:async';

import 'package:flutter/material.dart';

class SplashhScreen extends StatefulWidget {
  const SplashhScreen({super.key});

  @override
  State<SplashhScreen> createState() => _SplashhScreenState();
}

class _SplashhScreenState extends State<SplashhScreen> {
  @override
  void initState() {
    Timer(
        Duration(
          seconds: 60,
        ), () async {
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user == null) {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => loginScreen(),
      //         ));
      //   } else {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           // builder: (context) => mainScreen(),
      //         ));
      //   }
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffebf7),
      body: Center(
        child: Image.asset(
          'assets/instore.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
