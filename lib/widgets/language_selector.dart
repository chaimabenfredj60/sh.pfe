import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

class LanguageSelector extends StatelessWidget {
  final bool isCompact; // For use in top bar

  const LanguageSelector({
    super.key,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) {
        if (isCompact) {
          // Compact version for top bar
          return PopupMenuButton<String>(
            onSelected: (String value) {
              appTheme.setLanguage(value);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'en',
                child: Row(
                  children: [
                    appTheme.language == 'en'
                        ? const Icon(Icons.check, color: Color(0xFF1F4788))
                        : const SizedBox(width: 24),
                    const SizedBox(width: 8),
                    const Text('English'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'fr',
                child: Row(
                  children: [
                    appTheme.language == 'fr'
                        ? const Icon(Icons.check, color: Color(0xFF1F4788))
                        : const SizedBox(width: 24),
                    const SizedBox(width: 8),
                    const Text('Français'),
                  ],
                ),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.language, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    appTheme.language.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Full version for settings or dedicated section
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildLanguageButton(
                      context,
                      'EN',
                      'en',
                      appTheme,
                    ),
                    const SizedBox(width: 8),
                    _buildLanguageButton(
                      context,
                      'FR',
                      'fr',
                      appTheme,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildLanguageButton(
    BuildContext context,
    String label,
    String langCode,
    AppTheme appTheme,
  ) {
    final isSelected = appTheme.language == langCode;

    return ElevatedButton(
      onPressed: () => appTheme.setLanguage(langCode),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? const Color(0xFF1F4788) : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : Colors.grey,
        side: BorderSide(
          color: isSelected ? const Color(0xFF1F4788) : Colors.grey.shade300,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label),
    );
  }
}
