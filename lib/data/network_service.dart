import 'dart:convert';

import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "http://192.168.100.96:3000";
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + "/activities"));
      return jsonDecode(response.body) as List;
    } catch (e) {
      return [];
    }
  }

  addActivity(Map<String, String> activityObj) async {
    try {
      final response =
          await post(Uri.parse(baseUrl + "/activities"), body: activityObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateActivity(Map<String, String> activityObj, int id) async {
    print(activityObj);
    print(id);
    try {
      await patch(Uri.parse(baseUrl + "/activities/$id"), body: activityObj);
      return true;
    } catch (e) {
      return false;
    }
  }
}
