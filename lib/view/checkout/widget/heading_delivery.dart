import 'package:flutter/material.dart';
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
          Container(
            color: Colors.white60,
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
                  Text(
                    'Click here to add address',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
