import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_context/one_context.dart';
import 'package:OnPlay365/app/models/GeneralResponse.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';
import 'package:overlay_support/overlay_support.dart';

var creditProvider =
    StateNotifierProvider<CreditState, List<double>>((ref) => CreditState([0.0, 0.0]));

class CreditState extends StateNotifier<List<double>> {
  CreditState(List<double> state) : super(state) {
    fetchCredit();
  }

  void change(double amount) => state[0] = amount;

  fetchCredit() async {
    var response = await RemoteService().getUserInfo();
    if (response.statusCode == 200) {
      var generalResponse = generalResponseFromMap(response.body);
      var amount = generalResponse.user?.credit?.amount;
      var abonus = generalResponse.user?.credit?.bonusPoint ?? "0";

      if (amount != null) {
        print("credit :-> $amount");
        state[0] = double.parse(amount);
        state[1] = double.parse(abonus);
        state = state;
      }
    } else {
      toast(
          "${response.statusCode} Error Receiving User Credit info. ${response.body}");
    }
  }
}
