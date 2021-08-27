import 'dart:async';
import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/views/widgets/PlaceBetWidget.dart';

class CoinFlip extends StatefulWidget {
  const CoinFlip({Key? key}) : super(key: key);

  @override
  _CoinFlipState createState() => _CoinFlipState();
}

class _CoinFlipState extends State<CoinFlip> {
  bool _isClicked = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Flip"),
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: InkWell(
            onTap: () {
              showPlaceBetModal(context);
              // setState(() {
              //   _isLoading = true;
              //   _isClicked = !_isClicked;
              // });
              // Timer.periodic(Duration(seconds: 3), (timer) {
              //   setState(() {
              //     _isLoading = false;
              //   });
              // });
            },
            child: Column(
              children: [
                Container(
                  width: 200,
                  // color: Colors.grey,
                  height: 200,
                  child: FlareActor(
                    "assets/images/coin_flip_blob.flr",
                    animation: '3D Coin Flip',
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: AnimatedSwitcher(
                    duration: Duration(microseconds: 800),
                    child: _isClicked
                        ? Image.asset("assets/images/head.png")
                        : Image.asset("assets/images/tail.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
