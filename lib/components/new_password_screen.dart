import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nouveau mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Confirmer le mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Logique pour réinitialiser le mot de passe
              },
              child: const Text('Réinitialiser le mot de passe'),
            ),
          ],
        ),
      ),
    );
  }
}
