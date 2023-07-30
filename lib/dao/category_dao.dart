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
      // Implement summary logic here (if needed)
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
