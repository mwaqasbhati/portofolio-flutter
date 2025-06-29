import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';

import '../repositories/portfolio_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPortfolio {
  final PortfolioRepository repository;

  GetPortfolio(this.repository);

  Future<PortfolioModel> call() {
    return repository.getPortfolio();
  }
}
