import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:op123/app/helpers/SliverPersistantHeaderDelegateImplementation.dart';
import 'package:op123/views/widgets/CustomAppDrawer.dart';

import 'games/FlipCoin.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
        // print("tabs are clicked ${_tabController.index}");
      });
    });
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
        width: 50,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              asset,
              width: 60,
              height: 60,
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

  Widget _getSingleMatch() {
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
                            "India V England",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "England Tour Of India, 2021 | 2021-02-05 10:00 AM",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    _getSportIcon("cricket"),
                  ],
                ),
                Container(
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
                            "1st Over Run",
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
                        height: 3 * 20 + 20,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(0),
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          crossAxisCount: 2,
                          childAspectRatio:
                              (MediaQuery.of(context).size.width * 0.40 / 20),
                          children: [
                            for (var i = 1; i < 7; i++)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "$i Run",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            "1st Innings Total Run",
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
                        height: 20 * 3,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(0),
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          crossAxisCount: 2,
                          childAspectRatio:
                              (MediaQuery.of(context).size.width * 0.40 / 20),
                          children: [
                            for (var i = 1; i < 4; i++)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "${i * 100 + (20)} Run",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getGames() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        // color: Colors.black,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CoinFlip();
                }));
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                width: MediaQuery.of(context).size.width - 16,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    "Coin Flip",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabOne(int length) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0.0),
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        // height: 400,
        color: Colors.black,
        child: Column(
          children: [
            for (var i = 0; i < length; i++) _getSingleMatch(),
          ],
        ),
      ),
    );
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
                    width: 200,
                    child: SvgPicture.asset("assets/images/logo-light.svg")),
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
                _tabOne(4),
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
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Marquee(
        text: "This is a long very long Message. Which is dedicated to Users",
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
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
