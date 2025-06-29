import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';


abstract class PortfolioRepository {
  Future<PortfolioModel> getPortfolio();
}
