import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:op123/app/models/GeneralResponse.dart';
import 'package:op123/app/services/AuthenticationService.dart';
import 'package:op123/app/states/AuthUserState.dart';
import 'package:op123/app/states/StateManager.dart';
import 'package:op123/views/MyHomePage.dart';
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

      if (response.statusCode == 200) {
        try {
          var generalResponse = generalResponseFromMap(response.body);
          var providerContainer = ProviderContainer();
          var authUserState = providerContainer.read(authUserProvider.notifier);
          authUserState.change(generalResponse.user!);
          authUserState.add();
          showSimpleNotification(Text("Login Successful."),
              background: Colors.green);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => false);
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
