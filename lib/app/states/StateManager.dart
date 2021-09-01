

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:op123/app/models/Match.dart';
import 'package:op123/app/states/MatchState.dart';

var matchesProvider = StateNotifierProvider<MatchState,List<Match>>((ref) => MatchState([]));