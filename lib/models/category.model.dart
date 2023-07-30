import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  int? id;
  String name;
  IconData icon;
  Color color;
  double? budget;
  double? expense;

  Category({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.budget,
    this.expense,
  });

  factory Category.fromJson(Map<String, dynamic> data) => Category(
        id: data["id"] as int?,
        name: data["name"] as String,
        icon: IconData(data["icon"] as int, fontFamily: 'MaterialIcons'),
        color: Color(data["color"] as int),
        budget: (data["budget"] as num?)?.toDouble() ?? 0,
        expense: (data["expense"] as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon.codePoint,
        "color": color.value,
        "budget": budget,
      };

  Future<void> save() async {
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection("categories");
    return await categoriesCollection.doc(id.toString()).set(toJson());
  }
}
