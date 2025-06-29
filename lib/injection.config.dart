// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:baraka_flutter/di/register_module.dart' as _i26;
import 'package:baraka_flutter/features/portfolio/data/remote/portfolio_remote_data_source.dart'
    as _i555;
import 'package:baraka_flutter/features/portfolio/data/services/live_price_service.dart'
    as _i600;
import 'package:baraka_flutter/features/portfolio/data/repositories/portfolio_repository_impl.dart'
    as _i231;
import 'package:baraka_flutter/features/portfolio/domain/repositories/portfolio_repository.dart'
    as _i480;
import 'package:baraka_flutter/features/portfolio/domain/usecases/get_portfolio.dart'
    as _i129;
import 'package:baraka_flutter/features/portfolio/presentation/bloc/portfolio_bloc.dart'
    as _i1055;
import 'package:get_it/get_it.dart' as _i174;
import 'package:dio/dio.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i555.PortfolioRemoteDataSource>(
      () => _i555.PortfolioRemoteDataSource(gh<_i519.Dio>()),
    );
    gh.lazySingleton<_i600.LivePriceService>(() => _i600.LivePriceService());
    gh.lazySingleton<_i480.PortfolioRepository>(
      () =>
          _i231.PortfolioRepositoryImpl(gh<_i555.PortfolioRemoteDataSource>()),
    );
    gh.factory<_i129.GetPortfolio>(
      () => _i129.GetPortfolio(gh<_i480.PortfolioRepository>()),
    );
    gh.factory<_i1055.PortfolioBloc>(
      () => _i1055.PortfolioBloc(
        getPortfolio: gh<_i129.GetPortfolio>(),
        priceService: gh<_i600.LivePriceService>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i26.RegisterModule {}
