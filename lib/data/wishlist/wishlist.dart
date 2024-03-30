import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:leafloom/model/product/product_model.dart';

class WishListServices {
  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  // getfavoriteIds
  Future<List<dynamic>> getFavoriteIds(String userId) async {
    final favoritesSnapshot =
        await _firebase.collection('users').doc(userId).get();
    final favoriteIds = favoritesSnapshot.data()!['wishlist'] as List;
    return favoriteIds;
  }

  Future<Either<String, String>> addToWishlist(String id) async {
    try {
      _firebase.collection('users').doc(_auth.currentUser!.email).update({
        'wishlist': FieldValue.arrayUnion([id])
      });
      return right('product added to wishlist');
    } on FirebaseAuthException catch (e) {
      return left(e.message.toString());
    }
  }

  Future<Either<String, String>> deleteWishlist(String id) async {
    try {
      await _firebase.collection('users').doc(_auth.currentUser!.email).update({
        'wishlist': FieldValue.arrayRemove([id])
      });
      return right('product removed from wishlist');
    } on FirebaseAuthException catch (e) {
      return left(e.message.toString());
    }
  }

  Future<Either<String, List<ProductClass>>> getWishListProducts() async {
    final document =
        await _firebase.collection('users').doc(_auth.currentUser!.email).get();
    if (document.exists) {
      final itemsIds = document.data()!['wishlist'] as List;
      if (itemsIds.isEmpty) {
        return left("");
      }
      final wishlistProductsQuerySnapshot = await _firebase
          .collection('Products')
          .where('id', whereIn: itemsIds)
          .get();
      final wishlistProducts = wishlistProductsQuerySnapshot.docs
          .map((e) => ProductClass.fromJson(e.data()))
          .toList();
      return right(wishlistProducts);
    } else {
      return left('items not found');
    }
  }
}
