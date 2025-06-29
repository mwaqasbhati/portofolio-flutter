part of 'portfolio_bloc.dart';

abstract class PortfolioEvent {}

class PortfolioFetched extends PortfolioEvent {}

class _PricesUpdated extends PortfolioEvent {
  final Map<String, double> prices;
  _PricesUpdated(this.prices);
}
