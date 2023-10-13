import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
// Fetching All Item

  Future<List<Map>> fetchItem() async {
    List<Map> items = [];

    // Get Data From Api Here !
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      // Get Data From Response
      String jsonString = response.body;
      // Convert To List<Map>
      List data = jsonDecode(jsonString);
      items = data.cast<Map>();
    }
    return items;
  }

// Fetch Details One Item
  Future<Map> getItem(itemId) async {
    Map item = {};

    // Get The Item From Api !
    http.Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'));

    if (response.statusCode == 200) {
      // Get Data From Response
      String jsonString = response.body;
      // Convert To List<Map>
      item = jsonDecode(jsonString);
    }

    return item;
  }

// Add New Item
  Future<bool> addItem(Map data) async {
    bool status = false;

// Add Item
    http.Response response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(data),
        headers: {
          'Content-type': 'application/json',
        });
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

// Update Item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    // Update Item
    http.Response response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
        body: jsonEncode(data),
        headers: {
          'Content-type': 'application/json',
        });
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }

    return status;
  }

// Delete Item
Future<bool> deleteItem(String itemId) async {
    bool status = false;

    // Delet Item
    http.Response response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'));
    if (response.statusCode == 200) {
      status = true;
    }

    return status;
  }
}
