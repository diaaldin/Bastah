import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/order.dart';
import 'package:bastah/models/product.dart';
import 'package:bastah/services/product_service.dart';
import 'package:bastah/models/product.dart';
import 'package:bastah/services/order_service.dart';
import 'package:bastah/services/product_service.dart';
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
            initialValue: selectedStatus,
            decoration: InputDecoration(
              labelText: appLocalizations.orderStatusLabel,
            ),
            items: <String>['pending', 'processing', 'shipped', 'delivered']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(appLocalizations.translateOrderStatus(value)),
                  );
                })
                .toList(),
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
                  await _orderService.updateOrderStatus(
                    order.id,
                    selectedStatus!,
                  );
                }
                if (!mounted) return;
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
      appBar: AppBar(title: Text(appLocalizations.orderManagementTitle)),
      body: StreamBuilder<List<Order>>(
        stream: _orderService.getAllOrders(),
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
                    '${appLocalizations.orderStatusLabel}: ${appLocalizations.translateOrderStatus(order.status)}',
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${appLocalizations.customerPhoneLabel}: ${order.customerPhone}',
                          ),
                          Text(
                            '${appLocalizations.customerAddressLabel}: ${order.customerAddress}',
                          ),
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
                          ),
                          ...order.items.map(
                            (item) => _OrderItemRow(item: item),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () => _showUpdateStatusDialog(order),
                              child: Text(
                                appLocalizations.updateStatusButtonText,
                              ),
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

class _OrderItemRow extends StatefulWidget {
  final OrderItem item;

  const _OrderItemRow({required this.item});

  @override
  State<_OrderItemRow> createState() => _OrderItemRowState();
}

class _OrderItemRowState extends State<_OrderItemRow> {
  final ProductService _productService = ProductService();
  late Future<Product?> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _productService.getProductById(widget.item.productId);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return FutureBuilder<Product?>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: LinearProgressIndicator(),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Text(
            '- ${appLocalizations.productIdLabel}: ${widget.item.productId} (Product not found)',
          );
        }

        final product = snapshot.data!;
        final productName =
            product.name[locale] ?? product.name['en'] ?? 'Unnamed Product';

        return Text(
          '- $productName, ${appLocalizations.quantityLabel}: ${widget.item.quantity}, ${appLocalizations.priceLabel}: \$${widget.item.price.toStringAsFixed(2)}',
        );
      },
    );
  }
}
