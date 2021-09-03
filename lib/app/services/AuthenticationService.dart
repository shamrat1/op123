import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:op123/app/constants/globals.dart';

class AuthenticationService {
  Future<http.Response> signIn(Map<String, dynamic> data) async {
    var url = rootUrl + "login";
    print(json.encode(data));
    var headers = _getUnAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: data);

    return response;
  }

  void signUp(Map<String, dynamic> data) async {
    var url = rootUrl + "register";
    var headers = _getUnAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }

  Map<String, String> _getUnAuthenticatedHeader() {
    return {"content": "application/json", "accepts": "application/json"};
  }
}
