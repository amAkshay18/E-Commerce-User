import 'package:flutter/material.dart';
import 'package:leafloom/model/cart/cart_model.dart';
import 'package:leafloom/provider/cart/cart_provider.dart';
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
        appBar: _buildAppBar(),
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

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        name,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Container _buildProductImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
    );
  }

  Padding _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "₹$price",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                "Category :$category",
                style: const TextStyle(
                    color: Color.fromARGB(255, 133, 133, 133), fontSize: 20),
              )
            ],
          ),
          Text(description, textAlign: TextAlign.justify),
        ],
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
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
                  builder: (context) => CheckoutScreen(products: [
                    CartModel(
                      category: category,
                      id: id,
                      description: description,
                      imageUrl: image,
                      name: name,
                      price: price,
                      quantity: '1',
                    )
                  ]),
                ),
              );
            },
            child: const Text(
              'Buy Now',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
