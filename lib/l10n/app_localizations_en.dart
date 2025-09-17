// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get adminLoginTitle => 'Admin Login';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailRequiredError => 'Email is required';

  @override
  String get invalidEmailError => 'Please enter a valid email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordRequiredError => 'Password is required';

  @override
  String get passwordLengthError =>
      'Password must be at least 6 characters long';

  @override
  String get loginFailedMessage =>
      'Login failed. Please check your credentials.';

  @override
  String get loginButtonText => 'Login';

  @override
  String get toggleLanguageButtonText => 'Toggle Language';

  @override
  String get adminHomeTitle => 'Admin Home';

  @override
  String get adminPanelTitle => 'Admin Panel';

  @override
  String get categoryManagementTitle => 'Category Management';

  @override
  String get productManagementTitle => 'Product Management';

  @override
  String get orderManagementTitle => 'Order Management';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get adminHomeWelcome => 'Welcome to Admin Panel!';

  @override
  String get addCategoryTitle => 'Add Category';

  @override
  String get editCategoryTitle => 'Edit Category';

  @override
  String get categoryNameEnLabel => 'Category Name (English)';

  @override
  String get categoryNameArLabel => 'Category Name (Arabic)';

  @override
  String get categoryNameHeLabel => 'Category Name (Hebrew)';

  @override
  String get cancelButtonText => 'Cancel';

  @override
  String get saveButtonText => 'Save';

  @override
  String get deleteCategoryConfirmationTitle => 'Delete Category';

  @override
  String get deleteCategoryConfirmationMessage =>
      'Are you sure you want to delete this category?';

  @override
  String get deleteButtonText => 'Delete';

  @override
  String get noCategoriesFound => 'No categories found.';

  @override
  String get addProductTitle => 'Add Product';

  @override
  String get editProductTitle => 'Edit Product';

  @override
  String get productNameEnLabel => 'Product Name (English)';

  @override
  String get productNameArLabel => 'Product Name (Arabic)';

  @override
  String get productNameHeLabel => 'Product Name (Hebrew)';

  @override
  String get productDescriptionEnLabel => 'Description (English)';

  @override
  String get productDescriptionArLabel => 'Description (Arabic)';

  @override
  String get productDescriptionHeLabel => 'Description (Hebrew)';

  @override
  String get productPriceLabel => 'Price';

  @override
  String get productStockLabel => 'Stock Quantity';

  @override
  String get selectCategoryHint => 'Select Category';

  @override
  String get pickImagesButtonText => 'Pick Images';

  @override
  String imagesSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count images selected',
      one: '1 image selected',
      zero: 'No images selected',
    );
    return '$_temp0';
  }

  @override
  String get deleteProductConfirmationTitle => 'Delete Product';

  @override
  String get deleteProductConfirmationMessage =>
      'Are you sure you want to delete this product?';

  @override
  String get noProductsFound => 'No products found.';

  @override
  String get priceLabel => 'Price';

  @override
  String get stockLabel => 'Stock';

  @override
  String get updateOrderStatusTitle => 'Update Order Status';

  @override
  String get orderStatusLabel => 'Order Status';

  @override
  String get noOrdersFound => 'No orders found.';

  @override
  String get orderIdLabel => 'Order ID';

  @override
  String get customerNameLabel => 'Customer Name';

  @override
  String get totalAmountLabel => 'Total Amount';

  @override
  String get customerPhoneLabel => 'Customer Phone';

  @override
  String get customerAddressLabel => 'Customer Address';

  @override
  String get paymentMethodLabel => 'Payment Method';

  @override
  String get createdAtLabel => 'Created At';

  @override
  String get orderItemsLabel => 'Order Items';

  @override
  String get productIdLabel => 'Product ID';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get updateStatusButtonText => 'Update Status';

  @override
  String get pendingStatus => 'Pending';

  @override
  String get processingStatus => 'Processing';

  @override
  String get shippedStatus => 'Shipped';

  @override
  String get deliveredStatus => 'Delivered';

  @override
  String get cashOnDelivery => 'Cash on Delivery';

  @override
  String get onlinePayment => 'Online Payment';

  @override
  String get customerHomeTitle => 'Products';

  @override
  String get addToCartButtonText => 'Add to Cart';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get noProductsAvailable => 'No products available.';

  @override
  String get allCategories => 'All Categories';

  @override
  String productAddedToCart(Object productName) {
    return '$productName added to cart!';
  }

  @override
  String get cartTitle => 'Shopping Cart';

  @override
  String get emptyCartMessage => 'Your cart is empty.';

  @override
  String get checkoutButtonText => 'Proceed to Checkout';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get customerDetailsTitle => 'Customer Details';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameRequiredError => 'Full Name is required';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberRequiredError => 'Phone Number is required';

  @override
  String get addressLabel => 'Address';

  @override
  String get addressRequiredError => 'Address is required';

  @override
  String get paymentMethodTitle => 'Payment Method';

  @override
  String get placeOrderButtonText => 'Place Order';

  @override
  String get orderPlacementFailed => 'Order placement failed';

  @override
  String get orderConfirmationTitle => 'Order Confirmation';

  @override
  String get orderConfirmationMessage =>
      'Your order has been placed successfully!';

  @override
  String get orderConfirmationThankYou => 'Thank you for your purchase.';

  @override
  String get continueShoppingButtonText => 'Continue Shopping';

  @override
  String get orderTrackingTitle => 'Order Tracking';

  @override
  String get notLoggedInError =>
      'You are not logged in. Please log in to place an order.';

  @override
  String get languageLabel => 'Language';

  @override
  String get confirmLogoutTitle => 'Confirm Logout';

  @override
  String get confirmLogoutMessage => 'Are you sure you want to log out?';

  @override
  String get logoutButtonText => 'Logout';

  @override
  String get adminDashboardTitle => 'Admin Dashboard';

  @override
  String get dashboardSummaryTitle => 'Summary';

  @override
  String get totalOrdersLabel => 'Total Orders';

  @override
  String get totalRevenueLabel => 'Total Revenue';

  @override
  String get totalProductsLabel => 'Total Products';

  @override
  String get totalCustomersLabel => 'Total Customers';

  @override
  String get dashboardSalesChartTitle => 'Sales Over Last 7 Days';

  @override
  String get dayMon => 'Mon';

  @override
  String get dayTue => 'Tue';

  @override
  String get dayWed => 'Wed';

  @override
  String get dayThu => 'Thu';

  @override
  String get dayFri => 'Fri';

  @override
  String get daySat => 'Sat';

  @override
  String get daySun => 'Sun';

  @override
  String get dashboardRecentOrdersTitle => 'Recent Orders';

  @override
  String get signOutConfirmationTitle => 'Sign Out';

  @override
  String get signOutConfirmationMessage => 'Are you sure you want to sign out?';

  @override
  String get signOutButtonText => 'Sign Out';

  @override
  String get orderPlacedLabel => 'Order Placed';

  @override
  String get unknownProduct => 'Unknown Product';
}
