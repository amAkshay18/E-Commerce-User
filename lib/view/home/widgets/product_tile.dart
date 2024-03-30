import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafloom/provider/wishlist/wishlist_provider.dart';
import 'package:leafloom/view/product/product_discription_screen.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String category;
  final String rate;
  final String image;
  final String description;
  final String id;
  final String stock;

  const ProductTile({
    Key? key,
    required this.id,
    required this.name,
    required this.category,
    required this.rate,
    required this.image,
    required this.description,
    required this.stock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishlistProvider>(context);
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDescriptionScreen(
              id: id,
              name: name,
              price: rate,
              category: category,
              description: description,
              image: image,
              stock: stock,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      image,
                      width: size.width / 2.2,
                      height: size.height / 6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  WishlistIcon(provider: provider, id: id),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                "₹$rate.00",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WishlistIcon extends StatelessWidget {
  final WishlistProvider provider;
  final dynamic id;

  const WishlistIcon({
    Key? key,
    required this.provider,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, value, _) {
        return IconButton(
          icon: Icon(
            value.wishlistProductIds.contains(id)
                ? Icons.favorite
                : Icons.favorite_border,
            color: value.wishlistProductIds.contains(id)
                ? Colors.red
                : Colors.black,
            size: 24,
          ),
          onPressed: () async {
            if (value.wishlistProductIds.contains(id)) {
              context
                  .read<WishlistProvider>()
                  .removeWishlistButtonClicked(id, context);
            } else {
              context
                  .read<WishlistProvider>()
                  .addWishlistButtonClicked(id, context);
            }
          },
        );
      },
    );
  }
}
