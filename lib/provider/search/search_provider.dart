import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/model/product/product_model.dart';

class SearchProvider extends ChangeNotifier {
  String? value;
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('Products');
  List<ProductClass> searchedProducts = [];
  Future<List<ProductClass>> getProductsByPriceRange() async {
    QuerySnapshot querySnapshot = await _productsCollection
        .orderBy(
          'price',
        )
        .get();
    List<ProductClass> productList = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      productList
          .add(ProductClass.fromJson(doc.data() as Map<String, dynamic>));
    }
    return productList;
  }

  searchProduct(String searchQuery) async {
    final querySnapshort = await _productsCollection.get();
    final products = querySnapshort.docs
        .map((e) => ProductClass.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    final a = products
        .where((element) =>
            element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    searchedProducts = a;
    notifyListeners();
  }
}
