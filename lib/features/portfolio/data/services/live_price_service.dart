import 'dart:async';
import 'dart:math';

import 'package:baraka_flutter/features/portfolio/data/models/instrument_model.dart';
import 'package:injectable/injectable.dart';

/// A simple service that generates live prices for instruments every second.
@lazySingleton
class LivePriceService {
  final _random = Random();

  /// Returns a broadcast stream emitting updated prices for the given instruments.
  /// The emitted map uses the instrument ticker as key and the generated price as value.
  ///
  /// Each price is a random value within +-10% of the original price supplied
  /// through [instruments].
  Stream<Map<String, double>> prices(List<InstrumentModel> instruments) {
    final basePrices = {
      for (final instrument in instruments) instrument.ticker: instrument.lastTradedPrice
    };

    return Stream.periodic(const Duration(seconds: 1), (_) {
      final updates = <String, double>{};
      for (final entry in basePrices.entries) {
        final min = entry.value * 0.9;
        final max = entry.value * 1.1;
        final price = min + _random.nextDouble() * (max - min);
        updates[entry.key] = double.parse(price.toStringAsFixed(2));
      }
      return updates;
    }).asBroadcastStream();
  }
}
