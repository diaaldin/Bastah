import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/order.dart';
import 'package:bastah/models/product.dart';
import 'package:bastah/services/order_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:bastah/l10n/app_localizations_utils.dart';
import 'package:intl/intl.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final OrderService orderService = OrderService();
    final ProductService productService = ProductService();

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.orderTrackingTitle)),
      body: StreamBuilder<List<Order>>(
        stream: orderService.getOrders(),
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
              final formattedDate = DateFormat.yMMMd().add_jm().format(
                order.createdAt.toDate(),
              );

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  title: Text(
                    '${appLocalizations.orderPlacedLabel}: $formattedDate',
                  ),
                  subtitle: Text(
                    '${appLocalizations.totalAmountLabel}: \$${order.totalAmount.toStringAsFixed(2)}\n' // Note: The dollar sign here is escaped correctly for Dart string literals.
                    '${appLocalizations.orderStatusLabel}: ${appLocalizations.translateOrderStatus(order.status)}\n',
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${appLocalizations.customerNameLabel}: ${order.customerName}',
                          ),
                          Text(
                            '${appLocalizations.customerPhoneLabel}: ${order.customerPhone}',
                          ),
                          Text(
                            '${appLocalizations.customerAddressLabel}: ${order.customerAddress}',
                          ),
                          Text(
                            '${appLocalizations.paymentMethodLabel}: ${appLocalizations.translatePaymentMethod(order.paymentMethod)}',
                          ),
                          const SizedBox(height: 16),
                          Text(
                            appLocalizations.orderItemsLabel,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...order.items.map(
                            (item) => FutureBuilder<Product?>(
                              future: productService.getProductById(
                                item.productId,
                              ),
                              builder: (context, productSnapshot) {
                                if (productSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                    child: Text('  - Loading item...'),
                                  );
                                }

                                final productName =
                                    productSnapshot.data?.getLocalizedName(
                                      appLocalizations,
                                    ) ??
                                    appLocalizations.unknownProduct;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    '  - $productName (${appLocalizations.quantityLabel}: ${item.quantity})',
                                  ),
                                );
                              },
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
