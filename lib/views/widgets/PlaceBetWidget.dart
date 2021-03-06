import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/controllers/PlaceBetController.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:sizer/sizer.dart';

class PlaceBetWidget extends StatefulWidget {
  final PlaceBetObjectModel data;
  const PlaceBetWidget({Key? key, required this.data}) : super(key: key);

  @override
  _PlaceBetWidgetState createState() => _PlaceBetWidgetState();
}

class _PlaceBetWidgetState extends State<PlaceBetWidget> {
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
                    "Place a Bet",
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
                widget.data.matchName,
                style:
                    getDefaultTextStyle(size: 16.sp, weight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.data.betOptionName,
                style:
                    getDefaultTextStyle(size: 15.sp, weight: FontWeight.w500),
              ),
              Text(
                "${widget.data.betDetailKey} ${widget.data.betDetailValue}",
                style: getDefaultTextStyle(size: 14.sp),
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
                        possibleReturn = int.parse(value) *
                            double.tryParse(widget.data.betDetailValue)!;
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
                onTap: () => PlacedBetController(
                        event: PlacedBetEvent.Register,
                        context: context,
                        amount: _amountController.text,
                        modelObject: widget.data)
                    .registerBet(),
                child: Container(
                  height: 50,
                  // width: 200,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).backgroundColor),
                  child: Center(
                    child: Text(
                      "Place Bet",
                      style: getDefaultTextStyle(
                          size: 16.sp, weight: FontWeight.bold),
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
    super.dispose();
    _amountController.dispose();
  }
}
