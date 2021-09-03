import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/Match.dart';

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
    var headers = getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }

  static Map<String, String> getAuthenticatedHeader() {
    return {
      "Authorization": "Bearer token here",
      "content": "application/json",
      "accepts": "application/json"
    };
  }
}
