import 'package:go_router/go_router.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/portfolio/presentation/pages/position_details_page.dart';
import '../../features/portfolio/domain/entities/position_entity.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'portfolio',
      builder: (context, state) => const PortfolioPage(),
      routes: [
        GoRoute(
          path: 'position',
          name: 'position',
          builder: (context, state) {
            final position = state.extra as PositionEntity?;
            if (position == null) {
              return const PortfolioPage();
            }
            return PositionDetailsPage(position: position);
          },
        ),
      ],
    ),
  ],
);
