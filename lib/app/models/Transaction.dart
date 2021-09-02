// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromMap(jsonString);

import 'dart:convert';

TransactionResponse transactionResponseFromMap(String str) =>
    TransactionResponse.fromMap(json.decode(str));

String transactionResponseToMap(TransactionResponse data) =>
    json.encode(data.toMap());

class TransactionResponse {
  TransactionResponse({
    this.status,
    this.msg,
    this.transactions,
  });

  final String? status;
  final String? msg;
  final Transactions? transactions;

  factory TransactionResponse.fromMap(Map<String, dynamic> json) =>
      TransactionResponse(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int? currentPage;
  final List<Datum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final dynamic? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic? prevPageUrl;
  final int? to;
  final int? total;

  factory Transactions.fromMap(Map<String, dynamic> json) => Transactions(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
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
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
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

class Datum {
  Datum({
    this.id,
    this.userId,
    this.amount,
    this.mobile,
    this.backendMobile,
    this.txnId,
    this.type,
    this.paymentMethod,
    this.paymentType,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? amount;
  final String? mobile;
  final String? backendMobile;
  final dynamic? txnId;
  final String? type;
  final dynamic? paymentMethod;
  final dynamic? paymentType;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        amount: json["amount"] == null ? null : json["amount"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        backendMobile:
            json["backend_mobile"] == null ? null : json["backend_mobile"],
        txnId: json["txn_id"],
        type: json["type"] == null ? null : json["type"],
        paymentMethod: json["payment_method"],
        paymentType: json["payment_type"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "amount": amount == null ? null : amount,
        "mobile": mobile == null ? null : mobile,
        "backend_mobile": backendMobile == null ? null : backendMobile,
        "txn_id": txnId,
        "type": type == null ? null : type,
        "payment_method": paymentMethod,
        "payment_type": paymentType,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
      };
}
