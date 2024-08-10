import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:instore/services/global.dart';

final GlobalController controller = Get.find<GlobalController>();

class AuthService {
  static Future<Map> register(
    String name,
    String email,
    String phone,
    String password,
    String role,
  ) async {
    Map data = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "role": role,
    };
    var body = json.encode(data);
    var url = Uri.parse('${{baseURL}}register');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["status"] == 400) {
        return {
          "error": jsonDecode(response.body)["0"],
          "status": jsonDecode(response.body)["status"]
        };
      } else {
        throw jsonDecode(response.body);
      }
    } else if (response.statusCode == 201) {
      if (jsonDecode(response.body)['status'] == 200) {
        return {
          "message": jsonDecode(response.body)['message'],
          "token": jsonDecode(response.body)['token'],
          "status": jsonDecode(response.body)['status'],
        };
      } else {
        throw jsonDecode(response.body);
      }
    } else {
      throw jsonDecode(response.body);
    }
  }

  static Future<Map<String, dynamic>> forgetPassword(String email) async {
    String email0 = email;
    Map<String, dynamic> responseMessage = {}; // Initialize with an empty map
    var body = jsonEncode({"email": email0});
    final url = Uri.parse('${{baseURL}}forgetPassword');

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        responseMessage = {
          "response": response.body,
          "status": response.statusCode
        };
      } else {
        responseMessage = {
          "response": response.body,
          "status": response.statusCode
        };
      }
    } catch (e) {
      responseMessage = {
        "response": "An error occurred. Please try again.",
        "status": 500,
        "error": e
      };
    }
    return responseMessage;
  }

  static Future<Map<String, dynamic>> sendVerifCode(String verifCode) async {
    var email = controller.email;

    late Map<String, dynamic> responseMessage;
    var body = json.encode({
      "code": verifCode,
      "email": email,
    });
    final url = Uri.parse('${{baseURL}}verifCode');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      responseMessage = {
        "response": json.decode(response.body),
      };
    } else {
      responseMessage = {"status": response.statusCode};
    }
    return responseMessage;
  }

  static Future<http.Response> logout() async {
    var token = controller.token;
    var url = Uri.parse('${{baseURL}}/logout');
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.body.isNotEmpty) {}
    return response;
  }
}
