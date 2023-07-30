import 'package:cloud_firestore/cloud_firestore.dart';
import '../helpers/db.helper.dart';
import '../models/account.model.dart'; // Import FirestoreHelper

class AccountDao {
  FirestoreHelper firestoreHelper = FirestoreHelper();

  Future<void> create(Account account) async {
    await firestoreHelper.accountsCollection.add(account.toJson());
  }

  Future<List<Account>> find({bool withSummary = false}) async {
    QuerySnapshot querySnapshot =
        await firestoreHelper.accountsCollection.get();

    List<Account> accounts = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Account account = Account.fromJson(data);

      if (withSummary) {
        // Fetch and calculate summary values (income, expense, balance)
        double income = 0.0;
        double expense = 0.0;
        QuerySnapshot paymentSnapshot = await firestoreHelper.paymentsCollection
            .where('account', isEqualTo: doc.id)
            .get();

        for (QueryDocumentSnapshot paymentDoc in paymentSnapshot.docs) {
          Map<String, dynamic> paymentData =
              paymentDoc.data() as Map<String, dynamic>;
          double amount = paymentData['amount'] ?? 0.0;
          String type = paymentData['type'] ?? '';

          if (type == 'CR') {
            income += amount;
          } else if (type == 'DR') {
            expense += amount;
          }
        }

        account.income = income;
        account.expense = expense;
        account.balance = income - expense;
      }

      accounts.add(account);
    }

    return accounts;
  }

  Future<void> update(Account account) async {
    await firestoreHelper.accountsCollection
        .doc(account.id)
        .set(account.toJson());
  }

  Future<void> upsert(Account account) async {
    if (account.id != null) {
      await update(account);
    } else {
      await create(account);
    }
  }

  Future<void> delete(String id) async {
    await firestoreHelper.accountsCollection.doc(id).delete();
    await firestoreHelper.paymentsCollection
        .where('account', isEqualTo: id)
        .get()
        .then((snapshot) {
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}
