import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account {
  String? id;
  String name;
  String holderName;
  String accountNumber;
  IconData icon;
  Color color;
  bool? isDefault;
  double? balance;
  double? income;
  double? expense;

  Account({
    this.id,
    required this.name,
    required this.holderName,
    required this.accountNumber,
    required this.icon,
    required this.color,
    this.isDefault,
    this.income,
    this.expense,
    this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> data) => Account(
        id: data["id"] as String?,
        name: data["name"] as String? ?? "",
        holderName: data["holderName"] as String? ?? "",
        accountNumber: data["accountNumber"] as String? ?? "",
        icon: IconData(data["icon"] as int? ?? 0, fontFamily: 'MaterialIcons'),
        color: Color(data["color"] as int? ?? 0),
        isDefault: data["isDefault"] == 1 ? true : false,
        income: (data["income"] as num?)?.toDouble(),
        expense: (data["expense"] as num?)?.toDouble(),
        balance: (data["balance"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "holderName": holderName,
        "accountNumber": accountNumber,
        "icon": icon.codePoint,
        "color": color.value,
        "isDefault": (isDefault ?? false) ? 1 : 0,
      };

  Future<void> save() async {
    CollectionReference accountsCollection =
        FirebaseFirestore.instance.collection("accounts");
    return await accountsCollection.doc(id).set(toJson());
  }
}
