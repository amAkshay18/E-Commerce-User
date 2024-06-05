import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafloom/model/order/order_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MMM-yyyy');
    final dateParsed = DateFormat('dd-MM-yyyy').parse(order.date ?? '');

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 70.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(order.imageUrl ?? ''),
                ),
              ),
            ),
          ),
          title: Text(
            order.productName ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              // Text('Date: ${order.date ?? ''}'),
              Text('Date: ${dateFormat.format(dateParsed)}'),
              Text('Status: ${order.status ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
