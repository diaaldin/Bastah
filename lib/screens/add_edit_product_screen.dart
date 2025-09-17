import 'dart:io';

import 'package:bastah/models/category.dart';
import 'package:bastah/models/product.dart';
import 'package:bastah/services/category_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;

  const AddEditProductScreen({super.key, this.product});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productService = ProductService();
  final _categoryService = CategoryService();

  late String _id;
  late String _categoryId;
  final _nameEnController = TextEditingController();
  final _nameArController = TextEditingController();
  final _nameHeController = TextEditingController();
  final _descriptionEnController = TextEditingController();
  final _descriptionArController = TextEditingController();
  final _descriptionHeController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _images = <File>[];
  final _imageUrls = <String>[];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _id = widget.product!.id;
      _categoryId = widget.product!.categoryId;
      _nameEnController.text = widget.product!.name['en'] ?? '';
      _nameArController.text = widget.product!.name['ar'] ?? '';
      _nameHeController.text = widget.product!.name['he'] ?? '';
      _descriptionEnController.text = widget.product!.description['en'] ?? '';
      _descriptionArController.text = widget.product!.description['ar'] ?? '';
      _descriptionHeController.text = widget.product!.description['he'] ?? '';
      _priceController.text = widget.product!.price.toString();
      _stockController.text = widget.product!.stock.toString();
      _imageUrls.addAll(widget.product!.images);
    } else {
      _id = DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final product = Product(
          id: _id,
          categoryId: _categoryId,
          name: {
            'en': _nameEnController.text,
            'ar': _nameArController.text,
            'he': _nameHeController.text,
          },
          description: {
            'en': _descriptionEnController.text,
            'ar': _descriptionArController.text,
            'he': _descriptionHeController.text,
          },
          price: double.parse(_priceController.text),
          stock: int.parse(_stockController.text),
          images: _imageUrls, // Pass current _imageUrls
        );

        if (widget.product != null) {
          final updatedProduct = await _productService.updateProduct(product, newImageFiles: _images);
          setState(() {
            _imageUrls.clear();
            _imageUrls.addAll(updatedProduct.images);
            _images.clear(); // Clear new images after upload
          });
        } else {
          final newProduct = await _productService.addProduct(product, _images);
          setState(() {
            _imageUrls.clear();
            _imageUrls.addAll(newProduct.images);
            _images.clear(); // Clear new images after upload
          });
        }

        if (mounted) {
          Navigator.of(context).pop();
        }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? 'Edit Product' : 'Add Product'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  StreamBuilder<List<Category>>(
                    stream: _categoryService.getCategories(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      final categories = snapshot.data!;
                      return DropdownButtonFormField<String>(
                        value: _categoryId,
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name['en'] ?? ''),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _categoryId = value!;
                          });
                        },
                        decoration: const InputDecoration(labelText: 'Category'),
                      );
                    },
                  ),
                  TextFormField(
                    controller: _nameEnController,
                    decoration: const InputDecoration(labelText: 'Name (English)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameArController,
                    decoration: const InputDecoration(labelText: 'Name (Arabic)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameHeController,
                    decoration: const InputDecoration(labelText: 'Name (Hebrew)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionEnController,
                    decoration: const InputDecoration(
                      labelText: 'Description (English)',
                    ),
                    maxLines: 3,
                  ),
                  TextFormField(
                    controller: _descriptionArController,
                    decoration: const InputDecoration(
                      labelText: 'Description (Arabic)',
                    ),
                    maxLines: 3,
                  ),
                  TextFormField(
                    controller: _descriptionHeController,
                    decoration: const InputDecoration(
                      labelText: 'Description (Hebrew)',
                    ),
                    maxLines: 3,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(labelText: 'Stock'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a stock quantity';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _isLoading ? null : () async {
                      final picker = ImagePicker();
                      final pickedFiles = await picker.pickMultiImage();
                      // ignore: unnecessary_null_comparison
                      if (pickedFiles != null) {
                        setState(() {
                          _images.addAll(
                            pickedFiles.map((xfile) => File(xfile.path)).toList(),
                          );
                        });
                      }
                    },
                    child: const Text('Add Images'),
                  ),
                  Wrap(
                    children: _images.map((image) {
                      return Image.file(File(image.path), width: 100, height: 100);
                    }).toList(),
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _imageUrls.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String imageUrl = entry.value;
                      return Stack(
                        children: [
                          Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _imageUrls.removeAt(idx);
                                });
                              },
                              child: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveProduct,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
