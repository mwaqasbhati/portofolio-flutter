import 'package:baraka_flutter/features/portfolio/data/models/balance_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/instrument_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';
import 'package:baraka_flutter/features/portfolio/data/models/position_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baraka_flutter/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:baraka_flutter/features/portfolio/domain/usecases/get_portfolio.dart';
import 'package:baraka_flutter/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:baraka_flutter/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:baraka_flutter/l10n/app_localizations.dart';
import 'package:baraka_flutter/features/portfolio/data/services/live_price_service.dart';

class FakePortfolioRepository implements PortfolioRepository {
  @override
  Future<PortfolioModel> getPortfolio() async {
    return PortfolioModel(
      balance: BalanceModel(netValue: 0, pnl: 0, pnlPercentage: 0),
      positions: [
        PositionModel(
          instrument: InstrumentModel(
            ticker: 'TEST',
            name: 'Test',
            exchange: 'X',
            currency: 'USD',
            lastTradedPrice: 0,
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
  testWidgets('Portfolio page shows positions', (WidgetTester tester) async {
    final repository = FakePortfolioRepository();
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => PortfolioBloc(
          getPortfolio: GetPortfolio(repository),
          priceService: FakeLivePriceService(),
        )..add(PortfolioFetched()),
        child: const MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [AppLocalizations.delegate],
          home: PortfolioPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Positions'), findsOneWidget);
  });

  testWidgets('Arabic locale shows translated text', (WidgetTester tester) async {
    final repository = FakePortfolioRepository();
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => PortfolioBloc(
          getPortfolio: GetPortfolio(repository),
          priceService: FakeLivePriceService(),
        )..add(PortfolioFetched()),
        child: const MaterialApp(
          locale: Locale('ar'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [AppLocalizations.delegate],
          home: PortfolioPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('المراكز'), findsOneWidget);
  });
}
