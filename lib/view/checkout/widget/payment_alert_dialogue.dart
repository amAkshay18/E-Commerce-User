import 'package:flutter/material.dart';
import 'package:leafloom/provider/checkout/checkout_provider.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/home/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class PaymentSuccessAlertDialog extends StatelessWidget {
  const PaymentSuccessAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final alertDialogProvider = Provider.of<AlertDialogProvider>(context);
    return AlertDialog(
      title: const CustomTextWidget(
        'Payment Successful',
        fontSize: 16,
      ),
      content: const CustomTextWidget(
        'Your payment has been successfully processed.',
        fontSize: 16,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            alertDialogProvider.hideAlertDialog();
            // Navigate to another page here
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(); // Replace with the destination page
                },
              ),
            );
          },
          child: const CustomTextWidget(
            'Ok',
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
