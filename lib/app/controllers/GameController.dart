import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:op123/app/Enums/Games.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/CoinGame.dart';
import 'package:op123/views/authentication/Signin.dart';
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
      print("Here");
      OneContext().pop();
      OneContext().push(
        MaterialPageRoute(
          builder: (context) => CoinFlip(win: true),
        ),
      );
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
