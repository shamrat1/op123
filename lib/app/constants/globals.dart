import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

var currencylogoText = "৳";
String rootUrl = "https://onplay365.in/api/";
// String rootUrl = "http://192.168.31.223:8888/new-web/api/";

String userKey = "authenticatedUser";
String tokenKey = "auth-token";

void showCustomSimpleNotification(String message, Color color) {
  showSimpleNotification(Text(message), background: color);
}
