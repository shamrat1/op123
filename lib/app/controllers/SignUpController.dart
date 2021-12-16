import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:OnPlay365/app/extensions/StringExtension.dart';

class SignUpController {
  const SignUpController({
    required this.context,
    required this.username,
    required this.password,
    required this.passwordConfirmation,
    this.name,
    this.country,
    this.clubId,
    required this.email,
    this.sponser,
  });
  final BuildContext context;
  final String username;
  final String password;
  final String passwordConfirmation;
  final String? name;
  final String email;
  final String? country;
  final String? sponser;
  final int? clubId;

  void register() {
    print(
        "$username | $name | ${email.isValidEmail()} | $password | $passwordConfirmation | $country | $sponser | $clubId");
    if (_validate()) {}
  }

  bool _validate() {
    bool _isValidated = false;
    if (username.isEmpty && username.length < 3) {
      showSimpleNotification(Text("Enter a valid Username."),
          background: Colors.red);
      return false;
    } else if (password.isEmpty && password.length < 8) {
      showSimpleNotification(Text("Enter a valid Password."),
          background: Colors.red);
      return false;
    } else if (passwordConfirmation.isEmpty &&
        passwordConfirmation.length < 8) {
      showSimpleNotification(
          Text("Confirm Password by typing it in Password Confirmation Field."),
          background: Colors.red);
      return false;
    } else if (password != passwordConfirmation) {
      showSimpleNotification(Text("Passwords do not match"),
          background: Colors.red);
      return false;
    } else if (email.isValidEmail()) {
      showSimpleNotification(Text("Enter a valid email."),
          background: Colors.red);
      return false;
    } else {
      _isValidated = true;
    }
    return _isValidated;
  }
}
