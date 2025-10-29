import 'package:intl/intl.dart';

class NumberFormatter {
  static String format(double value) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(value);
  }
}
