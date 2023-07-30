import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/expense_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _addExpense(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);

    // Show a dialog to add an expense with category selection
    showDialog(
      context: context,
      builder: (context) {
        Expense? _selectedCategory; // Initialize a variable to store the selected category

        return AlertDialog(
          title: Text('Add Expense'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Expense Name'),
                  controller: _expenseNameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<Category>(
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    // Update the selected category when the user selects a new value
                    _selectedCategory = newValue;
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Select Category'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Create a new Expense object and add it to the provider
                final newExpense = Expense(
                  name: _expenseNameController.text,
                  amount: double.parse(_amountController.text),
                  date: DateTime.now(),
                  category: _selectedCategory, // Assign the selected category to the new expense
                );
                expenseProvider.addExpense(newExpense);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
