import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/order.dart';
import 'package:bastah/screens/order_confirmation_screen.dart';
import 'package:bastah/services/auth_service.dart';
import 'package:bastah/services/cart_service.dart';
import 'package:bastah/services/order_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    hide Order; // Fixed import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bastah/l10n/app_localizations_utils.dart'; // Added import

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedPaymentMethod = 'cash'; // Default to Cash on Delivery
  bool _isLoading = false;

  final OrderService _orderService = OrderService();
  final ProductService _productService = ProductService();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final appLocalizations = AppLocalizations.of(context)!;

      try {
        final cartService = Provider.of<CartService>(context, listen: false);
        final user = _authService.getCurrentUser();

        if (user == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authentication error. Please restart the app.')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }

        if (cartService.cartItems.isEmpty) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appLocalizations.emptyCartMessage)),
          );
          return;
        }

        double totalAmount = await cartService.totalAmount;

        List<OrderItem> orderItems = [];
        for (var cartItem in cartService.cartItems) {
          orderItems.add(
            OrderItem(
              productId: cartItem.productId,
              quantity: cartItem.quantity,
              price:
                  (await _productService.getProductById(
                    cartItem.productId,
                  ))?.price ??
                  0.0,
            ),
          );
        }

        final order = Order(
          id: '', // Firestore will generate this
          customerUid: user.uid,
          customerName: _fullNameController.text,
          customerPhone: _phoneNumberController.text,
          customerAddress: _addressController.text,
          items: orderItems,
          totalAmount: totalAmount,
          paymentMethod: _selectedPaymentMethod!,
          status: 'pending',
          createdAt: Timestamp.now(),
        );

        await _orderService.addOrder(order);
        cartService.clearCart();
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OrderConfirmationScreen(),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${appLocalizations.orderPlacementFailed}: $e'),
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.checkoutTitle)),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.customerDetailsTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: appLocalizations.fullNameLabel,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return appLocalizations.fullNameRequiredError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: appLocalizations.phoneNumberLabel,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return appLocalizations.phoneNumberRequiredError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: appLocalizations.addressLabel,
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return appLocalizations.addressRequiredError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    appLocalizations.paymentMethodTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  RadioListTile<String>(
                    title: Text(
                      appLocalizations.translatePaymentMethod('cash'),
                    ),
                    value: 'cash',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(
                      appLocalizations.translatePaymentMethod('online'),
                    ),
                    value: 'online',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  FutureBuilder<double>(
                    future: cartService.totalAmount,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocalizations.totalAmountLabel,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            snapshot.data?.toStringAsFixed(2) ?? '0.00',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _placeOrder,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(appLocalizations.placeOrderButtonText),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withAlpha(128),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
