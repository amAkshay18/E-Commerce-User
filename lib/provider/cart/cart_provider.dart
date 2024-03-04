import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];

  addQuantityInCart(id, quantity, stock, BuildContext context) async {
    int num = int.parse(quantity);

    if (num >= int.parse(stock)) {
      // Show message indicating maximum stock reached
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum stock limit reached for this product.'),
        ),
      );
      return;
    }

    num++;
    await FirebaseFirestore.instance.collection('Cart').doc(id).update(
      {
        'quantity': num.toString(),
      },
    );
    notifyListeners();
  }

  // addQuantityInCart(id, quantity) async {
  //   int num = int.parse(quantity);
  //   num++;
  //   await FirebaseFirestore.instance.collection('Cart').doc(id).update(
  //     {
  //       'quantity': num.toString(),
  //     },
  //   );
  //   notifyListeners();
  // }

  reduceQuantiyInCart(id, quantity, BuildContext context) async {
    int num = int.parse(quantity);
    num--;

    if (num == 0) {
      // Show confirmation dialog
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
                'Are you sure you want to delete this item from your cart?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Delete'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('Cart')
                      .doc(id)
                      .delete();
                  // ignore: use_build_context_synchronously
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
      // Update the quantity
      await FirebaseFirestore.instance.collection('Cart').doc(id).update(
        {
          'quantity': '$num',
        },
      );
      notifyListeners();
    }
  }

  // reduceQuantiyInCart(id, quantity) async {
  //   int num = int.parse(quantity);
  //   num--;
  //   if (num < 1) {
  //     await FirebaseFirestore.instance.collection('Cart').doc(id).delete();
  //     notifyListeners();
  //   }
  //   await FirebaseFirestore.instance.collection('Cart').doc(id).update(
  //     {
  //       'quantity': '$num',
  //     },
  //   );
  //   notifyListeners();
  // }

  Future<void> addToCart({
    required CartModel value,
    required BuildContext? context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('Cart').doc(value.id).set(
        {
          'name': value.name,
          'price': value.price,
          'quantity': value.quantity,
          'description': value.description,
          'category': value.category,
          'imageUrl': value.imageUrl,
          'id': value.id,
          'stock': value.stock,
        },
      );
      // ignore: use_build_context_synchronously
      showSnackbar(context!, "Product added to Cart");
      notifyListeners();
    } on FirebaseException catch (error) {
      String errorMessage = 'An error occurred while adding the product.';

      if (error.code == 'permission-denied') {
        errorMessage =
            'Permission denied. You do not have the necessary permissions.';
      } else if (error.code == 'not-found') {
        errorMessage = 'The requested document was not found.';
      }

      // ignore: use_build_context_synchronously
      showSnackbar(context!, errorMessage);
      // ignore: avoid_print
      print("Failed to add product: $error");
      notifyListeners();
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackbar(context!, 'An unexpected error occurred. Please try again.');
      // ignore: avoid_print
      print("Failed to add product: $error");
      notifyListeners();
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
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

  Future<void> deleteCart({BuildContext? context, required String id}) async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text('Are sure you want to delete'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Cart')
                    .doc(id)
                    .delete();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                notifyListeners();
              },
            ), //'
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                notifyListeners();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> clearCart(BuildContext context) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Cart').get();
      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Your order has placed successfully');
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Failed to clear cart. Please try again.');
      // ignore: avoid_print
      print('Failed to clear cart: $error');
    }
  }

  // cartClearing() async {
  //   try {
  //     FirebaseFirestore.instance.collection('Cart').doc().
  //     QuerySnapshot querySnapshot = await reference.get();
  //     for (var docsnapshot in querySnapshot.docs) {
  //       await docsnapshot.reference.delete();
  //       // ignore: use_build_context_synchronously
  //       // getcartitems(context);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
