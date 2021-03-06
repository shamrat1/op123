import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:riverpod/riverpod.dart';

class RemoteService {
  Future<List<Match>> getMatches(
      {String params = "status=live&sport=all"}) async {
    var url = rootUrl + "matches?$params&origin=mobile";
    print(url);
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

  Future<http.Response> updareUserInfo(Map<String, dynamic> data) async {
    var url = rootUrl + "user/info";
    var headers = await getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    return response;
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

  Future<http.Response> getSettings() async {
    var url = rootUrl + "settings/xxxyyyzzz";
    return await http
        .get(Uri.parse(url), headers: {"accept": "application/json"});
  }

  Future<http.Response> getRegisterEssentials() async {
    var url = rootUrl + "registration/essential";
    return await http
        .get(Uri.parse(url), headers: {"accept": "application/json"});
  }

  static Future<Map<String, String>> getAuthenticatedHeader() async {
    var token = await FlutterSecureStorage().read(key: tokenKey) ?? null;
    if (token != null) {
      return {
        "Authorization": "Bearer $token",
        "content": "application/json",
        "accepts": "application/json",
        'Access-Control-Allow-Origin': '*',
        "Access-Control-Allow-Credentials": "true",
        "Access-Control-Allow-Methods": "GET,HEAD,OPTIONS,POST,PUT",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
      };
    }
    toast("Login to play");
    throw Exception("No Authorization Token Found");
  }
}
