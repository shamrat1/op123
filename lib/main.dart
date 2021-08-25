import 'package:flutter/material.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:op123/views/authentication/Signin.dart';
import 'package:op123/views/authentication/Signup.dart';

void main() {
  runApp(MyApp());
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Tajawal",
        accentColor: Color(0xff9f7c37),
        backgroundColor: Color(0xff2e2e2e),
        primaryColor: Colors.white,
        focusColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff9f7c37)),
        primarySwatch: MaterialColor(0xFFFFFFFF, customSwatch),
        // inputDecorationTheme: InputDecorationTheme(
        //   focusColor: Colors.white,
        //   focusedBorder:
        //       OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        // )
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: SignUpPage(),
    );
  }
}
