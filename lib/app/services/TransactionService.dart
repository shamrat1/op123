import 'dart:convert';

import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/models/GeneralResponse.dart';
import 'package:OnPlay365/app/models/OffersResponse.dart';
import 'package:OnPlay365/app/models/TransactionResponse.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';
import 'package:http/http.dart' as http;

class TransactionService {

  Future<TransactionsResponse> allTransactions(String? type) async {
    var url = rootUrl + "transactions?type=$type";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.get(Uri.parse(url), headers: headers);

    return transactionsResponseFromMap(response.body);
  }

  Future<List<OffersResponse>> allOffers() async {
    var url = rootUrl + "offers";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.get(Uri.parse(url), headers: headers);

    return offersResponseFromJson(response.body);
  }

  Future<http.Response> deposit(Map<String, dynamic> data) async {
    var url = rootUrl + "deposit";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: data);
    return response;
  }

  Future<http.Response> withdraw(Map<String, dynamic> data) async {
    var url = rootUrl + "withdraw";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: data);
    return response;
  }

  void coinTransfer(Map<String, dynamic> data) async {
    var url = rootUrl + "withdraw";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }
}
