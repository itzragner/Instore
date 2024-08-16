import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/services/local_storage.dart';

const String localhost = "192.168.1.12";

const String baseURL = "http://$localhost:8000/api/";
const String frontOfiiceUrl = "http://localhost:4200/details/";
final token = controller.token;
Map<String, String> headers = {
  "Content-Type": "application/json",
  'Authorization': 'Bearer $token',
};

void errorSnackBar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class GlobalController extends GetxController {
  // variables declaration

  final _email = ''.obs;
  final _token = ''.obs;
  final _role = ''.obs;
  final _firstLogin = true.obs;

  // var partner = Partner(
  //   name: "",
  //   image: "",
  //   id: 0,
  //   description: "",
  //   email: "",
  //   phone: 0,
  //   closingtime: "",
  //   openingtime: "",
  //   lat: 0,
  //   long: 0,
  //   adress: "",
  //   likes: false,
  // );

  //getters
  String get email => _email.value;
  String get token => _token.value;

// setters
  void setEmail(String email) {
    _email.value = email;
  }

  void setToken(String token) {
    _token.value = token;
    update();
  }

  void setRole(String role) {
    _role.value = role;
  }

  void setFirstLogin(bool firstLogin) {
    _firstLogin.value = firstLogin;
  }

  var value = 1.obs; // Define an observable variable
}
