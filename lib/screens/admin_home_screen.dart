import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/screens/admin_login_screen.dart';
import 'package:bastah/services/auth_service.dart';
import 'package:bastah/screens/category_management_screen.dart';
import 'package:bastah/screens/product_management_screen.dart';
import 'package:bastah/screens/order_management_screen.dart';
import 'package:bastah/screens/admin_dashboard_screen.dart'; // Import the new dashboard screen
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final AuthService authService = AuthService();

    return PopScope(
      canPop: false, // Prevent popping with the system back button
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldLogout =
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(appLocalizations.confirmLogoutTitle),
                content: Text(appLocalizations.confirmLogoutMessage),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(appLocalizations.cancelButtonText),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(appLocalizations.logoutButtonText),
                  ),
                ],
              ),
            ) ??
            false;
        if (shouldLogout) {
          await authService.signOut();
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.adminHomeTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final bool shouldLogout =
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(appLocalizations.confirmLogoutTitle),
                        content: Text(appLocalizations.confirmLogoutMessage),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(appLocalizations.cancelButtonText),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(appLocalizations.logoutButtonText),
                          ),
                        ],
                      ),
                    ) ??
                    false;
                if (shouldLogout) {
                  await authService.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AdminLoginScreen(),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
        body: Center(child: Text(appLocalizations.adminHomeWelcome)),
      ),
    );
  }
}
