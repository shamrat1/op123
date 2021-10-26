import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/GameHistoryResponse.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/services/RemoteService.dart';

class GameService {
  Future<List<Match>> startCoinGame(Map<String, dynamic> data) async {
    var url = rootUrl + "game/coin-toss/start";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {
      return matchFromMap(response.body);
    }
    return [];
  }

  Future<GameHistoryResponse> initialGameRegister(
      Map<String, dynamic> data) async {
    print(data);
    var url = rootUrl + "place/game/history";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return gameHistoryResponseFromMap(response.body);
    } else {
      showCustomSimpleNotification(response.body, Colors.red);
      throw Exception(response.body);
    }
  }

  void placeBet(Map<String, dynamic> data) async {
    var url = rootUrl + "/placeBet";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }
}
