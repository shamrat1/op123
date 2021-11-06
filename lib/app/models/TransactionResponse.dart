// To parse this JSON data, do
//
//     final transactionsResponse = transactionsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TransactionsResponse transactionsResponseFromMap(String str) =>
    TransactionsResponse.fromMap(json.decode(str));

String transactionsResponseToMap(TransactionsResponse data) =>
    json.encode(data.toMap());

class TransactionsResponse {
  TransactionsResponse({
    @required this.status,
    @required this.msg,
    @required this.transactions,
  });

  final String? status;
  final String? msg;
  final Transactions? transactions;

  factory TransactionsResponse.fromMap(Map<String, dynamic> json) =>
      TransactionsResponse(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        transactions: json["transactions"] == null
            ? null
            : Transactions.fromMap(json["transactions"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "transactions": transactions == null ? null : transactions!.toMap(),
      };
}

class Transactions {
  Transactions({
    @required this.currentPage,
    @required this.transaction,
    @required this.firstPageUrl,
    @required this.from,
    @required this.lastPage,
    @required this.lastPageUrl,
    @required this.nextPageUrl,
    @required this.path,
    @required this.perPage,
    @required this.prevPageUrl,
    @required this.to,
    @required this.total,
  });

  final int? currentPage;
  final List<Transaction>? transaction;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  factory Transactions.fromMap(Map<String, dynamic> json) => Transactions(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        transaction: json["data"] == null
            ? null
            : List<Transaction>.from(
                json["data"].map((x) => Transaction.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null : currentPage,
        "transaction": transaction == null
            ? null
            : List<dynamic>.from(transaction!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Transaction {
  Transaction({
    @required this.id,
    @required this.userId,
    @required this.amount,
    @required this.mobile,
    @required this.backendMobile,
    @required this.txnId,
    @required this.type,
    @required this.paymentMethod,
    @required this.paymentType,
    @required this.status,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? amount;
  final String? mobile;
  final String? backendMobile;
  final String? txnId;
  final String? type;
  final String? paymentMethod;
  final String? paymentType;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        amount: json["amount"] == null ? null : json["amount"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        backendMobile: json["backend_mobile"],
        txnId: json["txn_id"],
        type: json["type"] == null ? null : json["type"],
        paymentMethod: json["payment_method"],
        paymentType: json["payment_type"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "amount": amount == null ? null : amount,
        "mobile": mobile == null ? null : mobile,
        "backend_mobile": backendMobile,
        "txn_id": txnId,
        "type": type == null ? null : type,
        "payment_method": paymentMethod,
        "payment_type": paymentType,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
