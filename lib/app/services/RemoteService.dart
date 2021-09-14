import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/Match.dart';
import 'package:riverpod/riverpod.dart';

class RemoteService {
  Future<List<Match>> getMatches(
      {String sport = "all", String type = "live"}) async {
    var url = rootUrl + "matches?sport=$sport&type=$type";
    // print(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return matchFromMap(response.body);
    }
    return [];
  }

  void placeBet(Map<String, dynamic> data) async {
    var url = rootUrl + "/placeBet";
    var headers = await getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }

  Future<http.Response> getUserInfo() async {
    var url = rootUrl + "user/info";
    var headers = await getAuthenticatedHeader();
    var response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  Future<http.Response> getBetHistory() async {
    var url = rootUrl + "bet/history";
    var headers = await getAuthenticatedHeader();
    var response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  static Future<Map<String, String>> getAuthenticatedHeader() async {
    var token = await FlutterSecureStorage().read(key: tokenKey);
    if (token != null) {
      return {
        "Authorization": "Bearer $token",
        "content": "application/json",
        "accepts": "application/json"
      };
    }

    throw Exception("No Authorization Token Found");
  }
}
