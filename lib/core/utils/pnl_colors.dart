import 'package:flutter/material.dart';

/// Utility class for determining profit/loss colors.
class PnlColors {
  const PnlColors._();

  /// Color used when the value represents a profit.
  static const profit = Colors.green;

  /// Color used when the value represents a loss.
  static const loss = Colors.red;

  /// Returns [profit] when [isProfit] is true, otherwise [loss].
  static Color forValue(bool isProfit) => isProfit ? profit : loss;
}
