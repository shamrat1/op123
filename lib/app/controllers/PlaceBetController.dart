import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/services/BetService.dart';
import 'package:op123/app/states/CreditState.dart';
import 'package:op123/views/widgets/BetHistory.dart';
import 'package:op123/views/widgets/PlaceBetWidget.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:validators/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PlacedBetEvent { Show, Register }

class PlacedBetController {
  final PlaceBetObjectModel? modelObject;
  final BuildContext context;
  final String? amount;
  final PlacedBetEvent event;

  PlacedBetController({
    this.modelObject,
    required this.context,
    this.amount,
    required this.event,
  });

  int userCredit = 300;

  void registerBet() async {
    if (_validate()) {
      var data = {
        "bets-details-id": modelObject!.betDetailsId,
        "match_id": modelObject!.matchId,
        "amount": amount,
      };
      var response = await BetService().placeBet(data);
      if (response.statusCode == 200) {
        print(response.body);

        var creditProviderState = context.read(creditProvider);
        context
            .read(creditProvider.notifier)
            .change(creditProviderState - double.parse(amount!));

        showCustomSimpleNotification(
            "Successfully Placed Bet. Good Luck.", Colors.green);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BetHistory()));
      } else if (response.statusCode == 419) {
        showCustomSimpleNotification(response.body, Colors.red);
        // Navigator.pop(context);
      } else {
        showCustomSimpleNotification(
            "Unknown Error While Placing Bet. Try Again", Colors.red);
        Navigator.pop(context);
        toast(response.body);
      }
    }
  }

  void showPlaceBetModal() {
    if (modelObject == null) {
      return;
    }
    showDialog(
        context: context,
        builder: (context) {
          return PlaceBetWidget(
            data: modelObject!,
          );
        });
  }

  bool _validate() {
    if (amount == null || !isInt(amount!)) {
      showCustomSimpleNotification("Enter a valid amount.", Colors.red);
      return false;
    }
    if (!(int.parse(amount!) > 20 && int.parse(amount!) < 6000)) {
      showCustomSimpleNotification(
          "Amount must be greater than 20 & less than 6000.", Colors.red);
      return false;
    }
    if (!((userCredit - 20) > int.parse(amount!))) {
      showCustomSimpleNotification(
          "Insufficient coins. Deposit to continue.", Colors.red);
      return false;
    }
    // Toast("Validated");
    toast("validated");
    return true;
  }
}
