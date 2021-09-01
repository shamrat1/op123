import 'package:op123/app/models/BetDetail.dart';
import 'package:op123/app/models/BetsForMatch.dart';
import 'package:op123/app/models/Match.dart';

class PlacedBetController {
  final double amount;
  final Match match;
  final BetsForMatch betsForMatch;
  final BetDetail betDetail;

  const PlacedBetController({
    required this.amount,
    required this.match,
    required this.betsForMatch,
    required this.betDetail,
  });

  void registerBet() {
    
  }
}
