import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/components/controllers/auth_controller.dart';
import 'package:instore/services/global.dart';
import '../components/mdp1.dart';
import 'sign_upinstascreen.dart';

class LoginInstaScreen extends StatelessWidget {
  final AuthController authController = AuthController();
  final GlobalController controller1 = Get.find<GlobalController>();

  LoginInstaScreen({super.key});
  login() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/instore.png',
            height: 50,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: authController.emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    fillColor: Colors.green.withOpacity(0.1),
                    filled: true,
                    errorText: null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) => authController.validateEmail(value),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: authController.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    suffixIcon: IconButton(
                      onPressed: authController.togglePasswordVisibility,
                      icon: Icon(authController.obscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    fillColor: authController.isPasswordValid.value
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    filled: true,
                    errorText: authController.isPasswordValid.value
                        ? null
                        : 'Mot de passe requis',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: authController.obscurePassword.value,
                  onChanged: (value) => authController.validatePassword(value),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => const ForgetPassword());
                      },
                      child: const Text(
                        'Mot de passe oublié?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 19, 19),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    authController.loginUser();
                    // Get.off(() => HomeView());
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF15A0FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Obx(() => authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Se connecter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                ),
                if (authController.errorMessage.value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      authController.errorMessage.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 10.0),
                const Center(
                  child: Text(
                    "Vous n'avez pas de compte?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => const SignUpInstaScreen());
                  },
                  child: const Text(
                    'Créer un compte',
                    style: TextStyle(
                      color: Color.fromARGB(255, 14, 15, 15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
