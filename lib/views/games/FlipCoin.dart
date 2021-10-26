import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
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
  String resultText = "Loading...";

  
  @override
  void initState() {
    super.initState();
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));

    Timer(Duration(seconds: 7), () {
      setState(() {
        _isLoading = false;
        if (widget.win) {
          _controllerBottomCenter.play();
        }
        resultText = widget.win ? "Yahooo! You Win." : "ohh! You Lose.";
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
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
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
                  AnimatedDefaultTextStyle(
                    child: Text(resultText),
                    style: TextStyle(
                        color: _isLoading
                            ? Colors.grey
                            : (widget.win ? Colors.green : Colors.red),
                        fontSize: _isLoading ? 13.sp : 30.sp),
                    duration: Duration(seconds: 2),
                    curve: Curves.bounceOut,
                  ),
                  Spacer(),
                  if (!_isLoading)
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.w),
                      color: Theme.of(context).backgroundColor,
                      child: TextButton(
                        child: Text(
                          "Play Again",
                          style: getDefaultTextStyle(size: 14.sp),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  SizedBox(
                    height: 20.h,
                  )
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
