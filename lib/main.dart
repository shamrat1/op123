import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_context/one_context.dart';
import 'package:op123/app/states/StateManager.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

void main() {
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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    context.read(matchesProvider.notifier).getMatches();
    // context.read(authUserProvider.notifier).setUser();
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
        home: MyHomePage(),
      );
    });
  }
}
