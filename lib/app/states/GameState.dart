import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:op123/views/games/BoardGame.dart';

var spinGameTurnsProvider =
    StateNotifierProvider<SpinGameTurnState, List<GameOption>>(
        (ref) => SpinGameTurnState([]));

class SpinGameTurnState extends StateNotifier<List<GameOption>> {
  SpinGameTurnState(List<GameOption> state) : super(state);

  void add(GameOption option) {
    this.state.add(option);
  }

  void empty() {
    this.state = [];
  }
}
