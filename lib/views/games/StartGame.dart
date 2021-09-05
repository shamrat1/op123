import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:op123/app/Enums/Games.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/controllers/GameController.dart';
import 'package:op123/app/models/Match.dart';
import 'package:sizer/sizer.dart';

class StartGameDialog extends StatefulWidget {
  final String name;
  final double rate;
  final Games gameType;
  const StartGameDialog(
      {Key? key,
      required this.name,
      required this.rate,
      required this.gameType})
      : super(key: key);

  @override
  _StartGameDialogState createState() => _StartGameDialogState();
}

class _StartGameDialogState extends State<StartGameDialog> {
  TextEditingController _amountController = TextEditingController();
  double possibleReturn = 0.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 90.w,
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).accentColor),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OnPlay365 Games",
                    style: getDefaultTextStyle(
                        size: 18.sp, weight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              Text(
                widget.name,
                style:
                    getDefaultTextStyle(size: 16.sp, weight: FontWeight.w700),
              ),
              Text(
                "Rate ${widget.rate}",
                style:
                    getDefaultTextStyle(size: 15.sp, weight: FontWeight.w500),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: '100',
                      border: OutlineInputBorder()),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (int.tryParse(value) is int) {
                      setState(() {
                        possibleReturn = int.parse(value) * widget.rate;
                      });
                    } else {
                      setState(() {
                        possibleReturn = 0.0;
                      });
                    }
                  },
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Possible Return",
                    style: getDefaultTextStyle(
                        size: 14.sp, weight: FontWeight.w500),
                  ),
                  Text(
                    "$possibleReturn $currencylogoText",
                    style: getDefaultTextStyle(
                        size: 14.sp, weight: FontWeight.w500),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () => GameController(
                        type: widget.gameType,
                        rate: widget.rate,
                        inputAmount: _amountController.text)
                    .initiateGame(),
                child: Container(
                  height: 50,
                  // width: 200,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).backgroundColor),
                  child: Center(
                    child: Text(
                      "Start Game",
                      style: getDefaultTextStyle(
                          size: 15.sp, weight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amountController.dispose();
  }
}
