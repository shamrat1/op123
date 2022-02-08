import 'package:OnPlay365/app/services/AuthenticationService.dart';
import 'package:OnPlay365/views/authentication/Signin.dart';
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
    required this.phone,
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
  final String? phone;
  final int? clubId;

  void register() async {
    // print(
    //     "$username | $name | ${email.isValidEmail()} | $password | $passwordConfirmation | $country | $sponser | $clubId");
    if (_validate()) {
      var data = {
        "username" : username,
        "email" : email,
        "password" : password.toString(),
        "password_confirmation" : passwordConfirmation.toString(),
        "country" : country,
        "sponser" : sponser ?? '',
        "clubId" : clubId.toString(),
        "mobile" : phone,
      };
      var response = await AuthenticationService().signUp(data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        showSimpleNotification(
            Text("Registration Successful. Login In to win amazing prices."),
            background: Colors.green);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => SignInPage()), (route) => false);
      } else if (response.statusCode == 401) {
        showSimpleNotification(
            Text("Unauthorized. Try Again later or contact admin."),
            background: Colors.red);
      } else if (response.statusCode == 419) {
        showSimpleNotification(
            Text(response.body),
            background: Colors.amber);
      } else {
        showSimpleNotification(Text("Unknown Error. contact admin."),
            background: Colors.amber);
      }
    }
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
    } else if (!email.isValidEmail()) {
      print(email.isValidEmail());
      showSimpleNotification(Text("Enter a valid email."),
          background: Colors.red);
      return false;
    } else {
      _isValidated = true;
    }
    return _isValidated;
  }
}
