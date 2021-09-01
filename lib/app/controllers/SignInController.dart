import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class SignInController {
  const SignInController({
    required this.context,
    required this.username,
    required this.password,
  });

  final BuildContext context;
  final String username;
  final String password;

  void signin() {
    if(_validate()){
      
    }
  }

  bool _validate() {
    bool _isValidated = false;
    if (username.isEmpty || username.length < 3) {
      showSimpleNotification(Text("Enter a valid Username."),
          background: Colors.red);
      return false;
    } else if (password.isEmpty || username.length < 8) {
      showSimpleNotification(Text("Enter a valid Password."),
          background: Colors.red);
      return false;
    } else {
      _isValidated = true;
    }
    return _isValidated;
  }
}
