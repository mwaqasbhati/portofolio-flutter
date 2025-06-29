import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/position_entity.dart';
import '../../../../core/utils/pnl_colors.dart';
import '../../../../core/theme/app_theme.dart';

class PositionItem extends StatelessWidget {
  final PositionEntity position;
  const PositionItem({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final ticker = position.ticker;
    final name = position.name;
    final exchange = position.exchange;
    // Use common colors for profit/loss values
    final pnlColor = PnlColors.forValue(position.isProfit);

    return InkWell(
      onTap: () => context.pushNamed('position', extra: position),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top row: Ticker + PnL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ticker, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text.rich(
                  TextSpan(
                    text: '${position.pnlValueDisplay} ',
                    style: AppTheme.boldText,
                    children: [
                      TextSpan(
                        text: position.pnlPercentageDisplay,
                        style: TextStyle(color: pnlColor),
                      ),
                    ],
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Currency + price
              Text(
                position.lastPriceDisplay,
                style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              /// Quantity x Average = Cost
              Text(
                position.quantityCostDisplay,
                style: textTheme.bodySmall,
                textDirection: TextDirection.ltr,
              ),
            ],),

            const SizedBox(height: 8),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Name + Exchange
              Text('$name\n$exchange', style: textTheme.bodySmall),
              const SizedBox(height: 8),

              /// Market Value
              Text(
                position.marketValueDisplay,
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],)
          ],
        ),
        ),
      ),
    );
  }
}

