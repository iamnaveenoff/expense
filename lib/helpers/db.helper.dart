import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/account.model.dart';
import '../models/category.model.dart';
import '../models/payment.model.dart';

class FirestoreHelper {
  CollectionReference accountsCollection =
      FirebaseFirestore.instance.collection("accounts");
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  CollectionReference paymentsCollection =
      FirebaseFirestore.instance.collection("payments");

  Future<void> resetDatabase() async {
    await paymentsCollection.get().then((querySnapshot) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });

    await accountsCollection.get().then((querySnapshot) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });

    await categoriesCollection.get().then((querySnapshot) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });

    await accountsCollection.add({
      "id": "001",
      "name": "Cash",
      "icon": Icons.wallet.codePoint,
      "color": Colors.teal.value,
      "isDefault": true,
    });

    List<Map<String, dynamic>> categories = [
      {"name": "Housing", "icon": Icons.house.codePoint},
      {"name": "Transportation", "icon": Icons.emoji_transportation.codePoint},
      {"name": "Food", "icon": Icons.restaurant.codePoint},
      {"name": "Utilities", "icon": Icons.category.codePoint},
      {"name": "Insurance", "icon": Icons.health_and_safety.codePoint},
      {
        "name": "Medical & Healthcare",
        "icon": Icons.medical_information.codePoint
      },
      {
        "name": "Saving, Investing, & Debt Payments",
        "icon": Icons.attach_money.codePoint
      },
      {"name": "Personal Spending", "icon": Icons.house.codePoint},
      {"name": "Recreation & Entertainment", "icon": Icons.tv.codePoint},
      {"name": "Miscellaneous", "icon": Icons.library_books_sharp.codePoint},
    ];

    int index = 0;
    for (Map<String, dynamic> category in categories) {
      await categoriesCollection.add({
        "name": category["name"],
        "icon": category["icon"],
        "color": Colors.primaries[index].value,
      });
      index++;
    }
  }

  Future<void> saveAccount(Account account) async {
    await accountsCollection.add(account.toJson());
  }

  Stream<List<Account>> getAccounts() {
    return accountsCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Account.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> saveCategory(Category category) async {
    await categoriesCollection.add(category.toJson());
  }

  Stream<List<Category>> getCategories() {
    return categoriesCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> savePayment(Payment payment) async {
    await paymentsCollection.add(payment.toJson());
  }

  Stream<List<Payment>> getPayments() {
    return paymentsCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Payment.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
