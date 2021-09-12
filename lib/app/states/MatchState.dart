import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/services/RemoteService.dart';

class MatchState extends StateNotifier<List<Match>> {
  MatchState(List<Match> state) : super(state) {
    getMatches();
  }

  Future<void> getMatches() async {
    state = await RemoteService().getMatches();
  }
}
