import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';

class BoardGame extends StatefulWidget {
  const BoardGame({Key? key}) : super(key: key);

  @override
  _BoardGameState createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {
  final StreamController _dividerController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinningWheel(
                  Image.asset('assets/images/roulette-8-300.png'),
                  width: 310,
                  height: 310,
                  initialSpinAngle: _generateRandomAngle(),
                  spinResistance: 0.2,
                  dividers: 6,
                  secondaryImage:
                      Image.asset('assets/images/wheel-center-300.png'),
                  secondaryImageHeight: 110,
                  secondaryImageWidth: 110,
                  canInteractWhileSpinning: false,
                  onUpdate: _dividerController.add,
                  onEnd: _dividerController.add,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}
