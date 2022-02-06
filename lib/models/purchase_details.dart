// To parse this JSON data, do
//
//     final purchaseDetail = purchaseDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import '../enums/purchase_type.dart';

PurchaseDetail purchaseDetailFromJson(String str) => PurchaseDetail.fromJson(json.decode(str));

String purchaseDetailToJson(PurchaseDetail data) => json.encode(data.toJson());

class PurchaseDetail {
    PurchaseDetail({
        required this.finCode,
        required this.clientName,
        required this.dealType,
        required this.quantity,
        required this.value,
        required this.tradePrice,
        required this.dealDate,
        required this.exchange,
    });

    final String finCode;
    final String clientName;
    final DealType dealType;
    final int quantity;
    final double value;
    final double tradePrice;
    final DateTime dealDate;
    final String exchange;

    factory PurchaseDetail.fromJson(Map<String, dynamic> json) => PurchaseDetail(
        finCode: json["FinCode"],
        clientName: json["ClientName"],
        dealType: dealTypeFromDatabaseForm(json["DealType"]),
        quantity: int.parse(json["Quantity"]),
        value: double.parse(json["Value"]),
        tradePrice: double.parse(json["TradePrice"]),
        dealDate: DateTime.parse(json["DealDate"]),
        exchange: json["Exchange"],
    );

    Map<String, dynamic> toJson() => {
        "FinCode": finCode,
        "ClientName": clientName,
        "DealType": dealType,
        "Quantity": quantity,
        "Value": value,
        "TradePrice": tradePrice,
        "DealDate": dealDate.toIso8601String(),
        "Exchange": exchange,
    };
}