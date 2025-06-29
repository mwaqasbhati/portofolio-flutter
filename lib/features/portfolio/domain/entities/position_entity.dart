import 'package:baraka_flutter/core/utils/percentage_formatter.dart';
import 'package:baraka_flutter/core/utils/price_formatter.dart';
import 'package:baraka_flutter/features/portfolio/data/models/position_model.dart';

/// Entity used by the presentation layer to show a position item.
class PositionEntity {
  final String ticker;
  final String name;
  final String exchange;
  final String lastPriceDisplay;
  final String quantityCostDisplay;
  final String marketValueDisplay;
  final String pnlValueDisplay;
  final String pnlPercentageDisplay;
  final bool isProfit;

  PositionEntity({
    required this.ticker,
    required this.name,
    required this.exchange,
    required this.lastPriceDisplay,
    required this.quantityCostDisplay,
    required this.marketValueDisplay,
    required this.pnlValueDisplay,
    required this.pnlPercentageDisplay,
    required this.isProfit,
  });

  factory PositionEntity.fromEntity(PositionModel position) {
    final instrument = position.instrument;
    bool isProfit = position.pnl >= 0;
    final pnlValueDisplay = PriceFormatter.format(position.pnl);
    final pnlPercentageDisplay = '(${PercentageFormatter.format(position.pnlPercentage)})';
    final lastPriceDisplay = '${instrument.currency} ${PriceFormatter.format(instrument.lastTradedPrice)}';
    final quantityCostDisplay = '${position.quantity} x ${PriceFormatter.format(position.averagePrice)} = ${PriceFormatter.format(position.cost)}';
    final marketValueDisplay = PriceFormatter.format(position.marketValue);

    return PositionEntity(
      ticker: instrument.ticker,
      name: instrument.name,
      exchange: instrument.exchange,
      lastPriceDisplay: lastPriceDisplay,
      quantityCostDisplay: quantityCostDisplay,
      marketValueDisplay: marketValueDisplay,
      pnlValueDisplay: pnlValueDisplay,
      pnlPercentageDisplay: pnlPercentageDisplay,
      isProfit: isProfit,
    );
  }
}
