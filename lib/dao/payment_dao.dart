import 'package:flutter/material.dart';

import '../helpers/db.helper.dart';
import '../models/account.model.dart';
import '../models/category.model.dart';
import '../models/payment.model.dart';
import 'account_dao.dart';
import 'category_dao.dart';
import 'package:collection/collection.dart';

class PaymentDao {
  FirestoreHelper firestoreHelper = FirestoreHelper();

  Future<void> create(Payment payment) async {
    await firestoreHelper.paymentsCollection.add(payment.toJson());
  }

  Future<List<Payment>> find({
    DateTimeRange? range,
    PaymentType? type,
    Category? category,
    Account? account,
  }) async {
    List<Payment> payments = [];

    if (range != null) {
      // Implement date range filtering (if needed)
    }

    // Implement other filters (type, category, account) if needed

    var querySnapshot = await firestoreHelper.paymentsCollection.get();
    List<Category> categories = await CategoryDao().find();
    List<Account> accounts = await AccountDao().find();

    payments = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Payment payment = Payment.fromJson(data);

      // Find the corresponding account
      Account? account =
          accounts.firstWhereOrNull((a) => a.id == data["account"]);
      if (account != null) {
        payment.account = account;
      } else {
        // Handle the case when the account is not found (optional)
        // You can set a default account or handle this situation as needed.
      }

      // Find the corresponding category
      Category? category =
          categories.firstWhereOrNull((c) => c.id == data["category"]);
      if (category != null) {
        payment.category = category;
      } else {
        // Handle the case when the category is not found (optional)
        // You can set a default category or handle this situation as needed.
      }

      return payment;
    }).toList();

    return payments;
  }

  Future<void> update(Payment payment) async {
    await firestoreHelper.paymentsCollection
        .doc(payment.id.toString()) // Convert int to String
        .set(payment.toJson());
  }

  Future<void> upsert(Payment payment) async {
    if (payment.id != null) {
      await update(payment);
    } else {
      await create(payment);
    }
  }

  Future<void> deleteTransaction(int id) async {
    await firestoreHelper.paymentsCollection.doc(id.toString()).delete();
  }

  Future<void> deleteAllTransactions() async {
    await firestoreHelper.resetDatabase();
  }
}
