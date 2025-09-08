import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/order.dart';
import 'package:bastah/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:bastah/l10n/app_localizations_utils.dart'; // Added import

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final OrderService _orderService = OrderService();

  void _showUpdateStatusDialog(Order order) {
    final appLocalizations = AppLocalizations.of(context)!;
    String? selectedStatus = order.status;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(appLocalizations.updateOrderStatusTitle),
          content: DropdownButtonFormField<String>(
            initialValue: selectedStatus, // Fixed here
            decoration: InputDecoration(labelText: appLocalizations.orderStatusLabel),
            items: <String>['pending', 'processing', 'shipped', 'delivered']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(appLocalizations.translateOrderStatus(value)), // Uses extension
              );
            }).toList(), // .toList() added back here
            onChanged: (String? newValue) {
              selectedStatus = newValue;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(appLocalizations.cancelButtonText),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedStatus != null) {
                  await _orderService.updateOrderStatus(order.id, selectedStatus!);
                }
                if (!mounted) return; // Added mounted check
                Navigator.pop(context);
              },
              child: Text(appLocalizations.saveButtonText),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.orderManagementTitle),
      ),
      body: StreamBuilder<List<Order>>(
        stream: _orderService.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Order> orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return Center(child: Text(appLocalizations.noOrdersFound));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  title: Text('${appLocalizations.orderIdLabel}: ${order.id}'),
                  subtitle: Text(
                      '${appLocalizations.customerNameLabel}: ${order.customerName}\n'
                      '${appLocalizations.totalAmountLabel}: \$${order.totalAmount.toStringAsFixed(2)}\n'
                      '${appLocalizations.orderStatusLabel}: ${appLocalizations.translateOrderStatus(order.status)}' // Uses extension
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${appLocalizations.customerPhoneLabel}: ${order.customerPhone}'),
                          Text('${appLocalizations.customerAddressLabel}: ${order.customerAddress}'),
                          Text('${appLocalizations.paymentMethodLabel}: ${appLocalizations.translatePaymentMethod(order.paymentMethod)}'), // Uses extension
                          Text('${appLocalizations.createdAtLabel}: ${order.createdAt.toDate().toLocal().toString().split('.').first}'),
                          const SizedBox(height: 10),
                          Text(appLocalizations.orderItemsLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ...order.items.map((item) => Text(
                              '- ${appLocalizations.productIdLabel}: ${item.productId}, ${appLocalizations.quantityLabel}: ${item.quantity}, ${appLocalizations.priceLabel}: \$${item.price.toStringAsFixed(2)}'
                          )), // .toList() removed here
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () => _showUpdateStatusDialog(order),
                              child: Text(appLocalizations.updateStatusButtonText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
