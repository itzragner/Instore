import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/services/auth.dart';
import 'package:instore/services/global.dart';
// import 'package:get/get.dart';
// import 'package:saverapp/Services/auth.dart';
// import 'package:saverapp/Services/globals.dart';
// import '../widget/rounded_button.dart';
import '../components/mdp2.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalController controller = Get.find<GlobalController>();
  late String _email = '';
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffebf7),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        actions: const [],
        //       leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // logo
              Icon(
                Icons.lock,
                size: 100,
                color: Colors.grey[500],
              ),
              const SizedBox(height: 10),

              // welcome back, you've been missed!
              const Text(
                'Oublier Mot de Passe',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: const Color(0xFFFA058C), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        } else if (!isValidEmail(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: const Color(0xFFFA058C),
                onPressed: () {
                  forgetPassword();
                  Get.to(() => const Code(), arguments: _email);
                },
                minWidth: 290,
                height: 45,
                child: const Text(
                  'Envoyer Email',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  forgetPassword() async {
    Map<String, dynamic> response = await AuthService.forgetPassword(_email);
    if (response["status"] == 200) {
      controller.setEmail(_email);
      // print(response);
      Get.toNamed('/verifPasswordCode');
    }
  }
}
