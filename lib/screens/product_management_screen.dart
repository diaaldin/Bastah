import 'dart:io';

import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/category.dart';
import 'package:bastah/models/product.dart';
import 'package:bastah/services/category_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _productNameEnController =
      TextEditingController();
  final TextEditingController _productNameArController =
      TextEditingController();
  final TextEditingController _productNameHeController =
      TextEditingController();
  final TextEditingController _productDescEnController =
      TextEditingController();
  final TextEditingController _productDescArController =
      TextEditingController();
  final TextEditingController _productDescHeController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();

  Product? _editingProduct;
  List<File> _selectedImages = [];
  late String? _selectedCategoryId; // Changed to late String?

  @override
  void dispose() {
    _productNameEnController.dispose();
    _productNameArController.dispose();
    _productNameHeController.dispose();
    _productDescEnController.dispose();
    _productDescArController.dispose();
    _productDescHeController.dispose();
    _productPriceController.dispose();
    _productStockController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages = images.map((xfile) => File(xfile.path)).toList();
      });
    }
  }

  void _showProductDialog({Product? product}) {
    _editingProduct = product;
    _selectedImages = []; // Clear previously selected images

    if (product != null) {
      _productNameEnController.text = product.name['en'] ?? '';
      _productNameArController.text = product.name['ar'] ?? '';
      _productNameHeController.text = product.name['he'] ?? '';
      _productDescEnController.text = product.description['en'] ?? '';
      _productDescArController.text = product.description['ar'] ?? '';
      _productDescHeController.text = product.description['he'] ?? '';
      _productPriceController.text = product.price.toString();
      _productStockController.text = product.stock.toString();
      _selectedCategoryId = product.categoryId;
    } else {
      _productNameEnController.clear();
      _productNameArController.clear();
      _productNameHeController.clear();
      _productDescEnController.clear();
      _productDescArController.clear();
      _productDescHeController.clear();
      _productPriceController.clear();
      _productStockController.clear();
      _selectedCategoryId = null; // Ensure it's null for new products
    }

    showDialog(
      context: context,
      builder: (context) {
        final appLocalizations = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(
            product == null
                ? appLocalizations.addProductTitle
                : appLocalizations.editProductTitle,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _productNameEnController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productNameEnLabel,
                  ),
                ),
                TextField(
                  controller: _productNameArController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productNameArLabel,
                  ),
                ),
                TextField(
                  controller: _productNameHeController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productNameHeLabel,
                  ),
                ),
                TextField(
                  controller: _productDescEnController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productDescriptionEnLabel,
                  ),
                ),
                TextField(
                  controller: _productDescArController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productDescriptionArLabel,
                  ),
                ),
                TextField(
                  controller: _productDescHeController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productDescriptionHeLabel,
                  ),
                ),
                TextField(
                  controller: _productPriceController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productPriceLabel,
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _productStockController,
                  decoration: InputDecoration(
                    labelText: appLocalizations.productStockLabel,
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<Category>>(
                  stream: _categoryService.getCategories(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    List<Category> categories = snapshot.data ?? [];
                    return DropdownButtonFormField<String>(
                      initialValue: _selectedCategoryId, // Fixed here
                      hint: Text(appLocalizations.selectCategoryHint),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategoryId = newValue;
                        });
                      },
                      items: categories.map<DropdownMenuItem<String>>((
                        Category category,
                      ) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(
                            category.name[Localizations.localeOf(
                                  context,
                                ).languageCode] ??
                                category.name['en'] ??
                                '',
                          ),
                        );
                      }).toList(), // .toList() added back here
                    );
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text(appLocalizations.pickImagesButtonText),
                ),
                if (_selectedImages.isNotEmpty)
                  Text(
                    appLocalizations.imagesSelectedText(_selectedImages.length),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(appLocalizations.cancelButtonText),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = {
                  'en': _productNameEnController.text,
                  'ar': _productNameArController.text,
                  'he': _productNameHeController.text,
                };
                final description = {
                  'en': _productDescEnController.text,
                  'ar': _productDescArController.text,
                  'he': _productDescHeController.text,
                };
                final price =
                    double.tryParse(_productPriceController.text) ?? 0.0;
                final stock = int.tryParse(_productStockController.text) ?? 0;

                if (_selectedCategoryId == null) {
                  // Handle case where category is not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(appLocalizations.selectCategoryHint),
                    ),
                  );
                  return;
                }

                if (_editingProduct == null) {
                  // Add new product
                  Product newProduct = Product(
                    id: '',
                    categoryId: _selectedCategoryId!,
                    name: name,
                    description: description,
                    price: price,
                    stock: stock,
                    images: [], // Images will be uploaded separately
                  );
                  await _productService.addProduct(newProduct, _selectedImages);
                } else {
                  // Update existing product
                  Product updatedProduct = Product(
                    id: _editingProduct!.id,
                    categoryId: _selectedCategoryId!,
                    name: name,
                    description: description,
                    price: price,
                    stock: stock,
                    images: _editingProduct!.images, // Keep existing images
                  );
                  await _productService.updateProduct(
                    updatedProduct,
                    newImageFiles: _selectedImages,
                  );
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

  void _deleteProduct(String productId) async {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(appLocalizations.deleteProductConfirmationTitle),
          content: Text(appLocalizations.deleteProductConfirmationMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(appLocalizations.cancelButtonText),
            ),
            ElevatedButton(
              onPressed: () async {
                await _productService.deleteProduct(productId);
                if (!mounted) return; // Added mounted check
                Navigator.pop(context);
              },
              child: Text(appLocalizations.deleteButtonText),
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
      appBar: AppBar(title: Text(appLocalizations.productManagementTitle)),
      body: StreamBuilder<List<Product>>(
        stream: _productService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Product> products = snapshot.data ?? [];

          if (products.isEmpty) {
            return Center(child: Text(appLocalizations.noProductsFound));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    '${appLocalizations.priceLabel}: \$${product.price.toStringAsFixed(2)} | ${appLocalizations.stockLabel}: ${product.stock}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showProductDialog(product: product),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteProduct(product.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
