import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_he.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('he'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @adminLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Login'**
  String get adminLoginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequiredError;

  /// No description provided for @invalidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmailError;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequiredError;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordLengthError;

  /// No description provided for @loginFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginFailedMessage;

  /// No description provided for @loginButtonText.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButtonText;

  /// No description provided for @toggleLanguageButtonText.
  ///
  /// In en, this message translates to:
  /// **'Toggle Language'**
  String get toggleLanguageButtonText;

  /// No description provided for @adminHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Home'**
  String get adminHomeTitle;

  /// No description provided for @adminPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get adminPanelTitle;

  /// No description provided for @categoryManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Category Management'**
  String get categoryManagementTitle;

  /// No description provided for @productManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Product Management'**
  String get productManagementTitle;

  /// No description provided for @orderManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Management'**
  String get orderManagementTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @adminHomeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Admin Panel!'**
  String get adminHomeWelcome;

  /// No description provided for @addCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategoryTitle;

  /// No description provided for @editCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategoryTitle;

  /// No description provided for @categoryNameEnLabel.
  ///
  /// In en, this message translates to:
  /// **'Category Name (English)'**
  String get categoryNameEnLabel;

  /// No description provided for @categoryNameArLabel.
  ///
  /// In en, this message translates to:
  /// **'Category Name (Arabic)'**
  String get categoryNameArLabel;

  /// No description provided for @categoryNameHeLabel.
  ///
  /// In en, this message translates to:
  /// **'Category Name (Hebrew)'**
  String get categoryNameHeLabel;

  /// No description provided for @cancelButtonText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonText;

  /// No description provided for @saveButtonText.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButtonText;

  /// No description provided for @deleteCategoryConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategoryConfirmationTitle;

  /// No description provided for @deleteCategoryConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get deleteCategoryConfirmationMessage;

  /// No description provided for @deleteButtonText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButtonText;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found.'**
  String get noCategoriesFound;

  /// No description provided for @addProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProductTitle;

  /// No description provided for @editProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProductTitle;

  /// No description provided for @productNameEnLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Name (English)'**
  String get productNameEnLabel;

  /// No description provided for @productNameArLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Name (Arabic)'**
  String get productNameArLabel;

  /// No description provided for @productNameHeLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Name (Hebrew)'**
  String get productNameHeLabel;

  /// No description provided for @productDescriptionEnLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (English)'**
  String get productDescriptionEnLabel;

  /// No description provided for @productDescriptionArLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (Arabic)'**
  String get productDescriptionArLabel;

  /// No description provided for @productDescriptionHeLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (Hebrew)'**
  String get productDescriptionHeLabel;

  /// No description provided for @productPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get productPriceLabel;

  /// No description provided for @productStockLabel.
  ///
  /// In en, this message translates to:
  /// **'Stock Quantity'**
  String get productStockLabel;

  /// No description provided for @selectCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategoryHint;

  /// No description provided for @pickImagesButtonText.
  ///
  /// In en, this message translates to:
  /// **'Pick Images'**
  String get pickImagesButtonText;

  /// No description provided for @imagesSelectedText.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No images selected} =1{1 image selected} other{{count} images selected}}'**
  String imagesSelectedText(int count);

  /// No description provided for @deleteProductConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProductConfirmationTitle;

  /// No description provided for @deleteProductConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this product?'**
  String get deleteProductConfirmationMessage;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found.'**
  String get noProductsFound;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @stockLabel.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stockLabel;

  /// No description provided for @updateOrderStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Order Status'**
  String get updateOrderStatusTitle;

  /// No description provided for @orderStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatusLabel;

  /// No description provided for @noOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No orders found.'**
  String get noOrdersFound;

  /// No description provided for @orderIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderIdLabel;

  /// No description provided for @customerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerNameLabel;

  /// No description provided for @totalAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmountLabel;

  /// No description provided for @customerPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Phone'**
  String get customerPhoneLabel;

  /// No description provided for @customerAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Address'**
  String get customerAddressLabel;

  /// No description provided for @paymentMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodLabel;

  /// No description provided for @createdAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAtLabel;

  /// No description provided for @orderItemsLabel.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItemsLabel;

  /// No description provided for @productIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Product ID'**
  String get productIdLabel;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @updateStatusButtonText.
  ///
  /// In en, this message translates to:
  /// **'Update Status'**
  String get updateStatusButtonText;

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatus;

  /// No description provided for @processingStatus.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processingStatus;

  /// No description provided for @shippedStatus.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get shippedStatus;

  /// No description provided for @deliveredStatus.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get deliveredStatus;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @onlinePayment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get onlinePayment;

  /// No description provided for @customerHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get customerHomeTitle;

  /// No description provided for @addToCartButtonText.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCartButtonText;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @noProductsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No products available.'**
  String get noProductsAvailable;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @productAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'{productName} added to cart!'**
  String productAddedToCart(Object productName);

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get cartTitle;

  /// No description provided for @emptyCartMessage.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty.'**
  String get emptyCartMessage;

  /// No description provided for @checkoutButtonText.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get checkoutButtonText;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @customerDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Details'**
  String get customerDetailsTitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @fullNameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Full Name is required'**
  String get fullNameRequiredError;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @phoneNumberRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Phone Number is required'**
  String get phoneNumberRequiredError;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @addressRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Address is required'**
  String get addressRequiredError;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodTitle;

  /// No description provided for @placeOrderButtonText.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrderButtonText;

  /// No description provided for @orderPlacementFailed.
  ///
  /// In en, this message translates to:
  /// **'Order placement failed'**
  String get orderPlacementFailed;

  /// No description provided for @orderConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Confirmation'**
  String get orderConfirmationTitle;

  /// No description provided for @orderConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully!'**
  String get orderConfirmationMessage;

  /// No description provided for @orderConfirmationThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your purchase.'**
  String get orderConfirmationThankYou;

  /// No description provided for @continueShoppingButtonText.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShoppingButtonText;

  /// No description provided for @orderTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get orderTrackingTitle;

  /// No description provided for @notLoggedInError.
  ///
  /// In en, this message translates to:
  /// **'You are not logged in. Please log in to place an order.'**
  String get notLoggedInError;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @confirmLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogoutTitle;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmLogoutMessage;

  /// No description provided for @logoutButtonText.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButtonText;

  /// No description provided for @adminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @dashboardSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get dashboardSummaryTitle;

  /// No description provided for @totalOrdersLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrdersLabel;

  /// No description provided for @totalRevenueLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenueLabel;

  /// No description provided for @totalProductsLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Products'**
  String get totalProductsLabel;

  /// No description provided for @totalCustomersLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get totalCustomersLabel;

  /// No description provided for @dashboardSalesChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales Over Last 7 Days'**
  String get dashboardSalesChartTitle;

  /// No description provided for @dayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get daySun;

  /// No description provided for @dashboardRecentOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get dashboardRecentOrdersTitle;

  /// No description provided for @signOutConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutConfirmationTitle;

  /// No description provided for @signOutConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmationMessage;

  /// No description provided for @signOutButtonText.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButtonText;

  /// No description provided for @orderPlacedLabel.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get orderPlacedLabel;

  /// No description provided for @unknownProduct.
  ///
  /// In en, this message translates to:
  /// **'Unknown Product'**
  String get unknownProduct;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'he'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'he':
      return AppLocalizationsHe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
