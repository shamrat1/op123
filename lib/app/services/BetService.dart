import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';

class BetService {
  Future<http.Response> placeBet(Map<String, dynamic> data) async {
    print(json.encode(data));
    var url = rootUrl + "place/bet";
    var headers = await RemoteService.getAuthenticatedHeader();
    var response =
        await http.post(Uri.parse(url), headers: headers, body: data);
    return response;
  }
}
