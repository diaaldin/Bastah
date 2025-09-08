import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/product.dart'; // cart_item.dart removed
import 'package:bastah/screens/checkout_screen.dart';
import 'package:bastah/services/cart_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.cartTitle)),
      body: cartService.cartItems.isEmpty
          ? Center(child: Text(appLocalizations.emptyCartMessage))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartService.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartService.cartItems[index];
                      return FutureBuilder<Product?>(
                        future: _productService.getProductById(
                          cartItem.productId,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError ||
                              !snapshot.hasData ||
                              snapshot.data == null) {
                            return Center(
                              child: Text(appLocalizations.somethingWentWrong),
                            );
                          }

                          final product = snapshot.data!;
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              leading: product.images.isNotEmpty
                                  ? Image.network(
                                      product.images.first,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.image_not_supported),
                              title: Text(
                                product.name[Localizations.localeOf(
                                      context,
                                    ).languageCode] ??
                                    product.name['en'] ??
                                    '',
                              ),
                              subtitle: Text(
                                '${appLocalizations.priceLabel}: ${product.price.toStringAsFixed(2)}',
                              ), // Fixed here
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      cartService.updateCartItemQuantity(
                                        cartItem.productId,
                                        cartItem.quantity - 1,
                                      );
                                    },
                                  ),
                                  Text(cartItem.quantity.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cartService.updateCartItemQuantity(
                                        cartItem.productId,
                                        cartItem.quantity + 1,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      cartService.removeFromCart(
                                        cartItem.productId,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations.totalAmountLabel,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FutureBuilder<double>(
                            future: cartService.totalAmount,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              return Text(
                                snapshot.data?.toStringAsFixed(2) ?? '0.00',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ), // Make button full width
                        ),
                        child: Text(appLocalizations.checkoutButtonText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
