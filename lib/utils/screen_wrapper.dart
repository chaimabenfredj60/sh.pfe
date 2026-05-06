import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

/// Helper pour envelopper les écrans et les connecter au Provider
class ScreenWrapper extends StatelessWidget {
  final Widget Function(bool isDarkMode, String language) screenBuilder;

  const ScreenWrapper({
    required this.screenBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) {
        return screenBuilder(appTheme.isDarkMode, appTheme.language);
      },
    );
  }
}
