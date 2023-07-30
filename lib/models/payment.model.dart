import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'account.model.dart';
import 'category.model.dart';

enum PaymentType { debit, credit }

class Payment {
  int? id;
  Account account;
  Category category;
  double amount;
  PaymentType type;
  DateTime datetime;
  String title;
  String description;

  Payment({
    this.id,
    required this.account,
    required this.category,
    required this.amount,
    required this.type,
    required this.datetime,
    required this.title,
    required this.description,
  });

  factory Payment.fromJson(Map<String, dynamic> data) {
    return Payment(
      id: data["id"] as int?,
      title: data["title"] as String? ?? "",
      description: data["description"] as String? ?? "",
      account: Account.fromJson(data["account"] as Map<String, dynamic>),
      category: Category.fromJson(data["category"] as Map<String, dynamic>),
      amount: (data["amount"] as num).toDouble(),
      type: data["type"] == "CR" ? PaymentType.credit : PaymentType.debit,
      datetime: DateTime.parse(data["datetime"] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "account": account.toJson(), // Save the account as a nested object
        "category": category.toJson(), // Save the category as a nested object
        "amount": amount,
        "datetime": DateFormat('yyyy-MM-dd kk:mm:ss').format(datetime),
        "type": type == PaymentType.credit ? "CR" : "DR",
      };

  Future<void> save() async {
    CollectionReference paymentsCollection =
        FirebaseFirestore.instance.collection("payments");
    return await paymentsCollection.doc(id.toString()).set(toJson());
  }
}
