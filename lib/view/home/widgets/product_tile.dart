import 'package:flutter/material.dart';
import 'package:leafloom/provider/wishlist/wishlist_provider.dart';
import 'package:leafloom/view/product/product_discription.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatefulWidget {
  final String name;
  final String subname;
  final String rate;
  final String image;
  final String description;
  final String id;
  final String stock;
  const ProductTile(
      {Key? key,
      required this.id,
      required this.name,
      required this.subname,
      required this.rate,
      required this.image,
      required this.description,
      required this.stock})
      : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isAddedToWishlist = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishlistProvider>(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDiscription(
              id: widget.id,
              name: widget.name,
              price: widget.rate,
              category: widget.subname,
              discription: widget.description,
              img: widget.image,
              stock: widget.stock,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width / 2.2,
            height: size.height / 4.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: size.width / 3.2,
                  top: 2,
                  child: WishlistIcon(provider: provider, id: widget.id),
                ),
              ],
            ),
          ),
          Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              letterSpacing: .5,
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            widget.subname,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "₹${widget.rate}.00",
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class WishlistIcon extends StatelessWidget {
  const WishlistIcon({
    super.key,
    required this.provider,
    required this.id,
  });

  final WishlistProvider provider;
  final dynamic id;

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(builder: (context, value, _) {
      return IconButton(
        icon: Icon(
          value.wishlistProductIds.contains(id)
              ? Icons.favorite
              : Icons.favorite_border,
          color:
              value.wishlistProductIds.contains(id) ? Colors.red : Colors.black,
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
    });
  }
}
