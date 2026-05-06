import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

/// Helper pour les traductions dans les écrans
extension TranslationHelper on BuildContext {
  /// Obtient la traduction d'une clé
  String translate(String key) {
    return read<AppTheme>().translate(key);
  }

  /// Obtient l'instance AppTheme pour écouter les changements
  AppTheme get appTheme => watch<AppTheme>();

  /// Obtient juste la langue actuelle
  String get currentLanguage => watch<AppTheme>().language;
}
