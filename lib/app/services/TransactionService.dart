import 'dart:convert';

import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/services/RemoteService.dart';
import 'package:http/http.dart' as http;

class TransactionService {

  
  Future<http.Response> allTransactions(String type) async {
    var url = rootUrl + "/transactions?type=$type";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  void deposit(Map<String, dynamic> data) async {
    var url = rootUrl + "/deposit";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }

  void withdraw(Map<String, dynamic> data) async {
    var url = rootUrl + "/withdraw";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }

  void coinTransfer(Map<String, dynamic> data) async {
    var url = rootUrl + "/withdraw";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }
}
