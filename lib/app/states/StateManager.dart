import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:OnPlay365/app/models/User.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';
import 'package:OnPlay365/app/states/AuthUserState.dart';
import 'package:OnPlay365/app/states/MatchState.dart';

// var matchesProvider =
//     StateNotifierProvider<MatchState, List<Match>>((ref) => MatchState([]));
var matchesProvider =
    FutureProvider((ref) async {
      var params = ref.watch(matchParamProvider);
      print("-------------------------------------------");
      print(params);
      print("-------------------------------------------");
     return await RemoteService().getMatches(params: params);
    });

var matchParamProvider = StateNotifierProvider<MatchParamState, String>((ref) => MatchParamState('status=live&sport=all'));
var authUserProvider =
    StateNotifierProvider<AuthUserState, User>((ref) => AuthUserState(User()));

var authTokenProvider =
    StateNotifierProvider<TokenState, String>((ref) => TokenState(""));

class TokenState extends StateNotifier<String> {
  TokenState(String state) : super(state);

  void change(String token) => state = token;
}
