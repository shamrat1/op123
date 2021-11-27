import 'package:get/get.dart';
import 'package:op123/main.dart';
import 'package:op123/routes/RouteConstant.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:op123/views/authentication/Signin.dart';
import 'package:op123/views/authentication/Signup.dart';
import 'package:op123/views/games/FlipCoin.dart';

class NavRouter {
  static final generateRoute = [
    GetPage(name: splash, page: () => RootScreen()),
    GetPage(name: home, page: () => MyHomePage()),
    GetPage(name: signin, page: () => SignInPage()),
    GetPage(name: signup, page: () => SignUpPage()),
    GetPage(name: coinFlip, page: () => CoinFlip()),
  ];
}
