import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';

import 'balance_entity.dart';
import 'position_entity.dart';

/// Entity representing portfolio data for the UI.
class PortfolioEntity {
  final BalanceEntity balance;
  final List<PositionEntity> positions;

  PortfolioEntity({required this.balance, required this.positions});

  factory PortfolioEntity.fromEntity(PortfolioModel portfolio) {
    return PortfolioEntity(
      balance: BalanceEntity.fromModel(portfolio.balance),
      positions:
          portfolio.positions.map(PositionEntity.fromEntity).toList(growable: false),
    );
  }
}
