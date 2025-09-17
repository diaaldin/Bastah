// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get hello => 'שלום';

  @override
  String get adminLoginTitle => 'התחברות מנהל';

  @override
  String get emailLabel => 'אימייל';

  @override
  String get emailRequiredError => 'אימייל נדרש';

  @override
  String get invalidEmailError => 'אנא הזן אימייל תקין';

  @override
  String get passwordLabel => 'סיסמה';

  @override
  String get passwordRequiredError => 'סיסמה נדרשת';

  @override
  String get passwordLengthError => 'הסיסמה חייבת להיות באורך 6 תווים לפחות';

  @override
  String get loginFailedMessage =>
      'ההתחברות נכשלה. אנא בדוק את פרטי ההתחברות שלך.';

  @override
  String get loginButtonText => 'Login';

  @override
  String get toggleLanguageButtonText => 'החלף שפה';

  @override
  String get adminHomeTitle => 'דף הבית של מנהל המערכת';

  @override
  String get adminPanelTitle => 'פאנל ניהול';

  @override
  String get categoryManagementTitle => 'ניהול קטגוריות';

  @override
  String get productManagementTitle => 'ניהול מוצרים';

  @override
  String get orderManagementTitle => 'ניהול הזמנות';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get adminHomeWelcome => 'ברוך הבא לפאנל הניהול!';

  @override
  String get addCategoryTitle => 'הוסף קטגוריה';

  @override
  String get editCategoryTitle => 'ערוך קטגוריה';

  @override
  String get categoryNameEnLabel => 'שם קטגוריה (אנגלית)';

  @override
  String get categoryNameArLabel => 'שם קטגוריה (ערבית)';

  @override
  String get categoryNameHeLabel => 'שם קטגוריה (עברית)';

  @override
  String get cancelButtonText => 'ביטול';

  @override
  String get saveButtonText => 'שמור';

  @override
  String get deleteCategoryConfirmationTitle => 'מחק קטגוריה';

  @override
  String get deleteCategoryConfirmationMessage =>
      'האם אתה בטוח שברצונך למחוק קטגוריה זו?';

  @override
  String get deleteButtonText => 'מחק';

  @override
  String get noCategoriesFound => 'לא נמצאו קטגוריות.';

  @override
  String get addProductTitle => 'הוסף מוצר';

  @override
  String get editProductTitle => 'ערוך מוצר';

  @override
  String get productNameEnLabel => 'שם מוצר (אנגלית)';

  @override
  String get productNameArLabel => 'שם מוצר (ערבית)';

  @override
  String get productNameHeLabel => 'שם מוצר (עברית)';

  @override
  String get productDescriptionEnLabel => 'תיאור (אנגלית)';

  @override
  String get productDescriptionArLabel => 'תיאור (ערבית)';

  @override
  String get productDescriptionHeLabel => 'תיאור (עברית)';

  @override
  String get productPriceLabel => 'מחיר';

  @override
  String get productStockLabel => 'כמות במלאי';

  @override
  String get selectCategoryHint => 'בחר קטגוריה';

  @override
  String get pickImagesButtonText => 'בחר תמונות';

  @override
  String imagesSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'נבחרו $count תמונות',
      one: 'נבחרה תמונה אחת',
      zero: 'לא נבחרו תמונות',
    );
    return '$_temp0';
  }

  @override
  String get deleteProductConfirmationTitle => 'מחק מוצר';

  @override
  String get deleteProductConfirmationMessage =>
      'האם אתה בטוח שברצונך למחוק מוצר זה?';

  @override
  String get noProductsFound => 'לא נמצאו מוצרים.';

  @override
  String get priceLabel => 'מחיר';

  @override
  String get stockLabel => 'מלאי';

  @override
  String get updateOrderStatusTitle => 'עדכן סטטוס הזמנה';

  @override
  String get orderStatusLabel => 'סטטוס הזמנה';

  @override
  String get noOrdersFound => 'לא נמצאו הזמנות.';

  @override
  String get orderIdLabel => 'מזהה הזמנה';

  @override
  String get customerNameLabel => 'שם לקוח';

  @override
  String get totalAmountLabel => 'סכום כולל';

  @override
  String get customerPhoneLabel => 'טלפון לקוח';

  @override
  String get customerAddressLabel => 'כתובת לקוח';

  @override
  String get paymentMethodLabel => 'אמצעי תשלום';

  @override
  String get createdAtLabel => 'נוצר בתאריך';

  @override
  String get orderItemsLabel => 'פריטי הזמנה';

  @override
  String get productIdLabel => 'מזהה מוצר';

  @override
  String get quantityLabel => 'כמות';

  @override
  String get updateStatusButtonText => 'עדכן סטטוס';

  @override
  String get pendingStatus => 'בהמתנה';

  @override
  String get processingStatus => 'בתהליך';

  @override
  String get shippedStatus => 'נשלח';

  @override
  String get deliveredStatus => 'נמסר';

  @override
  String get cashOnDelivery => 'מזומן במשלוח';

  @override
  String get onlinePayment => 'תשלום מקוון';

  @override
  String get customerHomeTitle => 'מוצרים';

  @override
  String get addToCartButtonText => 'הוסף לעגלה';

  @override
  String get somethingWentWrong => 'משהו השתבש';

  @override
  String get noProductsAvailable => 'אין מוצרים זמינים.';

  @override
  String get allCategories => 'כל הקטגוריות';

  @override
  String productAddedToCart(Object productName) {
    return '$productName נוסף לעגלה!';
  }

  @override
  String get cartTitle => 'עגלת קניות';

  @override
  String get emptyCartMessage => 'עגלת הקניות ריקה.';

  @override
  String get checkoutButtonText => 'המשך לקופה';

  @override
  String get checkoutTitle => 'קופה';

  @override
  String get customerDetailsTitle => 'פרטי לקוח';

  @override
  String get fullNameLabel => 'שם מלא';

  @override
  String get fullNameRequiredError => 'שם מלא נדרש';

  @override
  String get phoneNumberLabel => 'מספר טלפון';

  @override
  String get phoneNumberRequiredError => 'מספר טלפון נדרש';

  @override
  String get addressLabel => 'כתובת';

  @override
  String get addressRequiredError => 'כתובת נדרשת';

  @override
  String get paymentMethodTitle => 'אמצעי תשלום';

  @override
  String get placeOrderButtonText => 'בצע הזמנה';

  @override
  String get orderPlacementFailed => 'הזמנה נכשלה';

  @override
  String get orderConfirmationTitle => 'אישור הזמנה';

  @override
  String get orderConfirmationMessage => 'ההזמנה שלך בוצעה בהצלחה!';

  @override
  String get orderConfirmationThankYou => 'תודה על הרכישה.';

  @override
  String get continueShoppingButtonText => 'המשך קניות';

  @override
  String get orderTrackingTitle => 'Order Tracking';

  @override
  String get notLoggedInError =>
      'You are not logged in. Please log in to place an order.';

  @override
  String get languageLabel => 'Language';

  @override
  String get confirmLogoutTitle => 'אשר התנתקות';

  @override
  String get confirmLogoutMessage => 'האם אתה בטוח שברצונך להתנתק?';

  @override
  String get logoutButtonText => 'התנתק';

  @override
  String get adminDashboardTitle => 'לוח מחוונים למנהל';

  @override
  String get dashboardSummaryTitle => 'סיכום';

  @override
  String get totalOrdersLabel => 'סה\"כ הזמנות';

  @override
  String get totalRevenueLabel => 'סה\"כ הכנסות';

  @override
  String get totalProductsLabel => 'סה\"כ מוצרים';

  @override
  String get totalCustomersLabel => 'סה\"כ לקוחות';

  @override
  String get dashboardSalesChartTitle => 'מכירות ב-7 הימים האחרונים';

  @override
  String get dayMon => 'יום ב\'';

  @override
  String get dayTue => 'יום ג\'';

  @override
  String get dayWed => 'יום ד\'';

  @override
  String get dayThu => 'יום ה\'';

  @override
  String get dayFri => 'יום ו\'';

  @override
  String get daySat => 'שבת';

  @override
  String get daySun => 'יום א\'';

  @override
  String get dashboardRecentOrdersTitle => 'הזמנות אחרונות';

  @override
  String get signOutConfirmationTitle => 'התנתק';

  @override
  String get signOutConfirmationMessage => 'האם אתה בטוח שברצונך להתנתק?';

  @override
  String get signOutButtonText => 'התנתק';

  @override
  String get orderPlacedLabel => 'Order Placed';

  @override
  String get unknownProduct => 'Unknown Product';
}
