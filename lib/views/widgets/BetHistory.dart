import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/models/BetHistoryResponse.dart';
import 'package:op123/app/services/RemoteService.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'CustomAppDrawer.dart';

class BetHistory extends StatefulWidget {
  const BetHistory({Key? key}) : super(key: key);

  @override
  _BetHistoryState createState() => _BetHistoryState();
}

class _BetHistoryState extends State<BetHistory> {
  bool _isLoading = false;
  int currentPage = 1;
  List<Bet> bets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getHistory();
  }

  _getHistory() async {
    setState(() {
      _isLoading = true;
    });
    var response = await RemoteService().getBetHistory();
    if (response.statusCode == 200) {
      // var betHistoryResponse = betHistoryResponseFromMap(response.body);
      var betHistoryResponse =
          BetHistoryResponse.fromMap(jsonDecode(response.body));
      print(betHistoryResponse.toMap());
      toast(betHistoryResponse.toMap().toString());
      if (betHistoryResponse.placedBets?.bets != null) {
        setState(() {
          bets = betHistoryResponse.placedBets!.bets!;
        });
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      toast(
          "${response.statusCode} Unknown error while fetching. \n ${response.body}",
          duration: Duration(seconds: 5));
    }
  }

  Widget _setSingleTile(Bet bet) {
    print(bets.length);
    return ListTile(
      title: Text("Bet Name : ${bet.betName} & Value: ${bet.betValue}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      appBar: getStaticAppBar(context, title: "Bet History"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.replay_outlined),
        onPressed: () => _getHistory(),
      ),
      body: Stack(
        children: [
          Container(
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
                    for (var i = 0; i < bets.length; i++)
                      _setSingleTile(bets[i]),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              width: 100.w,
              height: 100.h,
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}
