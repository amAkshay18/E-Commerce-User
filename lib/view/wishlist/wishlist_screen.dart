import 'package:flutter/material.dart';
import 'package:leafloom/model/cart/cart_model.dart';
import 'package:leafloom/model/product/product_model.dart';
import 'package:leafloom/provider/cart/cart_provider.dart';
import 'package:leafloom/provider/wishlist/wishlist_provider.dart';
import 'package:leafloom/shared/core/constants.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/home/widgets/product_tile.dart';
import 'package:leafloom/view/product/product_discription_screen.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WishlistProvider>().getWishListProducts(context);
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomTextWidget(
          'My Wishlist',
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
                child:
                    CustomTextWidget("Your wishlist is waiting to be filled"),
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
        ),
      ),
    );
  }

  Widget _buildWishlistCard(
      BuildContext context, ProductClass product, double w) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDescriptionScreen(
              name: product.name ?? '',
              price: product.price ?? '0',
              category: product.category ?? '',
              description: product.description ?? "",
              image: product.imageUrl ?? '',
              id: product.id ?? '',
              stock: product.quantity ?? '',
            ),
          ),
        );
      },
      child: WishlitTileWidget(product: product),
    );
  }
}

class WishlitTileWidget extends StatelessWidget {
  const WishlitTileWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductClass product;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: w * 0.25,
              height: w * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  product.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    product.name ?? 'name',
                    maxLines: 1,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 8),
                  CustomTextWidget(
                    '₹${product.price ?? '84'}',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  CustomTextWidget(
                    'Category: ${product.category ?? 'Unknown'}',
                    fontSize: 12,
                    color: Colors.grey,
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
