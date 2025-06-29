import 'package:flutter/material.dart';
import '../widgets/portfolio_view.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/ui_helpers.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: PortfolioView(
        onError: (context, message) => UiHelper.showErrorDialog(
          context,
          title: l10n.error,
          message: message,
        ),
      ),
    );
  }
}
