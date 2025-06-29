import 'balance_model.dart';
import 'position_model.dart';

class PortfolioModel {
  final BalanceModel balance;
  final List<PositionModel> positions;

  PortfolioModel({required this.balance, required this.positions});

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      balance: BalanceModel.fromJson(json['balance']),
      positions: (json['positions'] as List)
          .map((e) => PositionModel.fromJson(e))
          .toList(),
    );
  }
}
