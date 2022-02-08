import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';

class MatchState extends StateNotifier<List<Match>> {
  MatchState(List<Match> state) : super(state) {
    getMatches();
  }

  Future<void> getMatches() async {
    state = await RemoteService().getMatches();
  }
}

class MatchParamState extends StateNotifier<String> {
  MatchParamState(String state) : super(state);

  void change(String str) => state = str;
}
