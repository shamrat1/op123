import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/models/User.dart';
import 'package:op123/app/states/AuthUserState.dart';
import 'package:op123/app/states/MatchState.dart';

var matchesProvider =
    StateNotifierProvider<MatchState, List<Match>>((ref) => MatchState([]));
var authUserProvider =
    StateNotifierProvider<AuthUserState, User>((ref) => AuthUserState(User()));

var authTokenProvider =
    StateNotifierProvider<TokenState, String>((ref) => TokenState(""));

class TokenState extends StateNotifier<String> {
  TokenState(String state) : super(state);

  void change(String token) => state = token;
}
