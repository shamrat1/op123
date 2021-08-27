import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';

void showPlaceBetModal(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.60,
            child: PlaceBetWidget());
      });
}

class PlaceBetWidget extends StatefulWidget {
  const PlaceBetWidget({Key? key}) : super(key: key);

  @override
  _PlaceBetWidgetState createState() => _PlaceBetWidgetState();
}

class _PlaceBetWidgetState extends State<PlaceBetWidget> {
  TextEditingController _amountController = TextEditingController();

  double possibleReturn = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Theme.of(context).accentColor),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Place a Bet",
                style: getDefaultTextStyle(size: 22, weight: FontWeight.bold),
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
            "India V England",
            style: getDefaultTextStyle(size: 20, weight: FontWeight.w700),
          ),
          Text(
            "1st Innings total runs",
            style: getDefaultTextStyle(size: 17, weight: FontWeight.w500),
          ),
          Text(
            "250 Runs 1.5",
            style: getDefaultTextStyle(size: 17),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    possibleReturn = int.parse(value) * 1.5;
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
                style: getDefaultTextStyle(size: 17, weight: FontWeight.w500),
              ),
              Text(
                "$possibleReturn $currencylogoText",
                style: getDefaultTextStyle(size: 17, weight: FontWeight.w500),
              ),
            ],
          ),
          InkWell(
            onTap: () => print("Tapped"),
            child: Container(
              height: 50,
              width: 200,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).backgroundColor),
              child: Center(
                child: Text(
                  "Place Bet",
                  style: getDefaultTextStyle(size: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
