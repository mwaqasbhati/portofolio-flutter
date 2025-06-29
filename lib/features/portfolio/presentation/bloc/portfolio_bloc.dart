import 'dart:async';

import 'package:baraka_flutter/features/portfolio/data/models/balance_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/instrument_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/position_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/portfolio_entity.dart';
import '../../domain/usecases/get_portfolio.dart';
import '../../data/services/live_price_service.dart';
import 'package:injectable/injectable.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

@injectable
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolio getPortfolio;
  final LivePriceService priceService;
  StreamSubscription<Map<String, double>>? _priceSub;
  PortfolioModel? _portfolio;

  PortfolioBloc({required this.getPortfolio, required this.priceService})
      : super(PortfolioInitial()) {
    on<PortfolioFetched>(_onFetched);
    on<_PricesUpdated>(_onPricesUpdated);
  }

  Future<void> _onFetched(
      PortfolioFetched event, Emitter<PortfolioState> emit) async {
    emit(PortfolioLoading());
    try {
      final portfolio = await getPortfolio();
      _portfolio = portfolio;
      emit(PortfolioLoaded(PortfolioEntity.fromEntity(portfolio)));
      _priceSub?.cancel();
      _priceSub = priceService
          .prices(portfolio.positions.map((e) => e.instrument).toList())
          .listen((prices) => add(_PricesUpdated(prices)));
    } catch (e) {
      emit(PortfolioError(e.toString()));
    }
  }

  void _onPricesUpdated(
      _PricesUpdated event, Emitter<PortfolioState> emit) {
    if (_portfolio == null || state is! PortfolioLoaded) return;

    final updatedPositions = _portfolio!.positions.map((p) {
      final price = event.prices[p.instrument.ticker] ?? p.instrument.lastTradedPrice;
      final instrument = InstrumentModel(
        ticker: p.instrument.ticker,
        name: p.instrument.name,
        exchange: p.instrument.exchange,
        currency: p.instrument.currency,
        lastTradedPrice: price,
      );
      final marketValue = p.quantity * price;
      final pnl = marketValue - p.cost;
      final pnlPercentage = (pnl * 100) / p.cost;
      return PositionModel(
        instrument: instrument,
        quantity: p.quantity,
        averagePrice: p.averagePrice,
        cost: p.cost,
        marketValue: marketValue,
        pnl: pnl,
        pnlPercentage: pnlPercentage,
      );
    }).toList();

    final netValue =
        updatedPositions.fold<double>(0, (sum, p) => sum + p.marketValue);
    final pnl = updatedPositions.fold<double>(0, (sum, p) => sum + p.pnl);
    final cost = updatedPositions.fold<double>(0, (sum, p) => sum + p.cost);

    final balance = BalanceModel(
      netValue: netValue,
      pnl: pnl,
      pnlPercentage: cost != 0 ? (pnl * 100) / cost : 0,
    );
    _portfolio = PortfolioModel(balance: balance, positions: updatedPositions);
    emit(PortfolioLoaded(PortfolioEntity.fromEntity(_portfolio!)));
  }

  @override
  Future<void> close() {
    _priceSub?.cancel();
    return super.close();
  }
}
