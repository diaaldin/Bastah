import 'package:bastah/firebase_options.dart';
import 'package:bastah/l10n/app_localizations.dart';
import 'package:bastah/providers/app_provider.dart';
import 'package:bastah/screens/customer_home_screen.dart';
import 'package:bastah/services/admin_service.dart';
import 'package:bastah/services/auth_service.dart';
import 'package:bastah/services/cart_service.dart';
import 'package:bastah/services/category_service.dart';
import 'package:bastah/services/order_service.dart';
import 'package:bastah/services/product_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:bastah/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Stripe.publishableKey = 'YOUR_PUBLISHABLE_KEY';
  if (Firebase.apps.isEmpty) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Firebase.initializeApp();
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }
  await NotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<AdminService>(create: (_) => AdminService()),
        Provider<ProductService>(create: (_) => ProductService()),
        Provider<CategoryService>(create: (_) => CategoryService()),
        Provider<OrderService>(create: (_) => OrderService()),
        ChangeNotifierProvider<CartService>(create: (_) => CartService()),
        ChangeNotifierProvider<AppProvider>(create: (context) => AppProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Bastah',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            locale: provider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const CustomerHomeScreen(),
          );
        },
      ),
    );
  }
}
