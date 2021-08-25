import 'package:flutter/material.dart';

class CoinFlip extends StatefulWidget {
  const CoinFlip({Key? key}) : super(key: key);

  @override
  _CoinFlipState createState() => _CoinFlipState();
}

class _CoinFlipState extends State<CoinFlip> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Flip"),
      ),
      body: Container(
        child: Center(
          child: InkWell(
            onTap: () {
              setState(() {
                _isClicked = !_isClicked;
              });
            },
            child: Container(
              width: 200,
              height: 200,
              child: AnimatedSwitcher(
                duration: Duration(seconds: 10),
                child: _isClicked
                    ? Image.asset("assets/images/head.png")
                    : Image.asset("assets/images/tail.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
