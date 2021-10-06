import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:op123/app/constants/RunOneGame.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/states/GameState.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardGame extends StatefulWidget {
  const BoardGame({Key? key}) : super(key: key);

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
  var _totalSpinAllowed = 4;
  var _spinsTaken = 0;
  var _wicketDown = false;
  var _score = 0;
  List<GameOption> data = [];

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: getStaticAppBar(context, title: "Board Game"),
      body: Container(
        height: 100.h,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Spins Allowed : $_totalSpinAllowed",
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 8),
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
                                      style: getDefaultTextStyle(size: 16),
                                    ),
                                    Text(
                                      "Option: ${gameOptionTypes[data[index].type].toString()} ",
                                      style: getDefaultTextStyle(size: 16),
                                    ),
                                    Text(
                                      "Point: ${data[index].score.toString()} ",
                                      style: getDefaultTextStyle(size: 16),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Score : $_score",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Target Score : 5",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SpinningWheel(
                      Image.asset('assets/images/wheel-1.png'),
                      width: MediaQuery.of(context).size.width * 0.60,
                      height: MediaQuery.of(context).size.width * 0.60,
                      initialSpinAngle: _generateRandomAngle(),
                      spinResistance: 0.1,
                      dividers: 6,
                      secondaryImage:
                          Image.asset('assets/images/wheel-center-300.png'),
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
                          ? RouletteScore(int.parse(snapshot.data.toString()))
                          : Container();
                    }),
                Spacer(),
                if (_totalSpinAllowed > _spinsTaken && _wicketDown == false)
                  InkWell(
                    onTap: () {
                      if (_spinsTaken < _totalSpinAllowed) {
                        if (!_wicketDown) {
                          setState(() {
                            _spinsTaken++;
                          });
                          _wheelNotifier.sink.add(_generateRandomVelocity());
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      decoration: BoxDecoration(
                          color: _spinsTaken < _totalSpinAllowed
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
                if (_totalSpinAllowed == _spinsTaken || _wicketDown == true)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      decoration: BoxDecoration(
                          color: _spinsTaken < _totalSpinAllowed
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
                        "Play Again.",
                        style: getDefaultTextStyle(size: 19),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onWheelStops(dynamic value) {
    print(RunOneGame().labels[value]);
    var option;
    switch (RunOneGame().labels[value]) {
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
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;
  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;
  final RunOneGame _runOneGame = RunOneGame();

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${gameOptionTypes[_runOneGame.labels[selected]]}',
      style: getDefaultTextStyle(size: 18),
    );
  }
}
