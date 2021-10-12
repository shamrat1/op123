import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:op123/app/Enums/Games.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/CoinGame.dart';
import 'package:op123/views/authentication/Signin.dart';
import 'package:op123/views/games/BoardGame.dart';
import 'package:op123/views/games/FlipCoin.dart';
import 'package:overlay_support/overlay_support.dart';

class GameController {
  final Games type;
  final double rate;
  final String inputAmount;

  GameController(
      {required this.type, required this.rate, required this.inputAmount});

  void initiateGame() {
    if (_validate()) {
      if (type == Games.COIN_FLIP) {
        print("Here");
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
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (2 Run)",
                  targetScore: 5,
                  totalSpinsAllowed: 4,
                  type: type,
                )));
      } else if (type == Games.RUN_3) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (3 Run)",
                  targetScore: 7,
                  totalSpinsAllowed: 4,
                  type: type,
                )));
      } else if (type == Games.RUN_4) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (4 Run)",
                  targetScore: 15,
                  totalSpinsAllowed: 4,
                  type: type,
                )));
      } else if (type == Games.RUN_6) {
        OneContext().push(MaterialPageRoute(
            builder: (context) => BoardGame(
                  title: "Board Game (6 Run)",
                  targetScore: 20,
                  totalSpinsAllowed: 4,
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
