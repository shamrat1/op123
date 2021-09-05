import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

var currencylogoText = "৳";
// String rootUrl = "https://cors-anywhere.herokuapp.com/http://mywebdeveloper.zomanoo.com/public/api/";
String rootUrl = "http://localhost:8888/new-web/api/";

String userKey = "authenticatedUser";
String tokenKey = "auth-token";


void showCustomSimpleNotification(String message, Color color) {
  showSimpleNotification(Text(message),
        background: color);
}