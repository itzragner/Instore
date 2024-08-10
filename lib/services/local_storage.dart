import 'package:get/get.dart';
import 'package:instore/services/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalController controller = Get.find<GlobalController>();

class LocalStorageServices {
  saveToken(String token, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    return token;
  }


}
