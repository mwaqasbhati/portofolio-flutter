import 'package:baraka_flutter/core/utils/percentage_formatter.dart';
import 'package:baraka_flutter/core/utils/price_formatter.dart';
import 'package:baraka_flutter/features/portfolio/data/models/balance_model.dart';

/// DTO used by the presentation layer to show balance information.
class BalanceEntity {
  final String netValueDisplay;
  final String pnlValueDisplay;
  final String pnlPercentageDisplay;
  final bool isProfit;

  BalanceEntity({
    required this.netValueDisplay,
    required this.pnlValueDisplay,
    required this.pnlPercentageDisplay,
    required this.isProfit,
  });

  factory BalanceEntity.fromModel(BalanceModel balance) {
    final isProfit = balance.pnl >= 0;
    final netValueDisplay = PriceFormatter.format(balance.netValue);
    final pnlValueDisplay = PriceFormatter.format(balance.pnl);
    final pnlPercentageDisplay = '(${PercentageFormatter.format(balance.pnlPercentage)})';
    return BalanceEntity(
      netValueDisplay: netValueDisplay,
      pnlValueDisplay: pnlValueDisplay,
      pnlPercentageDisplay: pnlPercentageDisplay,
      isProfit: isProfit,
    );
  }
}
