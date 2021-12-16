import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/models/GeneralResponse.dart';
import 'package:OnPlay365/app/services/AuthenticationService.dart';
import 'package:OnPlay365/app/states/AuthUserState.dart';
import 'package:OnPlay365/app/states/StateManager.dart';
import 'package:OnPlay365/views/MyHomePage.dart';
import 'package:overlay_support/overlay_support.dart';

class SignInController {
  SignInController({
    required this.context,
    required this.username,
    required this.password,
  });

  final BuildContext context;
  final String username;
  final String password;

  AuthenticationService _authenticationService = AuthenticationService();

  void signin() async {
    if (_validate()) {
      var data = {
        "username": username,
        "password": password,
      };
      var response = await _authenticationService.signIn(data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        try {
          _handleAuthenticatedUser(response);
        } catch (e) {
          print(e);
        }
      } else if (response.statusCode == 401) {
        showSimpleNotification(
            Text("Unauthorized. Try Again later or contact admin."),
            background: Colors.red);
      } else if (response.statusCode == 419) {
        showSimpleNotification(
            Text("Username Or password doesn't match. Try again."),
            background: Colors.amber);
      } else {
        showSimpleNotification(Text("Unknown Error. contact admin."),
            background: Colors.amber);
      }
    }
  }

  void _handleAuthenticatedUser(Response response) {
    var generalResponse = generalResponseFromMap(response.body);
    print(generalResponse.user?.token);
    var authUserState = context.read(authUserProvider.notifier);
    if (generalResponse.user != null) {
      context
          .read(authTokenProvider.notifier)
          .change(generalResponse.user!.token!);
      var storage = FlutterSecureStorage();
      storage.write(key: tokenKey, value: generalResponse.user!.token!);
    }

    authUserState.change(generalResponse.user!);
    authUserState.add();
    showSimpleNotification(Text("Login Successful."), background: Colors.green);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (route) => false);
  }

  bool _validate() {
    bool _isValidated = false;
    if (username.isEmpty || username.length < 3) {
      showSimpleNotification(Text("Enter a valid Username."),
          background: Colors.red);
      return false;
    } else if (password.isEmpty || password.length < 8) {
      showSimpleNotification(Text("Enter a valid Password."),
          background: Colors.red);
      return false;
    } else {
      _isValidated = true;
    }
    return _isValidated;
  }
}
