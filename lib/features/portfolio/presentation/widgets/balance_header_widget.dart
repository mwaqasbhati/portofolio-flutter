import 'package:flutter/material.dart';
import '../../../../core/utils/pnl_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/balance_entity.dart';
import '../../../../main.dart';
import '../../../../core/utils/locale_utils.dart';
import '../../../../core/theme/app_theme.dart';

class BalanceHeaderWidget extends StatelessWidget {
  final BalanceEntity balance;

  const BalanceHeaderWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Use common colors for profit/loss values
    final pnlColor = PnlColors.forValue(balance.isProfit);

    return Container(
      color: AppTheme.headerBackground(context),
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Row(
          children: [
            Expanded(child: Row(children: [
              CircleAvatar(
                backgroundColor: AppTheme.onSurfaceColor(context),
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 12),
              const Text(
                "John Doe",
                style: AppTheme.boldText,
              ),
            ],)),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.buttonColor,
                  ),
                  onPressed: () {
                    MyApp.setLocale(context, LocaleUtils.toggledLocale(context));
                  },
                  child: Text(LocaleUtils.toggleButtonText(context)),
                );
              },
            ),
          ],
        ),

        Row(mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                balance.netValueDisplay,
                style: AppTheme.headerValueStyle,
              ),
              const SizedBox(height: 4),
              Text(l10n.netValue),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  text: '${balance.pnlValueDisplay} ',
                  style: AppTheme.headerValueStyle,
                  children: [
                    TextSpan(
                      text: balance.pnlPercentageDisplay,
                      style: TextStyle(color: pnlColor),
                    ),
                  ],
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(height: 4),
              Text(l10n.pnl),
            ],
          ),
        ],)

      ],),
    );
  }
}
