import '../helpers/db.helper.dart';
import '../models/category.model.dart';

class CategoryDao {
  FirestoreHelper firestoreHelper = FirestoreHelper();

  Future<void> create(Category category) async {
    await firestoreHelper.categoriesCollection.add(category.toJson());
  }

  Future<List<Category>> find({bool withSummary = true}) async {
    List<Category> categories = [];

    if (withSummary) {
      var querySnapshot = await firestoreHelper.categoriesCollection.get();
      for (var doc in querySnapshot.docs) {
        var categoryData = doc.data() as Map<String, dynamic>;
        var category = Category.fromJson(categoryData);

        // Calculate the summary logic here based on your requirements
        double totalExpense = 0;
        // Fetch the expenses that have a matching 'category_id' with the current category
        var expensesQuerySnapshot = await firestoreHelper.expensesCollection
            .where('category_id', isEqualTo: category.id)
            .get();
        for (var expenseDoc in expensesQuerySnapshot.docs) {
          var expenseData = expenseDoc.data() as Map<String, dynamic>;
          var expenseAmount = expenseData['amount'] as double;
          totalExpense += expenseAmount;
        }

        // Update the category model with the summary data
        category.expense = totalExpense;
        // Add the category to the list
        categories.add(category);
      }
    } else {
      var querySnapshot = await firestoreHelper.categoriesCollection.get();
      categories = querySnapshot.docs
          .map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    }

    return categories;
  }

  Future<void> update(Category category) async {
    await firestoreHelper.categoriesCollection
        .doc(category.id.toString())
        .set(category.toJson());
  }

  Future<void> upsert(Category category) async {
    if (category.id != null) {
      await update(category);
    } else {
      await create(category);
    }
  }

  Future<void> delete(String id) async {
    await firestoreHelper.categoriesCollection.doc(id).delete();
  }

  Future<void> deleteAll() async {
    await firestoreHelper.resetDatabase();
  }
}
