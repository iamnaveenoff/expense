import 'package:flutter/material.dart';

import '../models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  // Getter to access the list of expenses
  List<Expense> get expenses => _expenses;

  // Method to add an expense
  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  // Method to remove an expense
  void removeExpense(Expense expense) {
    _expenses.remove(expense);
    notifyListeners();
  }
}
