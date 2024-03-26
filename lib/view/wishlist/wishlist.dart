import 'package:flutter/material.dart';
import 'package:leafloom/model/cart_model.dart';
import 'package:leafloom/model/product_model.dart';
import 'package:leafloom/provider/cart/cart_provider.dart';
import 'package:leafloom/provider/wishlist/wishlist_provider.dart';
import 'package:leafloom/shared/core/constants.dart';
import 'package:leafloom/view/home/widgets/product_tile.dart';
import 'package:leafloom/view/product/product_discription.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<WishlistProvider>().getWishListProducts(context);
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Wishlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: gcolor,
          ),
          child: Consumer<WishlistProvider>(
            builder: (context, value, child) {
              if (value.wishlistProducts.isEmpty) {
                return const Center(
                  child: Text("Your wishlist waiting to be filled"),
                );
              }
              return ListView.builder(
                itemCount: value.wishlistProducts.length,
                itemBuilder: (context, index) {
                  final product = value.wishlistProducts[index];
                  return _buildWishlistCard(context, product, w);
                },
              );
            },
          )),
    );
  }

  Widget _buildWishlistCard(
      BuildContext context, ProductClass product, double w) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDiscription(
                  name: product.name ?? '',
                  price: product.price ?? '0',
                  category: product.category ?? '',
                  discription: product.description ?? "",
                  img: product.imageUrl ?? '',
                  id: product.id ?? '',
                  stock: product.quantity ?? ''),
            ));
      },
      child: WishlitTileWidget(product: product),
    );
  }
}

class WishlitTileWidget extends StatelessWidget {
  const WishlitTileWidget({
    super.key,
    required this.product,
  });
  final ProductClass product;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: w * 0.25,
              height: w * 0.25,
              child: Image.network(
                product.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'name',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '₹ ${product.price ?? '84'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Category: ${product.category ?? '84'} '),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    final addToCart = CartModel(
                      name: product.name,
                      price: product.price,
                      category: product.category,
                      description: product.description,
                      imageUrl: product.imageUrl,
                      id: product.id,
                      quantity: '1',
                      stock: product.quantity,
                    );
                    context.read<CartProvider>().addToCart(
                          context: context,
                          cartModel: addToCart,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item added to cart'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                Consumer<WishlistProvider>(builder: (context, value, _) {
                  return WishlistIcon(provider: value, id: product.id);
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
