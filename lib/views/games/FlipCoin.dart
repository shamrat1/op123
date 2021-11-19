import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:op123/app/Enums/Games.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/models/GameHistoryResponse.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:op123/views/games/StartGame.dart';
import 'package:sizer/sizer.dart';

enum GameResult {
  NOT_PUBLISHED,
  WIN,
  LOSE,
}

class CoinFlip extends StatefulWidget {
  CoinFlip({Key? key, this.result = GameResult.NOT_PUBLISHED, this.history})
      : super(key: key);

  GameResult result;
  final GameHistory? history;

  @override
  _CoinFlipState createState() => _CoinFlipState();
}

class _CoinFlipState extends State<CoinFlip> {
  bool _isLoading = false;
  late ConfettiController _controllerBottomCenter;
  String resultText = "Start playing to win.";
  bool? win;

  @override
  void initState() {
    super.initState();
    if (widget.result != GameResult.NOT_PUBLISHED) {
      setState(() {
        resultText = "Loading....";
        _isLoading = true;
        win = widget.result == GameResult.WIN ? true : false;
      });
    }
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));

    Timer(Duration(seconds: 7), () {
      setState(() {
        _isLoading = false;
        if (win != null && win! == true) {
          _controllerBottomCenter.play();
        }
        if (win != null) {
          resultText = win! ? "Yahooo! You Win." : "ohh! You Lose.";
        }
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
                          : (win != null && win!
                              ? Image.asset("assets/images/head.png")
                              : Image.asset("assets/images/tail.png")),
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    child: Text(resultText),
                    style: TextStyle(
                        color: _isLoading
                            ? Colors.grey
                            : (win != null && win! ? Colors.green : Colors.red),
                        fontSize: _isLoading ? 13.sp : 30.sp),
                    duration: Duration(seconds: 2),
                    curve: Curves.bounceOut,
                  ),
                  Spacer(),
                  if(widget.result == GameResult.NOT_PUBLISHED)
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StartGameDialog(
                                  name: "Flip Coin",
                                  gameType: Games.COIN_FLIP);
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        margin: EdgeInsets.only(bottom: 20, top: 10),
                        decoration: BoxDecoration(
                            color:Theme.of(context).accentColor,

                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.shade700,
                                blurRadius: 3,
                                offset: Offset(1, 1),
                              ),
                              BoxShadow(
                                color: Colors.amber.shade300,
                                blurRadius: 3,
                                offset: Offset(-1, -1),
                              ),
                            ]),
                        child: Text(
                          "Start Game",
                          style: getDefaultTextStyle(size: 19),
                        ),
                      ),
                    ),
                  if (!_isLoading && widget.result != GameResult.NOT_PUBLISHED)
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
          if (widget.history != null)
            Material(
              child: Container(
                width: 100.w,
                height: 100.h,
                color: Colors.black54.withOpacity(.78),
                child: Center(
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.history?.status! ?? "NOne"}",
                          style: getDefaultTextStyle(
                              size: 28, weight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 60.w,
                          child: Text(
                            widget.history?.status! == "win"
                                ? "Yahooo! You've won. An amount of ${(double.parse(widget.history!.amount!) * double.parse(widget.history!.value!)).toStringAsFixed(1)} has been deposited to your account."
                                : "Oh You Lost. Better Luck Next Time.",
                            style: getDefaultTextStyle(size: 18),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (ctx) => MyHomePage()),
                                    (route) => false);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            margin: EdgeInsets.only(bottom: 20, top: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.shade700,
                                    blurRadius: 3,
                                    offset: Offset(1, 1),
                                  ),
                                  BoxShadow(
                                    color: Colors.amber.shade300,
                                    blurRadius: 3,
                                    offset: Offset(-1, -1),
                                  ),
                                ]),
                            child: Text(
                              "Return To Home",
                              style: getDefaultTextStyle(size: 19),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
