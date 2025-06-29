import 'package:intl/intl.dart';

class PriceFormatter {
  const PriceFormatter._();

  static final _format = NumberFormat('#,##0.00', 'en');

  static String format(num value) {
    return _format.format(value);
  }
}
