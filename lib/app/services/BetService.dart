import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/services/RemoteService.dart';

class GameService {
  
  Future<http.Response> placeBet(Map<String, dynamic> data) async {
    var url = rootUrl + "/placeBet";
    var headers = RemoteService.getAuthenticatedHeader();
    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
    return response;
  }
}
