import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/model/order_model.dart';
import 'package:leafloom/provider/address/address_provider.dart';
import 'package:leafloom/provider/checkout_provider/checkout_provider.dart';
import 'package:leafloom/shared/common_widget/common_button.dart';
import 'package:leafloom/shared/core/constants.dart';
import 'package:leafloom/view/checkout_page/widget/card_checkout.dart';
import 'package:leafloom/view/checkout_page/widget/heading_delivery.dart';
import 'package:leafloom/view/profile/screens/address/dafault_card.dart';
import 'package:leafloom/view/profile/screens/address/main_address_screen.dart';

import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Razorpay razorpay = Razorpay();

// ignore: must_be_immutable
class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({
    super.key,
    required this.category,
    required this.name,
    required this.price,
    required this.discription,
    required this.image,
    required this.id,
  });
  final String category;
  final String id;
  final String name;
  final String price;
  final String discription;
  final String image;
  final String _uniqueFileName =
      DateTime.now().millisecondsSinceEpoch.toString();
  DateTime currentDate = DateTime.now();
  String date = '0';
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${currentDate.day}-${currentDate.month}-${currentDate.year}";
    date = formattedDate;

    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final razorpayProvider = Provider.of<RazorpayProvider>(context);

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<CheckoutProvider>(
            builder: (context, value, widget) {
              int totalPrice = value.calulateTotal(price);
              return Column(
                children: [
                  kHeight20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: size.height / 8,
                      child: DeliveryHeading(size: size),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 9,
                      right: 9,
                    ),
                    child: DefaultAddress(size: size),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenAddress(),
                        ),
                      );
                      context
                          .read<AddressProvider>()
                          .showSnackbar(context, 'Change address default');
                    },
                    child: const Text('Change Address'),
                  ),
                  kHeight20,
                  CheckoutCard(
                      image: image,
                      name: name,
                      price: price,
                      checkoutProvider: checkoutProvider,
                      totalPrice: totalPrice),
                  kHeight20,
                  ListTile(
                    leading: Radio<PaymentCategory>(
                      groupValue: checkoutProvider.paymentCategory,
                      value: PaymentCategory.paynow,
                      onChanged: (PaymentCategory? value) {
                        checkoutProvider.setPaymentCategory(value!);
                      },
                    ),
                    title: const Text('Pay Now'),
                  ),
                  ListTile(
                    leading: Radio<PaymentCategory>(
                      groupValue: checkoutProvider.paymentCategory,
                      value: PaymentCategory.cashondelivery,
                      onChanged: (PaymentCategory? value) {
                        checkoutProvider.setPaymentCategory(value!);
                      },
                    ),
                    title: const Text('Cash on delivery'),
                  ),
                  kHeight50,
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 12,
                    child: CommonButton(
                      name: "Confirm order",
                      voidCallback: () async {
                        if (checkoutProvider.paymentCategory ==
                            PaymentCategory.paynow) {
                          final user = FirebaseAuth.instance.currentUser;
                          var options = {
                            'key': 'rzp_test_EunImdr5xuJGFC',
                            'amount': totalPrice * 100,
                            'name': 'LeafLoom',
                            'description': name,
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '9605298500',
                              'email': user!.email
                            },
                            'external': {
                              'wallets': ['paytm']
                            }
                          };
                          razorpayProvider.openRazorpayPayment(
                            options: options,
                            onError: (response) {
                              handlePaymentErrorResponse(response, context);
                            },
                            onSuccess: (response) {
                              handlePaymentSuccessResponse(response, context);
                            },
                          );
                        } else {
                          final obj = OrderModel(
                            orderId: _uniqueFileName.toString(),
                            status: 'Pending',
                            quantity: checkoutProvider.totalNum.toString(),
                            id: id,
                            description: discription,
                            category: category,
                            imageUrl: image,
                            productName: name,
                            totalPrice: price,
                            date: formattedDate,
                          );
                          await context
                              .read<ProductPayment>()
                              .confirm(value: obj, context: context);
                          // ignore: use_build_context_synchronously
                          value.showPaymentCompletedDialog(context);
                        }
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(
      PaymentFailureResponse response, BuildContext context) {
    showAlertDialog(
        context, "Payment Failed", "\nDescription: ${response.message}}");
  }

  void handlePaymentSuccessResponse(
      PaymentSuccessResponse response, BuildContext context) {
    String idOrder = response.orderId.toString();
    String paymentId = response.paymentId.toString();
    // ignore: avoid_print
    print('Response:=================  $response');
    // ignore: avoid_print
    print('Response:=================  $idOrder');
    context.read<ProductPayment>().orderId = paymentId;

    final obj = OrderModel(
      orderId: _uniqueFileName,
      status: 'Pending',
      quantity: context.read<CheckoutProvider>().totalNum.toString(),
      id: id,
      description: discription,
      category: category,
      imageUrl: image,
      productName: name,
      totalPrice: price,
      date: date,
    );
    context.read<ProductPayment>().confirm(value: obj, context: context);

    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(
      ExternalWalletResponse response, BuildContext context) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
