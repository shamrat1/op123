import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:OnPlay365/app/Enums/Games.dart';
import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/controllers/GameController.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:OnPlay365/app/models/SettingResponse.dart';
import 'package:OnPlay365/app/states/SettingState.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

class StartGameDialog extends StatefulWidget {
  final String name;
  final Games gameType;
  final GameRates? selectedRate;
  final String? selectedCoinSide;

  const StartGameDialog(
      {Key? key, required this.name, required this.gameType, this.selectedRate, this.selectedCoinSide})
      : super(key: key);

  @override
  _StartGameDialogState createState() => _StartGameDialogState();
}

class GameRates {
  final String key;
  final double value;
  GameRates(this.key, this.value);
}

class _StartGameDialogState extends State<StartGameDialog> {
  TextEditingController _amountController = TextEditingController();
  double possibleReturn = 0.0;
  String coinSide = "";
  var selectedRate = 0.0;
  GameRates? selectedRateObj;

  String _getGameKey() {
    switch (widget.gameType) {
      case Games.COIN_FLIP:
        return "game-coin-flip-rate";

      case Games.RUN_2:
        return "game-run-2-rate";

      case Games.RUN_3:
        return "game-run-3-rate";

      case Games.RUN_4:
        return "game-run-4-rate";

      case Games.RUN_6:
        return "game-run-6-rate";
      case Games.RUN_6_OVER:
        return "game-run-6-rate";
      case Games.GAME_T10:
        return "game-run-an-t10-rate";
      case Games.GAME_T20:
        return "game-run-an-t20-rate";
      default:
        Navigator.of(context).pop();
        toast("Something Went wrong");
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Consumer(builder: (context, watch, child) {
        var settingProvider = watch(settingResponseProvider)?.settings;
        var setting = settingProvider
            ?.firstWhere((element){
              print("${element.key} | ${element.value}");
              return  element.key == _getGameKey();
        });
        print("game key : $_getGameKey()");
        var splited = setting?.value.toString().split(",");
        var rates = <GameRates>[];
        // print(splited);
        if (splited != null) {
          if (splited.length > 1) {
            for (var element in splited) {
              if (element.split(":").length == 2) {
                rates.add(GameRates(element.split(":")[0].replaceAll('"', ''),
                    double.parse(element.split(":")[1])));
              }
            }
            // rates = splited;
          } else {
            selectedRate = double.parse(splited[0]);
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.w,
              // height: 50.h,
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
                    style: getDefaultTextStyle(
                        size: 16.sp, weight: FontWeight.w700),
                  ),
                  if (widget.gameType == Games.COIN_FLIP && selectedRate > 0)
                    Text(
                      "Rate $selectedRate",
                      style: getDefaultTextStyle(
                          size: 15.sp, weight: FontWeight.w500),
                    ),
                  // if (widget.gameType != Games.COIN_FLIP)
                  //   Column(
                  //     children: [
                  //       for (var i = 0; i < rates.length; i++)
                  //         InkWell(
                  //           onTap: () {
                  //             setState(() {
                  //               selectedRateObj = rates[i];
                  //             });
                  //             print(rates[i].key);
                  //             print(rates[i].value);
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: 5, horizontal: 8),
                  //             width: MediaQuery.of(context).size.width * 0.60,
                  //             margin: EdgeInsets.symmetric(vertical: 3),
                  //             decoration: BoxDecoration(
                  //                 color: Theme.of(context).backgroundColor,
                  //                 borderRadius: BorderRadius.circular(5)),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                   "Rate: ${rates[i].key} => ${rates[i].value}",
                  //                   style: getDefaultTextStyle(
                  //                       size: 15.sp, weight: FontWeight.w500),
                  //                 ),
                  //                 if (rates[i].value == selectedRateObj?.value)
                  //                   SizedBox(
                  //                     width: 5,
                  //                   ),
                  //                 if (rates[i].value == selectedRateObj?.value)
                  //                   Icon(
                  //                     Icons.check_circle,
                  //                     color: Theme.of(context).accentColor,
                  //                   )
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //     ],
                  //   ),
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
                          var rateValue = selectedRateObj != null
                              ? selectedRateObj?.value
                              : widget.selectedRate?.value;
                          setState(() {
                            if (widget.gameType == Games.COIN_FLIP) {
                              possibleReturn = int.parse(value) * selectedRate;
                            } else {
                              possibleReturn = int.parse(value) * rateValue!;
                            }
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
                  // if (widget.gameType == Games.COIN_FLIP)
                  //   Container(
                  //     padding: EdgeInsets.all(10),
                  //     // height: 10.h,
                  //     // color: Colors.white,
                  //     child: Column(
                  //       children: [
                  //         Text(
                  //           "Choose Coin Side",
                  //           style: getDefaultTextStyle(size: 18.sp),
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             TextButton(
                  //                 onPressed: () => _setCoinSide("head"),
                  //                 child: Container(
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: coinSide == "head"
                  //                         ? Theme.of(context).backgroundColor
                  //                         : Colors.grey,
                  //                   ),
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: 16, vertical: 5),
                  //                   child: Text(
                  //                     "Head",
                  //                     style: getDefaultTextStyle(size: 13.sp),
                  //                   ),
                  //                 )),
                  //             TextButton(
                  //                 onPressed: () => _setCoinSide("tail"),
                  //                 child: Container(
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: coinSide == "tail"
                  //                         ? Theme.of(context).backgroundColor
                  //                         : Colors.grey,
                  //                   ),
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: 16, vertical: 5),
                  //                   child: Text(
                  //                     "Tail",
                  //                     style: getDefaultTextStyle(size: 13.sp),
                  //                   ),
                  //                 )),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.gameType != Games.COIN_FLIP) {
                        if (selectedRateObj == null &&
                            widget.selectedRate == null) {
                          return showCustomSimpleNotification(
                              "Select a Rate first.", Colors.red);
                        }
                      }
                      if (settingProvider != null)
                        GameController(
                                type: widget.gameType,
                                rate: widget.gameType == Games.COIN_FLIP
                                    ? selectedRate
                                    : (selectedRateObj != null
                                        ? selectedRateObj!.value
                                        : widget.selectedRate!.value),
                                rateObj: selectedRateObj != null
                                    ? selectedRateObj
                                    : widget.selectedRate,
                                settings: settingProvider,
                                inputAmount: _amountController.text)
                            .initiateGame();
                    },
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
          ],
        );
      }),
    );
  }

  void _setCoinSide(String side) {
    setState(() {
      coinSide = side;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }
}
