import 'package:flutter/material.dart';
import '../components/new_password_screen.dart';
import 'package:get/get.dart';

class VerificationCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vérification du code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Code de vérification'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Get.to(() => NewPasswordScreen());
              },
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
