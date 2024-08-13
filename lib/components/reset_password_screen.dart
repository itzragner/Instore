import 'package:flutter/material.dart';
import '../components/verification_code_screen.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réinitialisation du mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Adresse e-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const VerificationCodeScreen());
              },
              child: const Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}
