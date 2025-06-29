import 'package:baraka_flutter/features/portfolio/data/models/balance_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/instrument_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/position_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:baraka_flutter/features/portfolio/domain/usecases/get_portfolio.dart';
import 'package:baraka_flutter/features/portfolio/data/services/live_price_service.dart';
import 'package:baraka_flutter/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:baraka_flutter/features/portfolio/presentation/bloc/portfolio_bloc.dart';

class FakeGetPortfolio extends GetPortfolio {
  FakeGetPortfolio() : super(_FakeRepository());
}

class _FakeRepository implements PortfolioRepository {
  @override
  Future<PortfolioModel> getPortfolio() async {
    return PortfolioModel(
      balance: BalanceModel(netValue: 1, pnl: 2, pnlPercentage: 3),
      positions: [
        PositionModel(
          instrument: InstrumentModel(
            ticker: 'A',
            name: 'B',
            exchange: 'X',
            currency: 'USD',
            lastTradedPrice: 10,
          ),
          quantity: 1,
          averagePrice: 1,
          cost: 1,
          marketValue: 1,
          pnl: 0,
          pnlPercentage: 0,
        ),
      ],
    );
  }
}

class FakeLivePriceService implements LivePriceService {
  @override
  Stream<Map<String, double>> prices(List<InstrumentModel> instruments) =>
      const Stream.empty();
}

void main() {
  test('emits loading then loaded', () async {
    final bloc = PortfolioBloc(
      getPortfolio: FakeGetPortfolio(),
      priceService: FakeLivePriceService(),
    );
    final expectStates = <PortfolioState>[];
    final sub = bloc.stream.listen(expectStates.add);

    bloc.add(PortfolioFetched());
    await Future.delayed(Duration.zero);
    await bloc.close();
    await sub.cancel();

    expect(expectStates.length, 2);
    expect(expectStates.first, isA<PortfolioLoading>());
    expect(expectStates.last, isA<PortfolioLoaded>());
  });
}
