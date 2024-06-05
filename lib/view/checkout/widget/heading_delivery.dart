import 'package:flutter/material.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/address/screens/address_screen.dart';

class DeliveryHeading extends StatelessWidget {
  const DeliveryHeading({
    super.key,
    // required this.size,
  });

  // final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white60,
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ScreenAddNewAddress(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    CustomTextWidget(
                      'Click here to add address',
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
