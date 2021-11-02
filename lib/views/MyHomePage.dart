import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:op123/app/Enums/Games.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/controllers/GameController.dart';
import 'package:op123/app/helpers/SliverPersistantHeaderDelegateImplementation.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/models/User.dart';
import 'package:op123/app/states/CreditState.dart';
import 'package:op123/app/states/SettingState.dart';
import 'package:op123/app/states/StateManager.dart';
import 'package:op123/views/games/BoardGame.dart';
import 'package:op123/views/games/StartGame.dart';
import 'package:op123/views/widgets/CustomAppDrawer.dart';
import 'package:op123/views/widgets/MatchesLoadingScreen.dart';
import 'package:op123/views/widgets/PlaceBetWidget.dart';
import 'package:op123/views/widgets/Sports.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'games/FlipCoin.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    _initialSetup();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
        // print("tabs are clicked ${_tabController.index}");
      });
    });
  }

  void _initialSetup() async {
    var storage = FlutterSecureStorage();
    var token = await storage.read(key: tokenKey);
    var user = await storage.read(key: userKey);
    context.read(settingResponseProvider);
    if (token != null) {
      context.read(authTokenProvider.notifier).change(token);
      context.read(creditProvider.notifier).fetchCredit();
    }
    if (user != null) {
      context
          .read(authUserProvider.notifier)
          .change(User.fromMap(jsonDecode(user)));
    }
  }

  Widget _getSportCategories(int i) {
    var asset = '';
    var title = '';
    var slug = '';
    switch (i) {
      case 0:
        asset = "assets/images/all_sports_2.png";
        title = "All Sports";
        slug = "all";
        break;
      case 1:
        asset = "assets/images/football.png";
        title = "Football";
        slug = "football";
        break;
      case 2:
        asset = "assets/images/cricket.png";
        title = "Cricket";
        slug = "cricket";
        break;
      case 3:
        asset = "assets/images/basketball.png";
        title = "Basketball";
        slug = "basketball";
        break;
      case 4:
        asset = "assets/images/volleyball.png";
        title = "Volleyball";
        slug = "volleyball";
        break;
      case 5:
        asset = "assets/images/badminton.png";
        title = "Badminton";
        slug = "badminton";
        break;
      default:
        break;
    }
    return InkWell(
      onTap: () {
        print(slug);
      },
      child: Container(
        width: 30,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              asset,
              width: 30,
              height: 30,
            ),
            SizedBox(
              height: 10,
            ),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 15))
          ],
        ),
      ),
    );
  }

  Widget _getSingleMatch(Match match) {
    return SportView(match: match);
  }

  Widget _getGames() {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        InkWell(
          onTap: () {
            _showStartGameDialog("Coin Flip", Games.COIN_FLIP);
            // GameController(
            //         type: widget.gameType,
            //         rate: widget.gameType == Games.COIN_FLIP
            //             ? selectedRate
            //             : selectedRateObj!.value,
            //         rateObj: selectedRateObj,
            //         settings: settingProvider,
            //         inputAmount: _amountController.text)
            //     .initiateGame();
          },
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              // padding: EdgeInsets.only(top: 10, left: 15),
              child: Image.asset("assets/images/head.png"),
            ),
          ),
        ),
        InkWell(
          onTap: () => _showStartGameDialog("Run 2", Games.RUN_2),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              // padding: EdgeInsets.only(top: 10, left: 15),
              child: Image.asset("assets/images/opg2-01.png"),
            ),
          ),
        ),
        InkWell(
          onTap: () => _showStartGameDialog("Run 3", Games.RUN_3),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              // padding: EdgeInsets.only(top: 10, left: 15),
              child: Image.asset("assets/images/opg3-01.png"),
            ),
          ),
        ),
        InkWell(
          onTap: () => _showStartGameDialog("Run 4", Games.RUN_4),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              // padding: EdgeInsets.only(top: 10, left: 15),
              child: Image.asset("assets/images/opg4-01.png"),
            ),
          ),
        ),
        InkWell(
          onTap: () => _showStartGameDialog("Run 6", Games.RUN_6),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              // padding: EdgeInsets.only(top: 10, left: 15),
              child: Image.asset("assets/images/opg6-01.png"),
            ),
          ),
        ),
      ],
    );

    // return SingleChildScrollView(
    //   physics: BouncingScrollPhysics(),
    //   child: Container(
    //     // color: Colors.black,
    //     child: Column(
    //       children: [
    //         InkWell(
    //           onTap: () =>
    //               _showStartGameDialog("Coin Flip", 1.8, Games.COIN_FLIP),
    //           child: Container(
    //             height: 40,
    //             margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    //             width: MediaQuery.of(context).size.width - 16,
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).accentColor,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: 10, left: 15),
    //               child: Text(
    //                 "Coin Flip",
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w700),
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ),
    //         ),
    //         InkWell(
    //           onTap: () => _showStartGameDialog("Run 2", 1.3, Games.RUN_2),
    //           child: Container(
    //             height: 40,
    //             margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    //             width: MediaQuery.of(context).size.width - 16,
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).accentColor,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: 10, left: 15),
    //               child: Text(
    //                 "Run Game ( 2 Run )",
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w700),
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ),
    //         ),
    //         InkWell(
    //           onTap: () => _showStartGameDialog("Run 3", 1.3, Games.RUN_3),
    //           child: Container(
    //             height: 40,
    //             margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    //             width: MediaQuery.of(context).size.width - 16,
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).accentColor,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: 10, left: 15),
    //               child: Text(
    //                 "Run Game ( 3 Run )",
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w700),
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ),
    //         ),
    //         InkWell(
    //           onTap: () => _showStartGameDialog("Run 4", 1.9, Games.RUN_4),
    //           child: Container(
    //             height: 40,
    //             margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    //             width: MediaQuery.of(context).size.width - 16,
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).accentColor,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: 10, left: 15),
    //               child: Text(
    //                 "Run Game ( 4 Run )",
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w700),
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ),
    //         ),
    //         InkWell(
    //           onTap: () => _showStartGameDialog("Run 6", 2.5, Games.RUN_6),
    //           child: Container(
    //             height: 40,
    //             margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    //             width: MediaQuery.of(context).size.width - 16,
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).accentColor,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: 10, left: 15),
    //               child: Text(
    //                 "Run Game ( 6 Run )",
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w700),
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _tabOne() {
    return Consumer(builder: (context, watch, child) {
      var matchesState = watch(matchesProvider);

      return RefreshIndicator(
        backgroundColor: Theme.of(context).accentColor,
        onRefresh: () {
          return context.refresh(matchesProvider);
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(0.0),
          physics: AlwaysScrollableScrollPhysics(),
          child: matchesState.when(
              data: (data) {
                return Container(
                  // height: 400,
                  color: Colors.black,
                  child: Column(
                    children: [
                      for (var i = 0; i < data.length; i++)
                        _getSingleMatch(data[i]),
                    ],
                  ),
                );
              },
              loading: () => MatchesLoadingScreen(),
              error: (error, trace) {
                // showCustomSimpleNotification(
                //     "Something Went Wrong. ${error.toString()}", Colors.red);
                return Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Error!",
                        style: getDefaultTextStyle(size: 15),
                      ),
                      Text(
                        "Some thing went wrong. Try Again later.",
                        style: getDefaultTextStyle(size: 13),
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    });
  }

  void _showStartGameDialog(String name, Games type) {
    var rate = 0.0;
    context.read(settingResponseProvider.notifier).fetch();

    showDialog(
        context: context,
        builder: (context) {
          return StartGameDialog(name: name, gameType: type);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).backgroundColor,
                title: Container(
                  height: 40,
                  width: 150,
                  child: SvgPicture.asset("assets/images/logo-light.svg"),
                ),
                actions: [
                  Row(
                    children: [
                      Icon(Icons.monetization_on_outlined,
                          color: Theme.of(context).accentColor),
                      Text(
                        "${context.read(creditProvider).toString()} $currencylogoText",
                        style: getDefaultTextStyle(size: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 1,
                      children: [
                        for (var i = 0; i < 6; i++) _getSportCategories(i),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MarqueeTextSliverHeaderDelegate(),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverPersistantHeaderDelegateImplementation(
                      height: 40,
                      child: TabBar(
                        // indicatorColor: Colors.transparent,
                        indicatorWeight: 3.0,
                        controller: _tabController,
                        tabs: [
                          Tab(
                            icon: _setTabBarTile(
                                "Live", _tabController.index == 0),
                          ),
                          // Tab(
                          //   icon: _setTabBarTile("Upcoming", _selectedTab == 1),
                          // ),
                          Tab(
                            icon: _setTabBarTile("Games", _selectedTab == 1),
                          ),
                        ],
                      )))
            ];
          },
          body: Container(
            // height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _tabOne(),
                _getGames(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _setTabBarTile(String label, bool isActive) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.30,
        height: 30,
        decoration: BoxDecoration(
            // color: isActive ? Theme.of(context).accentColor : Colors.grey,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class MarqueeTextSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Consumer(builder: (context, watch, child) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: Marquee(
          text: watch(settingResponseProvider)?.siteSetting?.notice ??
              "Loading...",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
    });
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
