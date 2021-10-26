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

  void initiateGame() async {
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
        var run2Setting = settings
            .firstWhere((element) => element.key == "game-run-2-tries-1");
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (2 Run)",
                  targetScoreLow: int.parse(rateObj!.key.toString().split("-")[0]),
                  targetScoreHigh: int.parse(rateObj!.key.toString().split("-")[1]),
                  totalSpinsAllowed: int.parse(run2Setting.value!),
                  type: type,
                )));
      } else if (type == Games.RUN_3) {
        var run3Setting = settings
            .firstWhere((element) => element.key == "game-run-3-tries-1");
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (3 Run)",
                              targetScoreLow: int.parse(rateObj!.key.toString().split("-")[0]),
                  targetScoreHigh: int.parse(rateObj!.key.toString().split("-")[1]),
                  totalSpinsAllowed: int.parse(run3Setting.value!),
                  type: type,
                )));
      } else if (type == Games.RUN_4) {
        var run4Setting = settings
            .firstWhere((element) => element.key == "game-run-3-tries-1");
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (4 Run)",
                              targetScoreLow: int.parse(rateObj!.key.toString().split("-")[0]),
                  targetScoreHigh: int.parse(rateObj!.key.toString().split("-")[1]),
                  totalSpinsAllowed: int.parse(run4Setting.value!),
                  type: type,
                )));
      } else if (type == Games.RUN_6) {
        var run6Setting = settings
            .firstWhere((element) => element.key == "game-run-3-tries-1");
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (6 Run)",
                              targetScoreLow: int.parse(rateObj!.key.toString().split("-")[0]),
                  targetScoreHigh: int.parse(rateObj!.key.toString().split("-")[1]),
                  totalSpinsAllowed: int.parse(run6Setting.value!),
                  type: type,
                )));
      }
    }
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
