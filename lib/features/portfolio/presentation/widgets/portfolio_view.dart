import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/portfolio_bloc.dart';
import 'balance_header_widget.dart';
import 'position_item.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/balance_entity.dart';
import '../../../../core/theme/app_theme.dart';

class PortfolioView extends StatefulWidget {
  final void Function(BuildContext context, String message) onError;

  const PortfolioView({super.key, required this.onError});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PortfolioBloc>().add(PortfolioFetched());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<PortfolioBloc, PortfolioState>(
      listener: (context, state) {
        if (state is PortfolioError) {
          widget.onError(context, state.message);
        }
      },
      child: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state is PortfolioLoading) {
            return const _PortfolioLoadingView();
          } else if (state is PortfolioError) {
            return Center(child: Text('${l10n.error}: ${state.message}'));
          } else if (state is PortfolioLoaded) {
            final portfolio = state.portfolio;
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _BalanceHeaderDelegate(portfolio.balance),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => PositionItem(
                        position: portfolio.positions[index],
                      ),
                      childCount: portfolio.positions.length,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _BalanceHeaderDelegate extends SliverPersistentHeaderDelegate {
  final BalanceEntity balance;
  final double _extent;

  _BalanceHeaderDelegate(this.balance, {double extent = 220}) : _extent = extent;

  @override
  double get maxExtent => _extent;

  @override
  double get minExtent => _extent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 2 : 0,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _extent,
          child: BalanceHeaderWidget(balance: balance),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _BalanceHeaderDelegate oldDelegate) {
    return oldDelegate.balance != balance || oldDelegate._extent != _extent;
  }
}

class _PortfolioLoadingView extends StatelessWidget {
  const _PortfolioLoadingView();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _ShimmerHeaderDelegate(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => const _ShimmerBox(height: 100),
            childCount: 5,
          ),
        ),
      ],
    );
  }
}

class _ShimmerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _height = 220;

  @override
  double get maxExtent => _height;

  @override
  double get minExtent => _height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: _height,
      child: const SafeArea(
        bottom: false,
        child: _ShimmerBox(height: 160, margin: EdgeInsets.zero),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _ShimmerHeaderDelegate oldDelegate) => false;
}

class _ShimmerBox extends StatelessWidget {
  final double height;
  final EdgeInsets margin;

  const _ShimmerBox({
    required this.height,
    this.margin = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Shimmer.fromColors(
        baseColor: AppTheme.shimmerBaseColor,
        highlightColor: AppTheme.shimmerHighlightColor,
        child: Container(
          height: height,
          width: double.infinity,
          color: AppTheme.backgroundColor(context),
        ),
      ),
    );
  }
}
