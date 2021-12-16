import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:OnPlay365/app/Enums/Games.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/models/CoinGame.dart';
import 'package:OnPlay365/app/models/GameHistoryResponse.dart';
import 'package:OnPlay365/app/models/SettingResponse.dart';
import 'package:OnPlay365/app/services/GameService.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';
import 'package:OnPlay365/views/authentication/Signin.dart';
import 'package:OnPlay365/views/games/BoardGame.dart';
import 'package:OnPlay365/views/games/FlipCoin.dart';
import 'package:OnPlay365/views/games/StartGame.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      var gameResponse = await GameService().initialGameRegister({
        "amount": inputAmount.toString(),
        "rate": type == Games.COIN_FLIP ? "" : rateObj?.key.toString(),
        "value": rate.toString(),
        "game_type": type.toString()
      });

      if (type == Games.COIN_FLIP) {
        print({
          "amount": inputAmount.toString(),
          "rate": type == Games.COIN_FLIP ? "" : rateObj?.key.toString(),
          "value": rate.toString(),
          "game_type": type.toString()
        });
        Random r = new Random();
        double falseProbability = .7;
        bool booleanResult = r.nextDouble() > falseProbability;
        var gameResult = await GameService().registerGameResult(
            gameResponse.gameHistory!,
            {"result": booleanResult ? "win" : "loss"});
        OneContext().pop();
        OneContext().push(
          MaterialPageRoute(
            builder: (context) => CoinFlip(
              result: booleanResult ? GameResult.WIN : GameResult.LOSE,
              history: gameResult.gameHistory,
            ),
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
                  history: gameResponse.gameHistory,
                  selectedRateObject: rateObj,
                )));
      } else if (type == Games.RUN_3) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (3 Run)",
                  totalSpinsAllowed: 1,
                  type: type,
                  paymentCleared: true,
                  history: gameResponse.gameHistory,
                  selectedRateObject: rateObj,
                )));
      } else if (type == Games.RUN_4) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (4 Run)",
                  totalSpinsAllowed: 1,
                  type: type,
                  paymentCleared: true,
                  history: gameResponse.gameHistory,
                  selectedRateObject: rateObj,
                )));
      } else if (type == Games.RUN_6) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (6 Run)",
                  totalSpinsAllowed: 1,
                  paymentCleared: true,
                  type: type,
                  history: gameResponse.gameHistory,
                  selectedRateObject: rateObj,
                )));
      } else if (type == Games.RUN_6_OVER) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (6 Run)",
                  totalSpinsAllowed: 6,
                  paymentCleared: true,
                  type: type,
                  history: gameResponse.gameHistory,
                  selectedRateObject: rateObj,
                )));
      }
    }
    return false;
  }

  Future<GameHistoryResponse> publishResult(GameHistory history,
      [bool win = false]) async {
    // OneContext().read
    return await GameService()
        .registerGameResult(history, {"result": win ? "win" : "loss"});
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
