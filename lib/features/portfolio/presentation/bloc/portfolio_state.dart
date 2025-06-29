part of 'portfolio_bloc.dart';

abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final PortfolioEntity portfolio;
  PortfolioLoaded(this.portfolio);
}

class PortfolioError extends PortfolioState {
  final String message;
  PortfolioError(this.message);
}
