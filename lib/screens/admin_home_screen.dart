import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/screens/admin_login_screen.dart';
import 'package:bastah/services/auth_service.dart';
import 'package:bastah/screens/category_management_screen.dart';
import 'package:bastah/screens/product_management_screen.dart';
import 'package:bastah/screens/order_management_screen.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.adminHomeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AdminLoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                appLocalizations.adminPanelTitle,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: Text(appLocalizations.categoryManagementTitle),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CategoryManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits),
              title: Text(appLocalizations.productManagementTitle),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProductManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(appLocalizations.orderManagementTitle),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(appLocalizations.settingsTitle),
              onTap: () {
                // Navigate to Settings Screen
                Navigator.pop(context); // Close the drawer
                // TODO: Implement navigation to Settings Screen
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text(appLocalizations.adminHomeWelcome)),
    );
  }
}
