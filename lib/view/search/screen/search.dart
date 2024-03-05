import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/model/product_model.dart';
import 'package:leafloom/shared/core/constants.dart';
import 'package:leafloom/view/search/widget/filter_grid.dart';
import 'package:leafloom/view/search/widget/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

//=========================================================
Future<List<ProductClass>> fetchProducts() async {
  List<ProductClass> productList = [];

  try {
    var productCollectionSnapshot =
        await FirebaseFirestore.instance.collection('Products').get();
    if (productCollectionSnapshot.docChanges.isNotEmpty) {
      filteredProducts = productCollectionSnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data();
          return ProductClass.fromJson(data);
        },
      ).toList();
      allItems = filteredProducts;
    } else {
      debugPrint("Error: Product collection snapshot is null");
    }
  } catch (e) {
    debugPrint("Error fetching products===+++++++====: $e");
  }
  productList = filteredProducts;
  return productList;
}

final filterItems = [
  const PopupMenuItem(
    value: 0,
    child: Text('Price Low to High'),
  ),
  const PopupMenuItem(
    value: 1,
    child: Text('Price High to Low'),
  ),
  const PopupMenuItem(
    value: 2,
    child: Text('Remove filter'),
  )
];
final filterItemsPrice = [
  const PopupMenuItem(
    value: 0,
    child: Text('Under 200'),
  ),
  const PopupMenuItem(
    value: 1,
    child: Text('Under 300'),
  ),
  const PopupMenuItem(
    value: 2,
    child: Text('Remove filter'),
  )
];

List<ProductClass> filteredProducts = [];

List<ProductClass> allItems = [];

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    fetchProducts();
    setState(() {});
    super.initState();
  }

  String searchValue = '';

  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  List<ProductClass> productList = [];
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 115,
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(
                            () {
                              searchValue = value;
                            },
                          );
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(
                                () {
                                  searchController.clear();
                                  searchValue = '';
                                },
                              );
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          border: InputBorder.none,
                          labelText: "Search",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PopupMenuButton(
                    itemBuilder: (context) => filterItems,
                    onSelected: (value) async {
                      if (value == 0) {
                        filteredProducts.sort((a, b) =>
                            int.parse(a.price ?? '0')
                                .compareTo(int.parse(b.price ?? '0')));
                        for (int i = 0; i < filteredProducts.length; i++) {
                          // log(filteredProducts[i].price!);
                          // log(filteredProducts.length.toString());
                        }
                        setState(() {});
                      } else if (value == 1) {
                        filteredProducts.sort((a, b) =>
                            int.parse(b.price ?? '0')
                                .compareTo(int.parse(a.price ?? '0')));
                        setState(() {});
                      } else if (value == 2) {
                        filteredProducts = await fetchSearchResults();
                        setState(() {});
                      }
                    },
                    child: const Text('Sort'),
                  ),
                  //====================================
                  PopupMenuButton(
                    itemBuilder: (context) => filterItemsPrice,
                    onSelected: (value) async {
                      if (value == 0) {
                        filteredProducts = await fetchSearchResults();
                        filteredProducts.removeWhere(
                          (element) => double.parse(element.price ?? '0') > 200,
                        );
                        setState(() {});
                      } else if (value == 1) {
                        filteredProducts = await fetchSearchResults();
                        filteredProducts.removeWhere(
                          (element) => double.parse(element.price ?? '0') > 300,
                        );
                        setState(() {});
                      } else if (value == 2) {
                        filteredProducts = await fetchSearchResults();
                        setState(() {});
                      }
                    },
                    child: const Text('Filter'),
                  ),
                ],
              ),
              kHeight30,
              searchValue.isEmpty
                  ? FilterGrid(productCollection: filteredProducts)
                  : FutureBuilder<List<ProductClass>>(
                      future: fetchSearchResults(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<ProductClass>? searchResults = snapshot.data;
                          // filteredProducts = snapshot.data ?? [];
                          return searchResults != null &&
                                  searchResults.isNotEmpty
                              ? SearchCard(searchResults: filteredProducts)
                              : emptySearch();
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ProductClass>> fetchSearchResults() async {
    try {
      var querySnapshot = await productCollection
          .where('searchName',
              isGreaterThanOrEqualTo: searchValue.trim().toLowerCase())
          .where('searchName',
              isLessThanOrEqualTo: '${searchValue.toLowerCase()}\uf8ff')
          .get();

      return querySnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return ProductClass.fromJson(data);
        },
      ).toList();
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching search results: $e");
      return [];
    }
  }
}

emptySearch() {
  return const SizedBox(
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not found',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF9C9C9C),
            ),
          )
        ],
      ),
    ),
  );
}
