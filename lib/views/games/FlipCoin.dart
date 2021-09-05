import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CoinFlip extends StatefulWidget {
  const CoinFlip({Key? key, required this.win}) : super(key: key);
  final bool win;

  @override
  _CoinFlipState createState() => _CoinFlipState();
}

class _CoinFlipState extends State<CoinFlip> {
  bool _isLoading = true;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    Timer(Duration(seconds: 7), () {
      setState(() {
        _isLoading = false;
        _controllerBottomCenter.play();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerBottomCenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Flip"),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  Container(
                    width: 200,
                    height: 200,
                    child: AnimatedSwitcher(
                      duration: Duration(microseconds: 800),
                      child: _isLoading
                          ? Container(
                              width: 200,
                              // color: Colors.grey,
                              height: 200,
                              child: FlareActor(
                                "assets/images/coin_flip_blob.flr",
                                animation: '3D Coin Flip',
                              ),
                            )
                          : (widget.win
                              ? Image.asset("assets/images/head.png")
                              : Image.asset("assets/images/tail.png")),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 20,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
