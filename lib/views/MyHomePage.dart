import 'dart:convert';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:OnPlay365/app/Enums/Games.dart';
import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/controllers/GameController.dart';
import 'package:OnPlay365/app/helpers/SliverPersistantHeaderDelegateImplementation.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:OnPlay365/app/models/User.dart';
import 'package:OnPlay365/app/states/CreditState.dart';
import 'package:OnPlay365/app/states/SettingState.dart';
import 'package:OnPlay365/app/states/StateManager.dart';
import 'package:OnPlay365/views/games/BoardGame.dart';
import 'package:OnPlay365/views/games/StartGame.dart';
import 'package:OnPlay365/views/widgets/CustomAppDrawer.dart';
import 'package:OnPlay365/views/widgets/MatchesLoadingScreen.dart';
import 'package:OnPlay365/views/widgets/PlaceBetWidget.dart';
import 'package:OnPlay365/views/widgets/Sports.dart';
import 'package:sizer/sizer.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'games/FlipCoin.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _updateAvailable = false;
  String _updateNote = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  late TabController _tabController;
  int _selectedTab = 0;

  
  void _initFirebaseMessingConfigs() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    _initialSetup();
    _initFirebaseMessingConfigs();
    super.initState();
    _initialRemoteConfig();
    _firebaseMessaging.getToken();
    FirebaseMessaging.onMessage.listen((event) async {
      print(event.notification?.title);

      // context.read(messageListProvider.notifier).add(
      //       NotificationMessage(
      //         title: event.notification!.title!,
      //         body: event.notification!.body!,
      //         id: DateTime.now().toString(),
      //       ),
      //     );
      // var string = json.encode(context.read(messageListProvider));
      // await FlutterSecureStorage().write(key: "notifications", value: string);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      print(event.notification?.title);
      // context.read(messageListProvider.notifier).add(
      //   NotificationMessage(
      //     title: event.notification!.title!,
      //     body: event.notification!.body!,
      //     id: DateTime.now().toString(),
      //   ),
      // );
      // var string = json.encode(context.read(messageListProvider));
      // await FlutterSecureStorage().write(key: "notifications", value: string);
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
  }

  void _initialRemoteConfig() async {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    remoteConfig.setConfigSettings(
      RemoteConfigSettings(
          minimumFetchInterval: const Duration(seconds: 10),
          fetchTimeout: const Duration(seconds: 5)),
    );
    await remoteConfig.fetchAndActivate();
    setState(() {
      _updateAvailable = remoteConfig.getBool("new_update");
      _updateNote = remoteConfig.getString("update_note");
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
          onTap: () =>
              _showStartGameDialog("Game For An Over", Games.RUN_6_OVER),
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
                getMatches(String sportType) {
                  return data
                      .where((element) => element.sportType == sportType)
                      .toList();
                }

                return Container(
                  // height: 400,
                  color: Colors.black,
                  child: Column(
                    children: [
                      _getSportHeader("Cricket"),
                      for (var i = 0; i < getMatches("cricket").length; i++)
                        _getSingleMatch(getMatches("cricket")[i]),
                      _getSportHeader("Football"),
                      for (var i = 0; i < getMatches("football").length; i++)
                        _getSingleMatch(getMatches("football")[i]),
                      _getSportHeader("Basketball"),
                      for (var i = 0; i < getMatches("basketball").length; i++)
                        _getSingleMatch(getMatches("basketball")[i]),
                      _getSportHeader("Tennis"),
                      for (var i = 0; i < getMatches("tennis").length; i++)
                        _getSingleMatch(getMatches("tennis")[i]),
                      _getSportHeader("Volleyball"),
                      for (var i = 0; i < getMatches("volleyball").length; i++)
                        _getSingleMatch(getMatches("volleyball")[i]),
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

  Container _getSportHeader(String sport) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          sport,
          style: getDefaultTextStyle(size: 20),
        ),
      ),
    );
  }

  void _showStartGameDialog(String name, Games type) {
    context.read(settingResponseProvider.notifier).fetch();
    // showDialog(
    // context: context,
    // builder: (context) {
    //   return StartGameDialog(name: name, gameType: type);
    // });
    switch (type) {
      case Games.COIN_FLIP:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CoinFlip(),
          ),
        );
        return;
      case Games.RUN_2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BoardGame(
              title: "Board Game (2 Run)",
              totalSpinsAllowed: 1,
              type: type,
            ),
          ),
        );
        return;
      case Games.RUN_6_OVER:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BoardGame(
              title: "Game For An Over",
              totalSpinsAllowed: 6,
              type: type,
            ),
          ),
        );
        return;
      case Games.RUN_3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BoardGame(
              title: "Board Game (3 Run)",
              totalSpinsAllowed: 1,
              type: type,
            ),
          ),
        );
        return;
      case Games.RUN_4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BoardGame(
              title: "Board Game (4 Run)",
              totalSpinsAllowed: 1,
              type: type,
            ),
          ),
        );
        return;
      case Games.RUN_6:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BoardGame(
              title: "Board Game (6 Run)",
              totalSpinsAllowed: 1,
              type: type,
            ),
          ),
        );
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).backgroundColor,
            child: NestedScrollView(
              physics: NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    iconTheme:
                        IconThemeData(color: Theme.of(context).accentColor),
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: Container(
                      height: 40,
                      width: 150,
                      child: SvgPicture.asset("assets/images/logo-light.svg"),
                    ),
                    actions: [
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.25,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Icon(Icons.monetization_on_outlined,
                      //           color: Theme.of(context).accentColor),
                      //       Text(
                      //         "${context.read(creditProvider).toString()} $currencylogoText",
                      //         style: getDefaultTextStyle(size: 12.sp),
                      //         overflow: TextOverflow.clip,
                      //         maxLines: 1,
                      //       ),
                      //       SizedBox(
                      //         width: MediaQuery.of(context).size.width * 0.02,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "You've ${context.read(creditProvider)} coins in the wallet currently.")));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              color: Theme.of(context).accentColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Coins",
                              style: getDefaultTextStyle(size: 12.sp),
                            ),
                          ],
                        ),
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
                                icon:
                                    _setTabBarTile("Games", _selectedTab == 1),
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
          // if (_updateAvailable)
          //   BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          //     child: Container(
          //       width: 100.w,
          //       height: 100.h,
          //       color: Colors.black26,
          //       child: Center(
          //         child: Container(
          //           decoration: BoxDecoration(
          //             color: Theme.of(context).backgroundColor,
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //           height: 60.h,
          //           width: 90.w,
          //           child: Column(
          //             children: [
          //               SizedBox(
          //                 height: 1.7.h,
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.all(8),
          //                 child: Text(
          //                   "New Update Available",
          //                   style: TextStyle(
          //                     fontSize: 16.sp,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //               Divider(
          //                 color: Theme.of(context).accentColor,
          //               ),
          //               Expanded(
          //                 child: Text(
          //                   _updateNote,
          //                   style: getDefaultTextStyle(size: 12.sp),
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(16.0),
          //                 child: InkWell(
          //                     onTap: () {
          //                       // launch("https://onplay365.in");
          //                       setState(() {
          //                         _updateAvailable = false;
          //                       });
          //                     },
          //                     child: Container(
          //                       padding: EdgeInsets.symmetric(horizontal: 26),
          //                       height: 49,
          //                       decoration: BoxDecoration(
          //                           color: Theme.of(context).accentColor,
          //                           borderRadius: BorderRadius.circular(5)),
          //                       child: Center(
          //                         child: Text(
          //                           "Update",
          //                           style: TextStyle(
          //                               fontSize: 14.sp, color: Colors.white),
          //                         ),
          //                       ),
          //                     )),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   )
        ],
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
