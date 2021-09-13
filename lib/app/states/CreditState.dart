import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_context/one_context.dart';
import 'package:op123/app/models/GeneralResponse.dart';
import 'package:op123/app/services/RemoteService.dart';
import 'package:overlay_support/overlay_support.dart';

var creditProvider =
    StateNotifierProvider<CreditState, double>((ref) => CreditState(0.0));

class CreditState extends StateNotifier<double> {
  CreditState(double state) : super(state) {
    fetchCredit();
  }

  void change(double amount) => state = amount;

  fetchCredit() async {
    var response = await RemoteService().getUserInfo();
    if (response.statusCode == 200) {
      var generalResponse = generalResponseFromMap(response.body);
      var amount = generalResponse.user?.credit?.amount;
      if (amount != null) {
        print("credit :-> $amount");
        state = double.parse(amount);
      }
    } else {
      toast(
          "${response.statusCode} Error Receiving User Credit info. ${response.body}");
    }
  }
}
