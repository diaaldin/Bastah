import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/screens/customer_home_screen.dart';
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.orderConfirmationTitle),
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                appLocalizations.orderConfirmationMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                appLocalizations.orderConfirmationThankYou,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const CustomerHomeScreen()),
                    (Route<dynamic> route) => false, // Remove all routes from stack
                  );
                },
                child: Text(appLocalizations.continueShoppingButtonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}