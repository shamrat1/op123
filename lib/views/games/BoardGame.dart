import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:op123/app/Enums/Games.dart';
import 'package:op123/app/constants/RunOneGame.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/controllers/GameController.dart';
import 'package:op123/app/models/GameHistoryResponse.dart';
import 'package:op123/app/states/CreditState.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:op123/views/games/StartGame.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardGame extends StatefulWidget {
  final int totalSpinsAllowed;
  final String title;
  final int? targetScoreLow;
  final int? targetScoreHigh;
  final Games type;
  final bool paymentCleared;
  final GameHistory? history;

  const BoardGame({
    Key? key,
    required this.totalSpinsAllowed,
    required this.title,
    this.targetScoreLow,
    this.targetScoreHigh,
    this.paymentCleared = false,
    required this.type,
    this.history,
  }) : super(key: key);

  @override
  _BoardGameState createState() => _BoardGameState();
}

class GameOption {
  final int turn;
  final int score;
  final GameOptionType type;

  GameOption({required this.turn, required this.score, required this.type});
}

class _BoardGameState extends State<BoardGame> {
  final StreamController _dividerController = StreamController<int>();
  final _wheelNotifier = StreamController<double>();
  var _spinsTaken = 0;
  var _wicketDown = false;
  var _score = 0;
  var _loading = false;
  GameHistory? result;
  List<GameOption> data = [];
  dynamic gameObjProvider;

  var _wheelImageURL = "";
  var _dividers = 0;
  @override
  void initState() {
    super.initState();
    _setGameRequiredVars();
  }

