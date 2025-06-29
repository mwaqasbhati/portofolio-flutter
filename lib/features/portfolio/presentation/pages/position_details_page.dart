import 'package:flutter/material.dart';

import '../../domain/entities/position_entity.dart';

class PositionDetailsPage extends StatelessWidget {
  final PositionEntity position;
  const PositionDetailsPage({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(position.ticker)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(position.name, style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Exchange: ${position.exchange}'),
            const SizedBox(height: 8),
            Text('Last price: ${position.lastPriceDisplay}'),
            const SizedBox(height: 8),
            Text('Quantity: ${position.quantityCostDisplay}'),
            const SizedBox(height: 8),
            Text('Market value: ${position.marketValueDisplay}'),
            const SizedBox(height: 8),
            Text('PnL: ${position.pnlValueDisplay} ${position.pnlPercentageDisplay}'),
          ],
        ),
      ),
    );
  }
}
