import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/order.dart';
import 'package:bastah/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:bastah/l10n/app_localizations_utils.dart'; // Added import

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final OrderService orderService = OrderService(); // Renamed _orderService

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.orderTrackingTitle)),
      body: StreamBuilder<List<Order>>(
        stream: orderService.getOrders(), // Using renamed orderService
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${appLocalizations.somethingWentWrong}: ${snapshot.error}',
              ),
            );
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
                    '${appLocalizations.totalAmountLabel}: \$${order.totalAmount.toString()}\n'
                    '${appLocalizations.orderStatusLabel}: ${appLocalizations.translateOrderStatus(order.status)}',
                  ),

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${appLocalizations.customerNameLabel}: ${order.customerName}',
                          ), // Fixed hardcoded string
                          Text(
                            '${appLocalizations.customerPhoneLabel}: ${order.customerPhone}',
                          ), // Fixed hardcoded string
                          Text(
                            '${appLocalizations.customerAddressLabel}: ${order.customerAddress}',
                          ), // Fixed hardcoded string
                          Text(
                            '${appLocalizations.paymentMethodLabel}: ${appLocalizations.translatePaymentMethod(order.paymentMethod)}',
                          ),
                          Text(
                            '${appLocalizations.createdAtLabel}: ${order.createdAt.toDate().toLocal().toString().split('.').first}',
                          ),
                          const SizedBox(height: 10),
                          Text(
                            appLocalizations.orderItemsLabel,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ), // Fixed hardcoded string
                          ...order.items.map(
                            (item) => Text(
                              '- ${appLocalizations.productIdLabel}: ${item.productId}, ${appLocalizations.quantityLabel}: ${item.quantity}, ${appLocalizations.priceLabel}: \$${item.price.toString()}',
                            ),
                          ), // .toList() removed here
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
