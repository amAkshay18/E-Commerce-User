import 'package:flutter/material.dart';
import 'package:leafloom/model/order/order_model.dart';
import 'package:leafloom/shared/core/constants.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;
  VoidCallback orderStatus;
  bool isDelivered;
  String buttonName;
  OrderDetailsScreen(
      {super.key,
      required this.order,
      required this.orderStatus,
      required this.isDelivered,
      required this.buttonName});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final String productDelivered = 'Product is delivered';
  int _currentStep = 0;
  Color getStepColor(int stepIndex) {
    if (widget.order.status == 'Pending') {
      return stepIndex == 0 ? Colors.green : Colors.grey;
    } else if (widget.order.status == 'Shipped') {
      return stepIndex <= 1 ? Colors.green : Colors.grey;
    } else if (widget.order.status == 'Delivered') {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          'Order Details',
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                height: size.height / 23,
                decoration: BoxDecoration(border: Border.all(width: 0.1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    'Order ID: OD${widget.order.orderId}',
                    fontSize: 16,
                  ),
                ),
              ),
              kHeight20,
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        CustomTextWidget(
                          ' ${widget.order.productName} ',
                        ),
                        CustomTextWidget(
                          '₹ ${widget.order.totalPrice} ',
                        ),
                        CustomTextWidget(
                          'Category: ${widget.order.category}',
                          fontSize: 16,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const CustomTextWidget(
                              'Status: ',
                              fontSize: 16,
                            ),
                            CustomTextWidget(
                              '${widget.order.status}',
                              fontSize: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      color: Colors.amber,
                      width: size.width / 4,
                      height: size.height / 9,
                      child: Image.network(
                        '${widget.order.imageUrl}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              // TextButton(
              //   onPressed: () {
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(16),
              //             ),
              //             content: const Text(
              //                 'Request will be proceded with in few days'),
              //             actions: [
              //               TextButton(
              //                 onPressed: () {
              //                   Navigator.of(context).pop();
              //                 },
              //                 child: const Text('Ok'),
              //               )
              //             ],
              //           );
              //         });
              //   },
              //   child: Text(widget.buttonName),
              // ),
              Stepper(
                steps: [
                  Step(
                    title: Text(
                      'Order Confirmed,  ${widget.order.date}',
                      style: TextStyle(color: getStepColor(0)),
                    ),
                    content: Text(
                      'Your Order has been placed \n Seller will process your order soon',
                      style: TextStyle(color: getStepColor(0)),
                    ),
                    state: StepState.complete,
                    isActive: true,
                  ),
                  Step(
                    title: Text(
                      'Shipped',
                      style: TextStyle(color: getStepColor(1)),
                    ),
                    content: Text(
                      'Order will be shipped within\n 3 days after the date of order',
                      style: TextStyle(color: getStepColor(1)),
                    ),
                    state: widget.order.status != 'Pending'
                        ? StepState.complete
                        : StepState.disabled,
                    isActive: widget.order.status != 'Pending',
                  ),
                  Step(
                    title: Text(
                      'Delivery',
                      style: TextStyle(color: getStepColor(2)),
                    ),
                    content: Text(
                      'Order is expected to deliver within 10 days after the ordered date',
                      style: TextStyle(color: getStepColor(2)),
                    ),
                    state: widget.order.status == 'Delivered'
                        ? StepState.complete
                        : StepState.disabled,
                    isActive: widget.order.status == 'Delivered',
                  ),
                ],
                onStepTapped: (int newIndex) {
                  setState(() {
                    _currentStep = newIndex;
                  });
                },
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < 2) {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      'Shipping details',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 8),
                    CustomTextWidget(
                      '${widget.order.address!.fullname}',
                      fontSize: 16,
                    ),
                    CustomTextWidget(
                      '${widget.order.address!.house}',
                      fontSize: 16,
                    ),
                    CustomTextWidget(
                      '${widget.order.address!.city}',
                      fontSize: 16,
                    ),
                    CustomTextWidget(
                      '${widget.order.address!.pincode}',
                      fontSize: 16,
                    ),
                    CustomTextWidget(
                      '${widget.order.address!.area}',
                      fontSize: 16,
                    ),
                    CustomTextWidget(
                      '${widget.order.address!.state}',
                      fontSize: 16,
                    ),
                    CustomTextWidget(
                      '${widget.order.address!.phone}',
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
