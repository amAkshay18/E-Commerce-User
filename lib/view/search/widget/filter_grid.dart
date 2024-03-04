import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/model/product_model.dart';
import 'package:leafloom/view/home/widgets/product_tile.dart';

class FilterGrid extends StatelessWidget {
  const FilterGrid({
    Key? key,
    required this.productCollection,
  }) : super(key: key);

  final List<ProductClass?> productCollection;

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
      } else {
        debugPrint("Error: Product collection snapshot is null");
      }
    } catch (e) {
      debugPrint("Error fetching products===+++++++====: $e");
    }

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3.0 / 4.0,
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: productCollection.length,
      itemBuilder: (context, index) {
        return ProductTile(
          id: productCollection[index]!.id.toString(),
          name: productCollection[index]!.name ?? 'Empty',
          subname: productCollection[index]!.category ?? 'Empty',
          rate: productCollection[index]!.price ?? 'Empty',
          image: productCollection[index]!.imageUrl ??
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9k33VDGg4WcrLISmAosSXtH9LnRke9pcaBQ&usqp=CAU",
          description: productCollection[index]!.description ?? "empty",
          stock: productCollection[index]!.quantity ?? 'Empty',
        );
      },
    );
  }
}

class ProductTileShimmer extends StatelessWidget {
  const ProductTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[300],
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[300],
              height: 16.0,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[300],
              height: 16.0,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[300],
              height: 16.0,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
