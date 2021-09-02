import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/Match.dart';

void showPlaceBetModal(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container();
        // return Container(
        //     height: MediaQuery.of(context).size.height * 0.80,
        //     child: PlaceBetWidget());
      });
}

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
          width: MediaQuery.of(context).size.width * .90,
          height: MediaQuery.of(context).size.height * .50,
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
                    style:
                        getDefaultTextStyle(size: 22, weight: FontWeight.bold),
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
                style: getDefaultTextStyle(size: 20, weight: FontWeight.w700),
              ),
              Text(
                widget.data.betOptionName,
                style: getDefaultTextStyle(size: 17, weight: FontWeight.w500),
              ),
              Text(
                "${widget.data.betDetailKey} ${widget.data.betDetailValue}",
                style: getDefaultTextStyle(size: 17),
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
                    style:
                        getDefaultTextStyle(size: 17, weight: FontWeight.w500),
                  ),
                  Text(
                    "$possibleReturn $currencylogoText",
                    style:
                        getDefaultTextStyle(size: 17, weight: FontWeight.w500),
                  ),
                ],
              ),
              InkWell(
                onTap: () => print("Tapped"),
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
                          size: 20, weight: FontWeight.bold),
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
}
