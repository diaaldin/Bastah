import 'package:bastah/l10n/app_localizations.dart';

extension AppLocalizationsUtils on AppLocalizations {
  String translateOrderStatus(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      default:
        return status;
    }
  }

  String translatePaymentMethod(String method) {
    switch (method) {
      case 'cash':
        return 'Cash on Delivery';
      case 'online':
        return 'Online Payment';
      default:
        return method;
    }
  }
}
