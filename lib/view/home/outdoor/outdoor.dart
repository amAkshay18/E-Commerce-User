import 'package:flutter/material.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/search/widget/search_card.dart';
import 'package:provider/provider.dart';
import '../../../provider/indoor_outdoor/indoor_outdoor_provider.dart';

class OutdoorScreen extends StatelessWidget {
  const OutdoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryProvider>().fetchProducts();
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget('Outdoor plants'),
        centerTitle: true,
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, widget) {
          final outdoorlist = provider.outdoorProducts;
          return ListView(
            children: [
              SearchCard(
                searchResults: outdoorlist,
              ),
            ],
          );
        },
      ),
    );
  }
}
