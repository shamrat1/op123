import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:op123/app/Enums/Games.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/CoinGame.dart';
import 'package:op123/app/models/SettingResponse.dart';
import 'package:op123/app/services/GameService.dart';
import 'package:op123/app/services/RemoteService.dart';
import 'package:op123/views/authentication/Signin.dart';
import 'package:op123/views/games/BoardGame.dart';
import 'package:op123/views/games/FlipCoin.dart';
import 'package:op123/views/games/StartGame.dart';
import 'package:overlay_support/overlay_support.dart';

class GameController {
  final Games type;
  final double rate;
  final String inputAmount;
  final GameRates? rateObj;
  final List<Setting> settings;

  GameController({
    required this.type,
    required this.rate,
    required this.inputAmount,
    this.rateObj,
    required this.settings,
  });

  Future<bool> initiateGame() async {
    if (_validate()) {
      var gameHistory = await GameService().initialGameRegister({
        "amount": inputAmount.toString(),
        "rate": type == Games.COIN_FLIP ? null : rateObj?.key.toString(),
        "value": rate.toString(),
        "game_type": type.toString()
      });

      if (type == Games.COIN_FLIP) {
        Random r = new Random();
        double falseProbability = .7;
        bool booleanResult = r.nextDouble() > falseProbability;
        OneContext().pop();
        OneContext().push(
          MaterialPageRoute(
            builder: (context) => CoinFlip(win: booleanResult),
          ),
        );
      } else if (type == Games.RUN_2) {
        // OneContext().pop();
        // return true;
        OneContext().pushReplacement(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (2 Run)",
                  totalSpinsAllowed: 1,
                  type: type,
                  paymentCleared: true,
                )));
      } else if (type == Games.RUN_3) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (3 Run)",
                  totalSpinsAllowed: 1,
                  type: type,
                  paymentCleared: true,
                )));
      } else if (type == Games.RUN_4) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (4 Run)",
                  totalSpinsAllowed: 1,
                  type: type,
                  paymentCleared: true,
                )));
      } else if (type == Games.RUN_6) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (6 Run)",
                  totalSpinsAllowed: 1,
                  paymentCleared: true,
                  type: type,
                )));
      }
    }
    return false;
  }

  bool _validate() {
    double minAmount = 50.00;
    double maxAmount = 200.00;
    var amount = 0.0;
    try {
      amount = double.parse(inputAmount);
    } catch (e) {
      showCustomSimpleNotification(
          "Please Enter a valid Amount.", Colors.amber);
      return false;
    }
    if (amount < minAmount || amount > maxAmount) {
      showCustomSimpleNotification(
          "Amount Should be greater than $minAmount & less than $maxAmount. Try Again.",
          Colors.amber);
      return false;
    }
    showCustomSimpleNotification("Amount Accepted. Starting...", Colors.green);
    return true;
  }
}
