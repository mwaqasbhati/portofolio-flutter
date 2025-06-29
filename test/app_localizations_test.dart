import 'package:flutter_test/flutter_test.dart';
import 'package:baraka_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  test('Arabic translation is returned', () {
    final l10n = AppLocalizations(const Locale('ar'));
    expect(l10n.positions, 'المراكز');
  });
}
