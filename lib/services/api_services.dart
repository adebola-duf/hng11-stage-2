import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:myapp/models/shoe_inventory.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl =
      'https://api.timbu.cloud/products?organization_id=ad3b27102a65484287f7f8df11cbd02e&Appid=7EMIBZ220GQUGY3&Apikey=2d36d6f184b943d9a4ea4cc5f080a8a920240706165909241681';

  Future<ShoeInventory> loadShoeInventory() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.timbu.cloud/products?organization_id=ad3b27102a65484287f7f8df11cbd02e&Appid=7EMIBZ220GQUGY3&Apikey=2d36d6f184b943d9a4ea4cc5f080a8a920240706165909241681'),
      );
      return ShoeInventory.fromJson(jsonDecode(response.body));
    } on SocketException {
      throw Exception(
          'No Internet connection found. Please check your internet connection and try again');
    } on TimeoutException {
      throw Exception(
          'The request took too long to complete. Please check your internet connection and try again.');
    } catch (e) {
      throw Exception(
          'An unknown error occurred. Please close the app and reopen it.');
    }
  }
}
