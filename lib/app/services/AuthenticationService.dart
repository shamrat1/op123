
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:op123/app/constants/globals.dart';


class AuthenticationService{

    void signIn(Map<String, dynamic> data) async {
    var url = rootUrl + "/sign/in";
    var headers = _getUnAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),headers: headers,body: json.encode(data));
    if(response.statusCode == 200){

    }
  }

  void signUp(Map<String, dynamic> data) async {
    var url = rootUrl + "/sign/up";
    var headers = _getUnAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),headers: headers,body: json.encode(data));
    if(response.statusCode == 200){

    }
  }

  Map<String, String> _getUnAuthenticatedHeader() {
    return {
      "content": "application/json",
      "accepts": "application/json"
    };
  }
}