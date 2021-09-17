import 'package:flutter/material.dart';
import 'package:op123/app/controllers/PlaceBetController.dart';
import 'package:op123/app/models/BetDetail.dart';
import 'package:op123/app/models/BetsForMatch.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/views/widgets/PlaceBetWidget.dart';

class SportView extends StatefulWidget {
  final Match match;
  const SportView({Key? key, required this.match}) : super(key: key);

  @override
  _SportViewState createState() => _SportViewState();
}

class _SportViewState extends State<SportView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      margin: EdgeInsets.all(8.0),
      // padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.match.name ?? '',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${widget.match.tournament!.name} | ${widget.match.matchTime}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    _getSportIcon(widget.match.sportType ?? ''),
                  ],
                ),
                for (var j = 0; j < widget.match.betsForMatch!.length; j++)
                  if (widget.match.betsForMatch![j].isLive == 1 &&
                      widget.match.betsForMatch![j].isResultPublished != 1)
                    _getBetsForMatches(widget.match.betsForMatch![j])
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getBetsForMatches(BetsForMatch betsForMatch) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 15),
              child: Text(
                betsForMatch.betOption?.name ?? '',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: (betsForMatch.betDetails!.length / 2).ceil() * 20 + 20,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(0),
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              crossAxisCount: 2,
              childAspectRatio: (MediaQuery.of(context).size.width * 0.40 / 20),
              children: [
                for (var k = 0; k < betsForMatch.betDetails!.length; k++)
                  _getBetDetails(betsForMatch.betDetails![k], betsForMatch)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBetDetails(BetDetail betDetail, BetsForMatch betsForMatch) {
    return InkWell(
      onTap: () {
        PlacedBetController(
                context: context,
                event: PlacedBetEvent.Show,
                modelObject: PlaceBetObjectModel(
                    matchName: widget.match.name!,
                    betDetailKey: betDetail.name!,
                    betDetailValue: betDetail.value!,
                    betForMatchId: betsForMatch.id!.toString(),
                    betOptionName: betsForMatch.betOption!.name!,
                    betDetailsId: betDetail.id.toString(),
                    matchId: widget.match.id!.toString()))
            .showPlaceBetModal();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.40,
        height: 20,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            "${betDetail.name} ${betDetail.value} ",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Container _getSportIcon(String sport) {
    var asset = '';
    switch (sport) {
      case 'all':
        asset = "assets/images/all_sports_2.png";
        break;
      case 'football':
        asset = "assets/images/football.png";
        break;
      case 'cricket':
        asset = "assets/images/cricket.png";
        break;
      case 'basketball':
        asset = "assets/images/basketball.png";
        break;
      case 'volleyball':
        asset = "assets/images/volleyball.png";
        break;
      case 'badminton':
        asset = "assets/images/badminton.png";
        break;
      default:
        break;
    }

    return Container(
        width: 60,
        height: 70,
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
        ));
  }
}
