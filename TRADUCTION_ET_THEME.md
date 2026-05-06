## Mise à jour globale de la traduction et du mode sombre pour toute l'app

### Étapes complétées ✅

1. **AppTheme Provider** - Centralisé avec traductions complètes
2. **main.dart** - Intégration de Provider avec AppTheme
3. **AppShell** - Convertie pour utiliser Provider et passer isDarkMode/language à tous les écrans
4. **ProfileScreen** - Supports complets du thème dark/light
5. **FeedbackDialog** - Support de la traduction
6. **TopBar** - Support de sélection langue et mode sombre
7. **ThemeColors utility** - Couleurs centralisées
8. **ScreenTranslations** - Traductions pour tous les écrans

### Modèle de mise à jour pour chaque écran

Voici un modèle pour mettre à jour rapidement chaque écran :

```dart
// AVANT
class MonEcran extends StatefulWidget {
  const MonEcran({super.key});
  @override
  State<MonEcran> createState() => _MonEcranState();
}

// APRÈS
class MonEcran extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MonEcran({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });
  @override
  State<MonEcran> createState() => _MonEcranState();
}
```

Dans la classe State, ajouter :
```dart
String _translate(String key) {
  return AppTheme().translate(key); // Utilise la langue passée via Provider
}

Color _bgColor => ThemeColors.getBgColor(widget.isDarkMode);
Color _textColor => ThemeColors.getTextColor(widget.isDarkMode);
Color _borderColor => ThemeColors.getBorderColor(widget.isDarkMode);
```

Puis remplacer tous les hardcoded colors :
- `Colors.white` → `_bgColor`
- `Colors.black` → `_textColor`
- `Colors.grey[300]` → `_borderColor`

### Scripts pour mettre à jour rapidement

Pour chaque écran, il suffit de :
1. Ajouter les paramètres isDarkMode et language au constructeur
2. Ajouter la méthode _translate()
3. Remplacer les couleurs hardcodées
4. Utiliser _translate('clé') pour tous les textes

### Écrans à mettre à jour

Les écrans suivants nécessitent la même mise à jour :
- [ ] offer_list_screen.dart
- [ ] cra_screen.dart
- [ ] my_cra_tracking_screen.dart
- [ ] my_expenses_screen.dart
- [ ] personalcalendar_screen.dart
- [ ] my_tasks_screen.dart
- [ ] news_screen.dart
- [ ] events_screen.dart
- [ ] my_jackpot_screen.dart
- [ ] my_applications_screen.dart
- [ ] postes_screen.dart
- [ ] chat_screen.dart
- [ ] my_feedbacks_screen.dart
- [ ] my_documents_screen.dart

### État de compilation

L'app devrait maintenant :
1. Compiler avec Provider intégré
2. Afficher le sélecteur de langue dans TopBar
3. Afficher le bouton de mode sombre dans TopBar
4. Permettre l'échange de langue en temps réel
5. Permettre le changement de thème en temps réel

Les écrans qui n'ont pas encore les mises à jour afficheront simplement le thème par défaut,
mais l'app restera fonctionnelle.
