import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/category.dart';
import 'package:bastah/models/product.dart';
import 'package:bastah/screens/cart_screen.dart';
import 'package:bastah/screens/order_tracking_screen.dart';
import 'package:bastah/screens/settings_screen.dart';
import 'package:bastah/services/cart_service.dart';
import 'package:bastah/services/category_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final _productService = ProductService();
  final _categoryService = CategoryService();
  final _cartService = CartService();

  String? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.customerHomeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.track_changes),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderTrackingScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          StreamBuilder<List<Category>>(
            stream: _categoryService.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(appLocalizations.somethingWentWrong));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Category> categories = snapshot.data ?? [];
              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1, // +1 for "All Categories"
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(appLocalizations.allCategories),
                          selected: _selectedCategoryId == null,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategoryId = null;
                            });
                          },
                        ),
                      );
                    }
                    Category category = categories[index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        avatar: category.imageUrl.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(category.imageUrl),
                              )
                            : null,
                        label: Text(category.name[Localizations.localeOf(context).languageCode] ?? category.name['en'] ?? ''),
                        selected: _selectedCategoryId == category.id,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategoryId = category.id;
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Product Grid
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: _selectedCategoryId == null
                  ? _productService.getProducts()
                  : _productService.getProducts().map((products) => products
                      .where((product) => product.categoryId == _selectedCategoryId)
                      .toList()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(appLocalizations.somethingWentWrong));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = snapshot.data!;

                if (products.isEmpty) {
                  return Center(child: Text(appLocalizations.noProductsAvailable));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.7, // Adjust as needed
                  ),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: product.images.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                                    child: Image.network(
                                      product.images.first,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name[Localizations.localeOf(context).languageCode] ?? product.name['en'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${appLocalizations.priceLabel}: ${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _cartService.addToCart(product.id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(appLocalizations.productAddedToCart(product.name[Localizations.localeOf(context).languageCode] ?? product.name['en'] ?? '')),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: Text(appLocalizations.addToCartButtonText),
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
          ),
        ],
      ),
    );
  }
}