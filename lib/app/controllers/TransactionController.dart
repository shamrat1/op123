import 'dart:ffi';

import 'package:OnPlay365/app/Enums/TransactionType.dart';
import 'package:OnPlay365/app/models/Match.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';

class TransactionController {
  final double amount;
  TransactionType? type;
  String? giftReceiver;
  String? backendPhoneNumber;
  final String phoneNumber;

  TransactionController({
    required this.amount,
    required this.phoneNumber,
    this.type,
    this.giftReceiver,
    this.backendPhoneNumber,
  });

  void handleTransaction() {
    switch (type) {
      case TransactionType.DEPOSIT:
        _initiateDeposit();
        break;
      case TransactionType.WITHDRAW:
        _initiateWithdraw();
        break;
      case TransactionType.COIN_TRANSFER:
        _initiateGift();
        break;
      case null:
        throw Error();
    }
    return;
  }

  String _getTransactionType() {
    switch (type) {
      case TransactionType.DEPOSIT:
        return "deposit";
      case TransactionType.WITHDRAW:
        return "withdraw";
      case TransactionType.COIN_TRANSFER:
        return "gift";
      case null:
        return "";
    }
  }

  void _initiateDeposit() {
    // RemoteService()
  }

  void _initiateWithdraw() {}

  void _initiateGift() {}
}
