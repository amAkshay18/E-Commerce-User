import 'package:flutter/material.dart';
import 'package:leafloom/model/cart/cart_model.dart';
import 'package:leafloom/provider/cart/cart_provider.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/checkout/screens/checkout_screen.dart';
import 'package:provider/provider.dart';

class ProductDescriptionScreen extends StatelessWidget {
  const ProductDescriptionScreen({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.id,
    required this.stock,
  });
  final String name;
  final String price;
  final String category;
  final String description;
  final String image;
  final String id;
  final String stock;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextWidget(
            name,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildProductImage(context),
              _buildDescription(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomButtons(context),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16.0),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    name,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  CustomTextWidget(
                    "₹$price",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextWidget(
                    "Description",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  CustomTextWidget(
                    "Category: $category",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              final addToCart = CartModel(
                name: name,
                price: price,
                category: category,
                description: description,
                imageUrl: image,
                id: id,
                quantity: '1',
                stock: stock,
              );
              context
                  .read<CartProvider>()
                  .addToCart(context: context, cartModel: addToCart);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item added to cart'),
                  duration: Duration(
                    seconds: 1,
                  ),
                ),
              );
            },
            child: const CustomTextWidget(
              'Add to Cart',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(
                    products: [
                      CartModel(
                        category: category,
                        id: id,
                        description: description,
                        imageUrl: image,
                        name: name,
                        price: price,
                        quantity: '1',
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const CustomTextWidget(
              'Buy Now',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
