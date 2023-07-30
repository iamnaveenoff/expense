


import 'category_model.dart';

class Expense {
  final String name;
  final double amount;
  final DateTime date;
  final Category category; // Add the Category field

  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.category, // Include the category field in the constructor
  });
}
