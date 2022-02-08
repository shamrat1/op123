import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:OnPlay365/app/constants/globals.dart';

class AuthenticationService {
  Future<http.Response> signIn(Map<String, dynamic> data) async {
    var url = rootUrl + "login";
    var headers = _getUnAuthenticatedHeader();
    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);

    return response;
  }

  Future<http.Response> signUp(Map<String, dynamic> data) async {
    var url = rootUrl + "registration";
    try{
      var headers = _getUnAuthenticatedHeader();

      var response = await http.post(Uri.parse(url), headers: headers, body: data);
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }

  }

  Map<String, String> _getUnAuthenticatedHeader() {
    return {
      "content": "application/json",
      "accepts": "application/json",
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Methods": "GET,HEAD,OPTIONS,POST,PUT",
      "Access-Control-Allow-Headers":
          "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
    };
  }
}
