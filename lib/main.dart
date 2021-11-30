import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_context/one_context.dart';
import 'package:op123/app/states/CreditState.dart';
import 'package:op123/app/states/SettingState.dart';
import 'package:op123/app/states/StateManager.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/constants/globals.dart';
import 'app/models/User.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  await Firebase.initializeApp();
  runApp(ProviderScope(child: OverlaySupport.global(child: MyApp())));
}

Map<int, Color> customSwatch = {
  50: Color.fromRGBO(255, 255, 255, .1),
  100: Color.fromRGBO(255, 255, 255, .2),
  200: Color.fromRGBO(255, 255, 255, .3),
  300: Color.fromRGBO(255, 255, 255, .4),
  400: Color.fromRGBO(255, 255, 255, .5),
  500: Color.fromRGBO(255, 255, 255, .6),
  600: Color.fromRGBO(255, 255, 255, .7),
  700: Color.fromRGBO(255, 255, 255, .8),
  800: Color.fromRGBO(255, 255, 255, .9),
  900: Color.fromRGBO(255, 255, 255, 1),
};

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initialSetup();
  }

  // This widget is the root of your application.
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

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, origentation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: OneContext().navigator.key,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Tajawal",
          accentColor: Color(0xff9f7c37),
          backgroundColor: Color(0xff2e2e2e),
          primaryColor: Colors.white,
          focusColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xff9f7c37)),
          primarySwatch: MaterialColor(0xFFFFFFFF, customSwatch),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff9f7c37),
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: RootScreen(),
      );
    });
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new MyHomePage(),
      title: new Text(
        'Build on Trust & Reliability',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      image: Image.asset("assets/images/logo-light.png"),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}
