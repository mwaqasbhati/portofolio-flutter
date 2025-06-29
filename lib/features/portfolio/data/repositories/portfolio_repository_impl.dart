import 'package:baraka_flutter/features/portfolio/data/models/portfolio_model.dart';

import '../../domain/repositories/portfolio_repository.dart';
import '../remote/portfolio_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PortfolioRepository)
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl(this.remoteDataSource);

  @override
  Future<PortfolioModel> getPortfolio() {
    return remoteDataSource.getPortfolio();
  }
}
