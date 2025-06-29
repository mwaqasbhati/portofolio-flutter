import 'package:intl/intl.dart';

class PercentageFormatter {
  static final NumberFormat _formatter = NumberFormat.decimalPattern('en')
    ..maximumFractionDigits = 0
    ..minimumFractionDigits = 0;

  static String format(double value) {
    final prefix = value >= 0 ? '+' : '-';
    final formatted = _formatter.format(value.abs());
    return '\u200E$prefix$formatted%'; // <--- Forces LTR rendering
  }
}

