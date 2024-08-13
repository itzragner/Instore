import 'package:flutter/material.dart';
import '../components/new_password_screen.dart';
import 'package:get/get.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification du code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Code de vérification'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Get.to(() => NewPasswordScreen());
              },
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
