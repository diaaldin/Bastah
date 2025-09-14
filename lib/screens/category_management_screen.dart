import 'dart:io';

import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/models/category.dart';
import 'package:bastah/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _categoryNameEnController = TextEditingController();
  final TextEditingController _categoryNameArController = TextEditingController();
  final TextEditingController _categoryNameHeController = TextEditingController();
  Category? _editingCategory;
  XFile? _image;

  void _showCategoryDialog({Category? category}) {
    _editingCategory = category;
    _image = null;
    if (category != null) {
      _categoryNameEnController.text = category.name['en'] ?? '';
      _categoryNameArController.text = category.name['ar'] ?? '';
      _categoryNameHeController.text = category.name['he'] ?? '';
    } else {
      _categoryNameEnController.clear();
      _categoryNameArController.clear();
      _categoryNameHeController.clear();
    }

    var isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal during loading
      builder: (context) {
        final appLocalizations = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(category == null ? appLocalizations.addCategoryTitle : appLocalizations.editCategoryTitle),
              content: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _categoryNameEnController,
                          decoration: InputDecoration(labelText: appLocalizations.categoryNameEnLabel),
                        ),
                        TextField(
                          controller: _categoryNameArController,
                          decoration: InputDecoration(labelText: appLocalizations.categoryNameArLabel),
                        ),
                        TextField(
                          controller: _categoryNameHeController,
                          decoration: InputDecoration(labelText: appLocalizations.categoryNameHeLabel),
                        ),
                        const SizedBox(height: 20),
                        _image == null
                            ? (category?.imageUrl.isNotEmpty == true
                                ? Image.network(category!.imageUrl, height: 100)
                                : const SizedBox.shrink())
                            : Image.file(File(_image!.path), height: 100),
                        TextButton.icon(
                          icon: const Icon(Icons.image),
                          label: const Text('Add Image'),
                          onPressed: isLoading ? null : () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                _image = image;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withOpacity(0.7),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.pop(context),
                  child: Text(appLocalizations.cancelButtonText),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      String imageUrl = _editingCategory?.imageUrl ?? '';
                      if (_image != null) {
                        imageUrl = await _categoryService.uploadImage(_image!);
                      }

                      final name = {
                        'en': _categoryNameEnController.text,
                        'ar': _categoryNameArController.text,
                        'he': _categoryNameHeController.text,
                      };

                      if (_editingCategory == null) {
                        await _categoryService.addCategory(Category(id: '', name: name, imageUrl: imageUrl));
                      } else {
                        await _categoryService.updateCategory(Category(id: _editingCategory!.id, name: name, imageUrl: imageUrl));
                      }
                      if (mounted) Navigator.pop(context);
                    } catch (e) {
                      // Optionally show an error message to the user
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: Text(appLocalizations.saveButtonText),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteCategory(String categoryId) async {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(appLocalizations.deleteCategoryConfirmationTitle),
          content: Text(appLocalizations.deleteCategoryConfirmationMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(appLocalizations.cancelButtonText),
            ),
            ElevatedButton(
              onPressed: () async {
                await _categoryService.deleteCategory(categoryId);
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
      appBar: AppBar(
        title: Text(appLocalizations.categoryManagementTitle),
      ),
      body: StreamBuilder<List<Category>>(
        stream: _categoryService.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Category> categories = snapshot.data ?? [];

          if (categories.isEmpty) {
            return Center(child: Text(appLocalizations.noCategoriesFound));
          }

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              Category category = categories[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: category.imageUrl.isNotEmpty
                      ? Image.network(category.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.category),
                  title: Text(category.name[Localizations.localeOf(context).languageCode] ?? category.name['en'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showCategoryDialog(category: category),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteCategory(category.id),
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
        onPressed: () => _showCategoryDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
