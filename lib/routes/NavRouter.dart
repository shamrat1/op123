import 'package:get/get.dart';
import 'package:OnPlay365/main.dart';
import 'package:OnPlay365/routes/RouteConstant.dart';
import 'package:OnPlay365/views/MyHomePage.dart';
import 'package:OnPlay365/views/authentication/Signin.dart';
import 'package:OnPlay365/views/authentication/Signup.dart';
import 'package:OnPlay365/views/games/FlipCoin.dart';

class NavRouter {
  static final generateRoute = [
    GetPage(name: splash, page: () => RootScreen()),
    GetPage(name: home, page: () => MyHomePage()),
    GetPage(name: signin, page: () => SignInPage()),
    GetPage(name: signup, page: () => SignUpPage()),
    GetPage(name: coinFlip, page: () => CoinFlip()),
  ];
}
