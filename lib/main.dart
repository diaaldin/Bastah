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
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:bastah/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Clear all existing Firebase instances (for development only)
  try {
    await Firebase.app().delete();
  } catch (e) {
    debugPrint('No existing Firebase app to delete');
  }

  try {
    // Initialize Firebase
    final FirebaseApp app = await Firebase.initializeApp(
      name: 'bastah-app', // Give a unique name to avoid conflicts
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Initialized Firebase app: ${app.name}');

    // Initialize Firebase App Check in a separate isolate
    await Future.microtask(() async {
      try {
        await FirebaseAppCheck.instance.activate(
          androidProvider: AndroidProvider.debug,
          appleProvider: AppleProvider.debug,
          webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
        );
        debugPrint('Firebase App Check initialized');
      } catch (e) {
        debugPrint('Error initializing App Check: $e');
        // Continue without App Check in development
      }
    });

    // Initialize notifications
    await NotificationService().initNotifications();

    runApp(const MyApp());
  } catch (e, stackTrace) {
    debugPrint('Error initializing Firebase: $e');
    debugPrint('Stack trace: $stackTrace');

    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Error initializing the app',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    main();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
