import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leafloom/model/product/product_model.dart';

Future<List<ProductClass>> fetchProducts() async {
  List<ProductClass> productList = [];

  try {
    var productCollectionSnapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    if (productCollectionSnapshot.docChanges.isNotEmpty) {
      productList = productCollectionSnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data();
          return ProductClass.fromJson(data);
        },
      ).toList();
    } else {}
    // ignore: empty_catches
  } catch (e) {}

  return productList;
}
