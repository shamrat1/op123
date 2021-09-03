import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/User.dart';

class AuthUserState extends StateNotifier<User> {
  AuthUserState(User state) : super(state) {
    setUser();
  }

  void change(User user) => state = user;

  void add() async {
    var storage = FlutterSecureStorage();
    await storage.write(key: userKey, value: jsonEncode(state));
  }

  void setUser() async {
    var storage = FlutterSecureStorage();
    var user = jsonDecode(await storage.read(key: userKey) ?? "");
    if (user != "") {
      state = User.fromMap(user);
    }
  }
}
