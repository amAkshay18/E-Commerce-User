import 'package:flutter/material.dart';
import 'package:leafloom/model/product_model.dart';
import 'package:leafloom/view/product/product_discription.dart';
import 'package:leafloom/view/wishlist/wishlist.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    this.searchResults,
  });

  final List<ProductClass>? searchResults;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchResults!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDiscription(
                  category: searchResults![index].category ?? "outdoor",
                  discription:
                      searchResults![index].description ?? "description",
                  id: searchResults![index].id ?? "null",
                  img: searchResults![index].imageUrl ?? 'null',
                  name: searchResults![index].name ?? "name",
                  price: searchResults![index].price ?? "null",
                  stock: searchResults![index].quantity ?? "null",
                ),
              ),
            );
          },
          child: WishlitTileWidget(
            product: ProductClass(
              category: searchResults![index].category ?? "outdoor",
              description: searchResults![index].description ?? "description",
              id: searchResults![index].id ?? "null",
              imageUrl: searchResults![index].imageUrl ?? "null",
              name: searchResults![index].name ?? "null",
              price: searchResults![index].price ?? "null",
              quantity: searchResults![index].quantity ?? "null",
            ),
          ),
        );
      },
    );
  }
}
