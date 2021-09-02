import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/services/RemoteService.dart';

class GameService {
  Future<List<Match>> startCoinGame(Map<String, dynamic> data) async {
    var url = rootUrl + "game/coin-toss/start";
    var headers = RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {
      return matchFromMap(response.body);
    }
    return [];
  }

  void placeBet(Map<String, dynamic> data) async {
    var url = rootUrl + "/placeBet";
    var headers = RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    if (response.statusCode == 200) {}
  }
}
