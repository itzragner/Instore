import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:instore/models/product.dart';
import 'package:instore/services/auth.dart';
import 'package:instore/services/global.dart';

class InstagrameurController extends GetxController {
  final String apiUrl = '${baseURL}instagrammers';
  var isLoading = true.obs;
  var productData = {}.obs;
  Future<List<Product>> getProducts() async {
    final token = controller.token;

    List<Product> dataList = [];
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/getProviderProducts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final dynamic productsData = jsonDecode(response.body)["data"];
        for (var product in productsData) {
          final newProduct = Product(
            name: product['name'],
            id: product['id'],
            image: product['images'][0]['path'],
            colors: product['colors'],
            description: product['description'],
            brand: product['brand'],
            category: product['category'],
            priceSale: double.parse(product['priceSale']),
            quantity: product['quantity'],
            sizes: product['sizes'],
            subcategorie: product['subcategorie'],
          );

          dataList.add(newProduct);
        }
      } else {}
    } catch (e) {}
    return dataList;
  }

  Future fetchData(int id) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${controller.token}',
    };
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/showProduct/$id'),
        headers: header,
      );
      if (response.statusCode == 200) {
        productData.value = json.decode(response.body);
        var data = productData['data'];
        isLoading.value = false;
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future addProductProvider(payload) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${controller.token}',
    };
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/addProductProvider'),
        body: jsonEncode(payload),
        headers: header,
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        isLoading.value = false;
        return res;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future getStoreProducts() async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${controller.token}',
    };
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/getStoreProducts'),
        headers: header,
      );
      // http.get(Uri.parse('$apiUrl/showProduct/1'));
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        isLoading.value = false;
        return res;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
