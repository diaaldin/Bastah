// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get hello => 'مرحبا';

  @override
  String get adminLoginTitle => 'تسجيل دخول المسؤول';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailRequiredError => 'البريد الإلكتروني مطلوب';

  @override
  String get invalidEmailError => 'الرجاء إدخال بريد إلكتروني صالح';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordRequiredError => 'كلمة المرور مطلوبة';

  @override
  String get passwordLengthError =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get loginFailedMessage =>
      'فشل تسجيل الدخول. الرجاء التحقق من بيانات الاعتماد الخاصة بك.';

  @override
  String get loginButtonText => 'تسجيل الدخول';

  @override
  String get toggleLanguageButtonText => 'تبديل اللغة';

  @override
  String get adminHomeTitle => 'الصفحة الرئيسية للمسؤول';

  @override
  String get adminPanelTitle => 'لوحة تحكم المسؤول';

  @override
  String get categoryManagementTitle => 'إدارة الفئات';

  @override
  String get productManagementTitle => 'إدارة المنتجات';

  @override
  String get orderManagementTitle => 'إدارة الطلبات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get adminHomeWelcome => 'مرحباً بك في لوحة تحكم المسؤول!';

  @override
  String get addCategoryTitle => 'إضافة فئة';

  @override
  String get editCategoryTitle => 'تعديل فئة';

  @override
  String get categoryNameEnLabel => 'اسم الفئة (الإنجليزية)';

  @override
  String get categoryNameArLabel => 'اسم الفئة (العربية)';

  @override
  String get categoryNameHeLabel => 'اسم الفئة (العبرية)';

  @override
  String get cancelButtonText => 'إلغاء';

  @override
  String get saveButtonText => 'حفظ';

  @override
  String get deleteCategoryConfirmationTitle => 'حذف فئة';

  @override
  String get deleteCategoryConfirmationMessage =>
      'هل أنت متأكد أنك تريد حذف هذه الفئة؟';

  @override
  String get deleteButtonText => 'حذف';

  @override
  String get noCategoriesFound => 'لم يتم العثور على فئات.';

  @override
  String get addProductTitle => 'إضافة منتج';

  @override
  String get editProductTitle => 'تعديل منتج';

  @override
  String get productNameEnLabel => 'اسم المنتج (الإنجليزية)';

  @override
  String get productNameArLabel => 'اسم المنتج (العربية)';

  @override
  String get productNameHeLabel => 'اسم المنتج (العبرية)';

  @override
  String get productDescriptionEnLabel => 'الوصف (الإنجليزية)';

  @override
  String get productDescriptionArLabel => 'الوصف (العربية)';

  @override
  String get productDescriptionHeLabel => 'الوصف (العبرية)';

  @override
  String get productPriceLabel => 'السعر';

  @override
  String get productStockLabel => 'كمية المخزون';

  @override
  String get selectCategoryHint => 'اختر فئة';

  @override
  String get pickImagesButtonText => 'اختيار الصور';

  @override
  String imagesSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم اختيار $count صور',
      one: 'تم اختيار صورة واحدة',
      zero: 'لم يتم اختيار صور',
    );
    return '$_temp0';
  }

  @override
  String get deleteProductConfirmationTitle => 'حذف منتج';

  @override
  String get deleteProductConfirmationMessage =>
      'هل أنت متأكد أنك تريد حذف هذا المنتج؟';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات.';

  @override
  String get priceLabel => 'السعر';

  @override
  String get stockLabel => 'المخزون';

  @override
  String get updateOrderStatusTitle => 'تحديث حالة الطلب';

  @override
  String get orderStatusLabel => 'حالة الطلب';

  @override
  String get noOrdersFound => 'لم يتم العثور على طلبات.';

  @override
  String get orderIdLabel => 'معرف الطلب';

  @override
  String get customerNameLabel => 'اسم العميل';

  @override
  String get totalAmountLabel => 'المبلغ الإجمالي';

  @override
  String get customerPhoneLabel => 'رقم هاتف العميل';

  @override
  String get customerAddressLabel => 'عنوان العميل';

  @override
  String get paymentMethodLabel => 'طريقة الدفع';

  @override
  String get createdAtLabel => 'تاريخ الإنشاء';

  @override
  String get orderItemsLabel => 'عناصر الطلب';

  @override
  String get productIdLabel => 'معرف المنتج';

  @override
  String get quantityLabel => 'الكمية';

  @override
  String get updateStatusButtonText => 'تحديث الحالة';

  @override
  String get pendingStatus => 'معلق';

  @override
  String get processingStatus => 'قيد المعالجة';

  @override
  String get shippedStatus => 'تم الشحن';

  @override
  String get deliveredStatus => 'تم التوصيل';

  @override
  String get cashOnDelivery => 'الدفع عند الاستلام';

  @override
  String get onlinePayment => 'الدفع عبر الإنترنت';

  @override
  String get customerHomeTitle => 'المنتجات';

  @override
  String get addToCartButtonText => 'أضف إلى السلة';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get noProductsAvailable => 'لا توجد منتجات متاحة.';

  @override
  String get allCategories => 'جميع الفئات';

  @override
  String productAddedToCart(Object productName) {
    return 'تمت إضافة $productName إلى السلة!';
  }

  @override
  String get cartTitle => 'سلة التسوق';

  @override
  String get emptyCartMessage => 'سلة التسوق فارغة.';

  @override
  String get checkoutButtonText => 'المتابعة إلى الدفع';

  @override
  String get checkoutTitle => 'الدفع';

  @override
  String get customerDetailsTitle => 'تفاصيل العميل';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get fullNameRequiredError => 'الاسم الكامل مطلوب';

  @override
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  String get phoneNumberRequiredError => 'رقم الهاتف مطلوب';

  @override
  String get addressLabel => 'العنوان';

  @override
  String get addressRequiredError => 'العنوان مطلوب';

  @override
  String get paymentMethodTitle => 'طريقة الدفع';

  @override
  String get placeOrderButtonText => 'تأكيد الطلب';

  @override
  String get orderPlacementFailed => 'فشل تأكيد الطلب';

  @override
  String get orderConfirmationTitle => 'تأكيد الطلب';

  @override
  String get orderConfirmationMessage => 'تم تأكيد طلبك بنجاح!';

  @override
  String get orderConfirmationThankYou => 'شكرا لك على الشراء.';

  @override
  String get continueShoppingButtonText => 'متابعة التسوق';

  @override
  String get orderTrackingTitle => 'تتبع الطلب';

  @override
  String get notLoggedInError =>
      'You are not logged in. Please log in to place an order.';

  @override
  String get languageLabel => 'Language';

  @override
  String get confirmLogoutTitle => 'تأكيد تسجيل الخروج';

  @override
  String get confirmLogoutMessage => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get logoutButtonText => 'تسجيل الخروج';

  @override
  String get adminDashboardTitle => 'لوحة تحكم المسؤول';

  @override
  String get dashboardSummaryTitle => 'ملخص';

  @override
  String get totalOrdersLabel => 'إجمالي الطلبات';

  @override
  String get totalRevenueLabel => 'إجمالي الإيرادات';

  @override
  String get totalProductsLabel => 'إجمالي المنتجات';

  @override
  String get totalCustomersLabel => 'إجمالي العملاء';

  @override
  String get dashboardSalesChartTitle => 'المبيعات خلال آخر 7 أيام';

  @override
  String get dayMon => 'الاثنين';

  @override
  String get dayTue => 'الثلاثاء';

  @override
  String get dayWed => 'الأربعاء';

  @override
  String get dayThu => 'الخميس';

  @override
  String get dayFri => 'الجمعة';

  @override
  String get daySat => 'السبت';

  @override
  String get daySun => 'الأحد';

  @override
  String get dashboardRecentOrdersTitle => 'الطلبات الأخيرة';

  @override
  String get signOutConfirmationTitle => 'تسجيل الخروج';

  @override
  String get signOutConfirmationMessage =>
      'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get signOutButtonText => 'تسجيل الخروج';

  @override
  String get orderPlacedLabel => 'Order Placed';

  @override
  String get unknownProduct => 'Unknown Product';
}
