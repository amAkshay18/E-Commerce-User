// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:leafloom/data/cart/cart_serviece.dart';
import 'package:leafloom/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];
  final CartServices cartServices = CartServices();
  int sum = 0;
  int getPrice(List<CartModel> cartItems) {
    sum = 0;
    for (CartModel element in cartItems) {
      int price = int.parse(element.price!);
      int quantity = int.parse(element.quantity!);
      sum += price * quantity;
    }
    return sum;
  }

  getCart(
    BuildContext context,
  ) async {
    final reponse = await cartServices.getCartItems();
    reponse.fold((l) => showSnackbar(context, l), (r) {
      cartList = r;
      notifyListeners();
    });
  }

  addToCart(
      {required BuildContext context, required CartModel cartModel}) async {
    cartServices.addToCart(cartModel, context);
    getCart(context);
  }

  deleteCart({required BuildContext context, required String id}) async {
    cartServices.removeFromCart(id, context);
    getCart(context);
  }

  Future<void> updateQuantity(
      CartModel cartModel, BuildContext context, bool isAdd) async {
    int quantity = int.parse(cartModel.quantity!);
    int stock = int.parse(cartModel.stock!);
    if (isAdd && stock > quantity) {
      await cartServices.updateQuantity(cartModel, isAdd, context);
      notifyListeners();
      getCart(context);
    } else if (!isAdd && quantity > 1) {
      await cartServices.updateQuantity(cartModel, false, context);
      notifyListeners();
      getCart(context);
    } else if (!isAdd && quantity == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
                'Are you sure you want to delete this item from your cart?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Delete'),
                onPressed: () async {
                  deleteCart(context: context, id: cartModel.id!);
                  Navigator.of(context).pop(); // Close the dialog
                  notifyListeners();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      showSnackbar(context, 'Stock limit exceeded');
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 10.0),
      content: Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    notifyListeners();
  }

  Future<void> clearCart(BuildContext context) async {
    cartServices.clearCart(context);
  }
}