  void _setGameRequiredVars() {
    switch (widget.type) {
      case Games.RUN_2:
        _wheelImageURL = 'assets/images/wheel-2.png';
        _dividers = 6;
        gameObjProvider = RunOneGame();
        return;
      case Games.RUN_3:
        _wheelImageURL = 'assets/images/wheel-3.png';
        gameObjProvider = RunThreeGame();
        _dividers = 7;
        return;
      case Games.RUN_4:
        _wheelImageURL = 'assets/images/wheel-4.png';
        gameObjProvider = RunFourGame();

        _dividers = 8;
        return;
      case Games.RUN_6:
        _wheelImageURL = 'assets/images/wheel-6.png';
        _dividers = 9;
        gameObjProvider = RunSixGame();

        return;
      case Games.COIN_FLIP:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void dispose() {
    _dividerController.close();
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _score = 0;
    data.forEach((element) {
      _score += element.score;
    });
    return Stack(
      children: [
        Scaffold(
          appBar: getStaticAppBar(context, title: widget.title),
          body: SingleChildScrollView(
            child: Container(
              height: 100.h - 70,
              width: 100.w,
              color: Colors.black,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        // color: Colors.white,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Spins Allowed : ${widget.totalSpinsAllowed}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Spins Used : $_spinsTaken",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            if (widget.history != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Option : ${widget.history?.rate}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Value : ${widget.history?.value}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Amount : ${widget.history?.amount} $currencylogoText",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    height: 40,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "#${data[index].turn} ",
                                            style:
                                                getDefaultTextStyle(size: 16),
                                          ),
                                          Text(
                                            "Option: ${gameOptionTypes[data[index].type].toString()} ",
                                            style:
                                                getDefaultTextStyle(size: 16),
                                          ),
                                          Text(
                                            "Point: ${data[index].score.toString()} ",
                                            style:
                                                getDefaultTextStyle(size: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Total Score : $_score",
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w600),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //     Text(
                      //       "Target Score : ${widget.targetScoreLow} - ${widget.targetScoreHigh}",
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w600),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SpinningWheel(
                            Image.asset(_wheelImageURL),
                            width: MediaQuery.of(context).size.width * 0.60,
                            height: MediaQuery.of(context).size.width * 0.60,
                            initialSpinAngle: _generateRandomAngle(),
                            spinResistance: 0.1,
                            dividers: _dividers,
                            secondaryImage: Image.asset(
                                'assets/images/wheel-center-300.png'),
                            secondaryImageHeight: 90,
                            secondaryImageWidth: 90,
                            canInteractWhileSpinning: false,
                            onUpdate: _dividerController.add,
                            onEnd: _onWheelStops,
                            shouldStartOrStop: _wheelNotifier.stream,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            height: MediaQuery.of(context).size.width * 0.60,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      StreamBuilder(
                          stream: _dividerController.stream,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? RouletteScore(
                                    int.parse(snapshot.data.toString()),
                                    widget.type)
                                : Container();
                          }),
                      Spacer(),
                      if (widget.paymentCleared == false)
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StartGameDialog(
                                      name: widget.title,
                                      gameType: widget.type);
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            margin: EdgeInsets.only(bottom: 20, top: 10),
                            decoration: BoxDecoration(
                                color: _spinsTaken < widget.totalSpinsAllowed
                                    ? Theme.of(context).accentColor
                                    : Colors.grey,
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
                      if (widget.paymentCleared == true &&
                          widget.totalSpinsAllowed > _spinsTaken)
                        InkWell(
                          onTap: () {
                            // if(_spinsTaken == widget.totalSpinsAllowed){

                            // }
                            if (_spinsTaken < widget.totalSpinsAllowed) {
                              if (!_wicketDown) {
                                setState(() {
                                  _spinsTaken++;
                                });
                                _wheelNotifier.sink
                                    .add(_generateRandomVelocity());
                              } else {
                                showSimpleNotification(
                                    Text(
                                        "Your Wicket is down. Better Luck next time."),
                                    background: Colors.red);
                              }
                            } else {
                              showSimpleNotification(
                                  Text(
                                      "Total Spins Are used. Start a new game to play."),
                                  background: Colors.red);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            margin: EdgeInsets.only(bottom: 20, top: 10),
                            decoration: BoxDecoration(
                                color: _spinsTaken < widget.totalSpinsAllowed
                                    ? Theme.of(context).accentColor
                                    : Colors.grey,
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
                              "SPIN",
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
        ),
        if (result != null)
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
                        "${result?.status! ?? "NOne"}",
                        style: getDefaultTextStyle(
                            size: 28, weight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          result?.status! == "win"
                              ? "Yahooo! You've won. An amount of ${(double.parse(result!.amount!) * double.parse(result!.value!)).toStringAsFixed(1)} has been deposited to your account."
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
                              color: _spinsTaken < widget.totalSpinsAllowed
                                  ? Theme.of(context).accentColor
                                  : Colors.grey,
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
          )
      ],
    );
  }

  void _onWheelStops(dynamic value) async {
    print("-----------------+++++++++++++++++++++-------------------");
    print(gameObjProvider.runtimeType);
    print(gameObjProvider.labels[value]);
    print(gameOptionTypes[gameObjProvider.labels[value]]);
    print("-----------------+++++++++++++++++++++-------------------");

    var option;
    switch (gameObjProvider.labels[value]) {
      case GameOptionType.dot_ball:
        option = GameOption(
            turn: _spinsTaken, score: 0, type: GameOptionType.dot_ball);
        break;
      case GameOptionType.run_1:
        option =
            GameOption(turn: _spinsTaken, score: 1, type: GameOptionType.run_1);
        break;
      case GameOptionType.no_ball:
        option = GameOption(
            turn: _spinsTaken, score: 1, type: GameOptionType.no_ball);
        break;
      case GameOptionType.run_2:
        option =
            GameOption(turn: _spinsTaken, score: 2, type: GameOptionType.run_2);
        break;
      case GameOptionType.wide_ball:
        option = GameOption(
            turn: _spinsTaken, score: 1, type: GameOptionType.wide_ball);
        break;
      case GameOptionType.wicket:
        option = GameOption(
            turn: _spinsTaken, score: 0, type: GameOptionType.wicket);
        HapticFeedback.heavyImpact();
        setState(() {
          _wicketDown = true;
        });
        break;
      default:
        option = GameOption(
            turn: _spinsTaken, score: 0, type: GameOptionType.dot_ball);
    }
    setState(() {
      data.add(option);
    });

    _dividerController.add(value);

    if (_spinsTaken == widget.totalSpinsAllowed) {
      setState(() {
        _loading = true;
      });
      print(
          "${widget.history?.rate == gameObjProvider.labels[value]} | ${widget.history?.rate} | ${gameOptionTypes[gameObjProvider.labels[value]]}");
      // var placedIn = widget.
      var history = widget.history;
      if (history != null) {
        if (widget.history?.rate ==
            gameOptionTypes[gameObjProvider.labels[value]]) {
          // show confetti
        }
        var gameResponse = await GameController(
          type: widget.type,
          rate: 0.0,
          inputAmount: history.amount!,
          settings: [],
        ).publishResult(
            history,
            widget.history?.rate ==
                gameOptionTypes[gameObjProvider.labels[value]]);
        print(gameResponse.gameHistory!.toMap());
        if (gameResponse.credits != null) {
          context
              .read(creditProvider.notifier)
              .change(double.parse(gameResponse.credits!));
        }
        setState(() {
          result = gameResponse.gameHistory;
          print(result?.amount);
          print(result?.value);
          _loading = false;
        });
      }
    }
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;
  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;
  dynamic gameObjProvider;
  final Games _selectedGame;

  RouletteScore(this.selected, this._selectedGame) {
    switch (_selectedGame) {
      case Games.RUN_2:
        gameObjProvider = RunOneGame();
        return;
      case Games.RUN_3:
        gameObjProvider = RunThreeGame();
        return;
      case Games.RUN_4:
        gameObjProvider = RunFourGame();
        return;
      case Games.RUN_6:
        gameObjProvider = RunSixGame();
        return;
      case Games.COIN_FLIP:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${gameOptionTypes[gameObjProvider.labels[selected]]}',
      style: getDefaultTextStyle(size: 18),
    );
  }
}
