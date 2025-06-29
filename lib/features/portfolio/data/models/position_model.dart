
import 'package:baraka_flutter/features/portfolio/data/models/instrument_model.dart';

class PositionModel {
  final InstrumentModel instrument;
  final double quantity;
  final double averagePrice;
  final double cost;
  final double marketValue;
  final double pnl;
  final double pnlPercentage;

  PositionModel({
    required this.instrument,
    required this.quantity,
    required this.averagePrice,
    required this.cost,
    required this.marketValue,
    required this.pnl,
    required this.pnlPercentage,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
      instrument: InstrumentModel.fromJson(json['instrument']),
      quantity: (json['quantity'] as num).toDouble(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      marketValue: (json['marketValue'] as num).toDouble(),
      pnl: (json['pnl'] as num).toDouble(),
      pnlPercentage: (json['pnlPercentage'] as num).toDouble(),
    );
  }
}
