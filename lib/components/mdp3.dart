import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/components/login_instascreen.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:saverapp/Screens/login.dart';
// import '../Services/globals.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController newPasswordController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
  }

  Future<void> updatePassword() async {
    final String email = Get.arguments;
    final password = newPasswordController.text;

    // Send a PUT request to the backend to update the password
    final response = await http.put(
      Uri.parse('http://192.168.100.19:8000/api/changePassword'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      // Password updated successfully, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password updated successfully',
            style: TextStyle(color: Colors.green.shade800),
          ),
          backgroundColor: Colors.white,
        ),
      );
    } else {
      // Password update failed, show an error message
      final errorMessage = response.body;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String email = Get.arguments;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFffebf7),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          actions: [],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          height: 2000,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //change password
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Changer Mot De Passe",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFFFA058C),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Container(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20.0),
              //     child: TextFormField(
              //       controller: emailController,
              //       decoration: const InputDecoration(
              //         contentPadding: EdgeInsets.symmetric(
              //             horizontal: 30.0, vertical: 14.0),
              //         prefixIcon: Icon(Icons.lock),
              //         labelText: 'Email',
              //         border: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.lock),
                      labelText: ' password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: MaterialButton(
                  elevation: 5,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFFFA058C),
                  onPressed: () {
                     updatePassword();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LoginInstaScreen()),
                    );
                  },
                  minWidth: 200,
                  height: 45,
                  child: Text(
                    'Confirmer ',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
