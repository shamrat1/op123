import 'package:OnPlay365/app/models/BetDetail.dart';
import 'package:OnPlay365/app/models/BetsForMatch.dart';
import 'package:OnPlay365/app/models/Match.dart';

class CoinGameController {
  final double amount;
  final double rate;

  const CoinGameController({
    required this.amount,
    required this.rate,
  });

  void initiateGameStart() {
    if(_validate()){
      
    }
  }

  bool _validate() {

    // check if user has more or equal to input amount

    return true;
  }
}
