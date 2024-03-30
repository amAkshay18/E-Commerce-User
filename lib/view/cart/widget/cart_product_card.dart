import 'package:flutter/material.dart';
import 'package:leafloom/model/cart/cart_model.dart';
import 'package:provider/provider.dart';
import '../../../provider/cart/cart_provider.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    super.key,
    required this.cartModel,
  });
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  cartModel.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartModel.name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '₹ ${cartModel.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text('Quantity'),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            final cart = cartModel;
                            context
                                .read<CartProvider>()
                                .updateQuantity(cart, context, false);
                            context.read<CartProvider>().getCart(context);
                            context.read<CartProvider>().getPrice(
                                context.read<CartProvider>().cartList);
                          },
                          color: cartModel.quantity == '1'
                              ? Colors.red
                              : Colors.black,
                        ),
                        Text(
                          cartModel.quantity!,
                          style: TextStyle(
                              color: cartModel.quantity == cartModel.stock
                                  ? Colors.red
                                  : Colors.black),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () async {
                            final cart = cartModel;
                            context
                                .read<CartProvider>()
                                .updateQuantity(cart, context, true);
                            context.read<CartProvider>().getCart(context);
                            context.read<CartProvider>().getPrice(
                                context.read<CartProvider>().cartList);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Remove from cart'),
                      content: const Text('Are you sure want to cart'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              context.read<CartProvider>().deleteCart(
                                  context: context, id: cartModel.id!);
                              context.read<CartProvider>().getCart(context);
                              context.read<CartProvider>().getPrice(
                                  context.read<CartProvider>().cartList);
                              Navigator.pop(context);
                            },
                            child: const Text("Remove")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
