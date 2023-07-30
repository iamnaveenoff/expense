import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void v1() async {
  // Initialize Firebase
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create 'payments' collection and add example document
  await firestore.collection('payments').doc('examplePayment').set({
    'title': 'Example Payment',
    'description': 'This is an example payment',
    'account': 1,
    'category': 1,
    'amount': 100.0,
    'type': 'Expense',
    'datetime': DateTime.now(),
  });

  // Create 'categories' collection and add example document
  await firestore.collection('categories').doc('exampleCategory').set({
    'name': 'Example Category',
    'icon': Icons.category.codePoint,
    'color': Colors.blue.value,
    'budget': 1000.0,
    'type': 'Expense',
  });

  // Create 'accounts' collection and add example document
  await firestore.collection('accounts').doc('exampleAccount').set({
    'name': 'Example Account',
    'holderName': 'John Doe',
    'accountNumber': '123456789',
    'icon': Icons.account_balance.codePoint,
    'color': Colors.green.value,
    'isDefault': true,
  });

  debugPrint("First migration completed successfully.");
}
