import 'package:flutter/material.dart';

class SignUpController {

  const SignUpController({
    required this.context,
    required this.username,
    required this.password,
    required this.passwordConfirmation,
    this.name,
    this.country,
    this.clubId,
    this.email,
    this.sponser,
  });
  final BuildContext context;
  final String username;
  final String password;
  final String passwordConfirmation;
  final String? name;
  final String? email;
  final String? country;
  final String? sponser;
  final int? clubId;

  void register() {}

  void validate() {
    
  }
}
