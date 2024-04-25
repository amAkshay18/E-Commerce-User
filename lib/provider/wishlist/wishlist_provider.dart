// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/data/wishlist/wishlist.dart';
import 'package:leafloom/model/product/product_model.dart';

class WishlistProvider extends ChangeNotifier {
  bool isAddedToWishlist = false;
  List<ProductClass> wishlistProducts = [];
  List<dynamic> wishlistProductIds = [];

  Future<void> initFavorites(BuildContext context) async {
    wishlistProductIds = await _services
        .getFavoriteIds(FirebaseAuth.instance.currentUser!.email!);
    getWishListProducts(context);
  }

  void addWishlistButtonClicked(String productId, BuildContext context) async {
    if (!wishlistProductIds.contains(productId)) {
      wishlistProductIds.add(productId);
      notifyListeners();
      addToWishlist(id: productId, context: context);
    }
  }

  void removeWishlistButtonClicked(String productId, BuildContext context) {
    if (wishlistProductIds.contains(productId)) {
      wishlistProductIds.remove(productId);
      deleteWishlist(id: productId, context: context);
    }
  }

  final WishListServices _services = WishListServices();
  Future<void> addToWishlist(
      {required String id, required BuildContext context}) async {
    final response = await _services.addToWishlist(id);
    response.fold((l) => showSnackbar(context, l), (r) {
      showSnackbar(context, r);
      notifyListeners();
    });
  }

// snackbar for product added to wishlist
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10, top: 10),
      content: Text(message),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    notifyListeners();
  }

  deleteWishlist({required String id, required BuildContext context}) async {
    final response = await _services.deleteWishlist(id);
    response.fold(
        (l) => showSnackbar(context, l), (r) => showSnackbar(context, r));
    if (wishlistProducts.length == 1) {
      wishlistProducts.clear();
      notifyListeners();
      return;
    }
    getWishListProducts(context);
  }

  getWishListProducts(BuildContext context) async {
    initFavorites(context);
    final response = await _services.getWishListProducts();
    response.fold((l) {
      if (l.isEmpty) return;
      showSnackbar(context, l);
    }, (r) {
      wishlistProducts = r;
      notifyListeners();
    });
  }
}
