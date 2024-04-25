import 'package:flutter/material.dart';
import 'package:leafloom/model/cart/cart_model.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cartModel.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      cartModel.name!,
                      fontSize: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CustomTextWidget(
                        '₹${cartModel.price}',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const CustomTextWidget(
                          'Quantity',
                          fontSize: 12,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            size: 14,
                          ),
                          onPressed: () {
                            final cart = cartModel;
                            context
                                .read<CartProvider>()
                                .updateQuantity(cart, context, false);
                            context.read<CartProvider>().getCart(context);
                            context.read<CartProvider>().getPrice(
                                context.read<CartProvider>().cartList);
                          },
                        ),
                        Text(
                          cartModel.quantity!,
                          style: TextStyle(
                              color: cartModel.quantity == cartModel.stock
                                  ? Colors.red
                                  : Colors.black),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 14,
                          ),
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
