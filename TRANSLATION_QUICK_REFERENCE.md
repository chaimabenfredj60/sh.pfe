# Translation Implementation - Quick Reference Guide

## 🚀 Quick Start

### Step 1: Add Provider Watch to Screen
```dart
// In your screen's build method
final appTheme = context.watch<AppTheme>();
```

### Step 2: Use Translation
```dart
// Replace hardcoded text
Text(appTheme.translate('translation_key'))
```

### Step 3: Add Missing Keys to app_theme.dart
If a key doesn't exist, add it to the translations dictionary in both EN and FR

---

## 📋 Screen Status Quick Reference

| Screen | Status | Action |
|--------|--------|--------|
| dashboard_screen.dart | ⚠️ NEEDS SETUP | Add `context.watch<AppTheme>()` + 13 translations |
| profile_screen.dart | ⚠️ NEEDS SETUP | Add `context.watch<AppTheme>()` + 4 new keys |
| my_tasks_screen.dart | ✅ DONE | Just 2 text replacements |
| news_screen.dart | ⚠️ NEEDS SETUP | Add `context.watch<AppTheme>()` + 2 translations |
| events_screen.dart | ⚠️ NEEDS SETUP | Add `context.watch<AppTheme>()` + 4 translations |
| offer_list_screen.dart | ⚠️ NEEDS SETUP | Add `context.watch<AppTheme>()` + 3 translations |
| offer_detail_screen.dart | ⚠️ NEEDS SETUP | Add `context.watch<AppTheme>()` + 2 translations |
| chat_screen.dart | ✅ DONE | Already implemented |
| cra_screen.dart | ⚠️ PARTIAL | Add activity type translations (3 new keys) |
| my_cra_tracking_screen.dart | ✅ DONE | Extract enum labels to translate() |
| my_expenses_screen.dart | ✅ DONE | Extract category labels (4 new keys) |
| personalcalendar_screen.dart | ⚠️ PARTIAL | Add dialog labels (2 new keys) |
| postes_screen.dart | ✅ DONE | Use translate() for 3 strings |
| my_jackpot_screen.dart | ✅ DONE | Add financial labels (4 new keys) |
| my_feedbacks_screen.dart | ✅ DONE | Add status labels (3 new keys) |
| my_documents_screen.dart | ✅ DONE | Add status labels (3 new keys) |
| my_applications_screen.dart | ✅ DONE | Add status labels (4-5 new keys) |

---

## 🔧 Top Translation Keys Needed

### High Priority (Most Screens Use These)
```dart
'home'                    // Breadcrumb, navigation
'pages'                   // Breadcrumb
'coopt_employee'          // Button in events, feedback, documents
'read_more'               // News screen
'statistics'              // Dashboard
```

### Medium Priority (Dashboard & Forms)
```dart
'current_month'
'since_entry'
'total_ca'
'reserve'
'level_beginner'
'level_intermediate'
'level_advanced'
'level_expert'
```

### Lower Priority (Specific Screens)
```dart
// CRA
'activity_work'
'activity_absence'
'activity_travel'

// Expenses
'expense_transport'
'expense_meal'
'expense_accommodation'
'expense_other'

// Status labels
'status_validated'
'status_rejected'
'feedback_replied'
'feedback_unanswered'
'app_in_progress'
'app_accepted'
'app_rejected'
```

---

## 📝 Implementation Checklist

### Dashboard Screen
- [ ] Add import: `import 'package:provider/provider.dart';`
- [ ] Add: `final appTheme = context.watch<AppTheme>();`
- [ ] Replace 'Statistics' with translate
- [ ] Replace 'CURRENT MONTH' with translate
- [ ] Replace 'SINCE ENTRY' with translate
- [ ] Add 13 new translation keys to app_theme.dart

### Profile Screen
- [ ] Add import + watch()
- [ ] Replace hardcoded labels with translate()
- [ ] Add 4 new keys (beginner, intermediate, advanced, expert)

### My Tasks Screen
- [ ] Replace 'My Tasks' with translate('my_tasks')
- [ ] Replace 'Add Task' with translate('add_task')
- [ ] Done! ✅

### News Screen
- [ ] Add import + watch()
- [ ] Replace 'News' with translate
- [ ] Add 'read_more' key if needed
- [ ] Done! ✅

### Events Screen
- [ ] Add import + watch()
- [ ] Replace breadcrumb 'Home' with translate('home')
- [ ] Replace 'Actu & event' with translate('news_events')
- [ ] Add 'coopt_employee' key
- [ ] Done! ✅

### Offer List Screen
- [ ] Add import + watch()
- [ ] Replace filter labels with translate()
- [ ] Add sorting keys (rate_ascending, rate_descending)
- [ ] Done! ✅

### Offer Detail Screen
- [ ] Add import + watch()
- [ ] Replace button text with translate('apply')
- [ ] Done! ✅

### CRA Screen
- [ ] Update ActivityTypeExt to use translation keys
- [ ] Add 3 activity type keys

### Other Screens (Already have Provider)
- [ ] Extract enum extension labels
- [ ] Add missing translation keys
- [ ] Use translate() in label getters

---

## 💡 Common Patterns

### Pattern 1: AppBar Title
```dart
appBar: AppBar(
  title: Text(appTheme.translate('my_tasks')),
),
```

### Pattern 2: Button Label
```dart
ElevatedButton(
  child: Text(appTheme.translate('add_task')),
  onPressed: () {},
)
```

### Pattern 3: Form Label
```dart
Padding(
  padding: const EdgeInsets.only(bottom: 8),
  child: Text(
    appTheme.translate('first_name'),
    style: const TextStyle(
      color: _labelColor,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
  ),
)
```

### Pattern 4: Enum Extension
```dart
extension ActivityTypeExt on ActivityType {
  String getLabel(AppTheme appTheme) {
    switch (this) {
      case ActivityType.work:
        return appTheme.translate('activity_work');
      case ActivityType.absence:
        return appTheme.translate('activity_absence');
      case ActivityType.travel:
        return appTheme.translate('activity_travel');
    }
  }
}

// Usage:
Text(activity.getLabel(appTheme))
```

### Pattern 5: Status Label from Enum
```dart
extension CraStatusExt on CraStatus {
  String getLabel(AppTheme appTheme) {
    switch (this) {
      case CraStatus.validated:
        return appTheme.translate('status_validated');
      case CraStatus.pending:
        return appTheme.translate('pending');
      case CraStatus.rejected:
        return appTheme.translate('status_rejected');
    }
  }
}
```

---

## 🌐 All Required Translation Keys

Copy this into app_theme.dart's translation dictionary:

```dart
// Dashboard
'statistics': 'Statistics', // 'Statistiques'
'current_month': 'Current Month', // 'Mois courant'
'since_entry': 'Since Entry', // 'Depuis l\'entrée'
'total_ca': 'Total CA', // 'CA Total'
'reserve': 'Reserve', // 'Réserve'
'usable_reserve_ca': 'Usable Reserve (CA)', // 'Réserve utilisable (CA)'
'usable_reserve_days': 'Usable Reserve (in days)', // 'Réserve utilisable (en jours)'
'ca_since_entry': 'CA Since Entry', // 'CA depuis l\'entrée'
'reserve_since_entry': 'Reserve Since Entry', // 'Réserve depuis l\'entrée'
'usable_reserve_since_entry': 'Usable Reserve Since Entry', // 'Réserve utilisable depuis l\'entrée'
'usable_reserve_since_entry_days': 'Usable Reserve Since Entry (in days)', // 'Réserve utilisable depuis l\'entrée (en jours)'

// Navigation
'home': 'Home', // 'Accueil'
'pages': 'Pages', // 'Pages'

// Skills / Levels
'level_beginner': 'Beginner', // 'Débutant'
'level_intermediate': 'Intermediate', // 'Intermédiaire'
'level_advanced': 'Advanced', // 'Avancé'
'level_expert': 'Expert', // 'Expert'

// Actions & UI
'read_more': 'Read More', // 'Lire la suite'
'coopt_employee': 'Coopt a Talented Employee', // 'Coopter un employé talentueux'

// Filters
'rate_ascending': 'RATE ↑', // 'TARIF ↑'
'rate_descending': 'RATE ↓', // 'TARIF ↓'

// Offer Details
'offer_details': 'Offer Details', // 'Détails de l\'offre'

// Activities (CRA)
'activity_work': 'Work', // 'Travail'
'activity_absence': 'Absence', // 'Absence'
'activity_travel': 'Travel', // 'Déplacement'

// CRA Tracking
'total_submitted': 'Total Submitted', // 'Total soumis'
'status_validated': 'Validated', // 'Validé'
'status_rejected': 'Rejected', // 'Rejeté'
'rejected': 'Rejected', // 'Rejeté'

// Expenses
'expense_transport': 'Transport', // 'Transport'
'expense_meal': 'Meal', // 'Repas'
'expense_accommodation': 'Accommodation', // 'Hébergement'
'expense_other': 'Other', // 'Autre'

// Calendar
'add_note': 'Add Note', // 'Ajouter une note'
'your_note_hint': 'Your note...', // 'Votre note...'

// Postes
'add_poste': 'Add Poste', // 'Ajouter Poste'

// Jackpot
'total_jackpot': 'Total Jackpot', // 'Total Jackpot'
'total_gains': 'Total Gains', // 'Gains Total'
'total_withdrawals': 'Total Withdrawals', // 'Retraits Total'
'bonus_percent': 'Bonus %', // 'Bonus %'

// Feedback / Documents / Applications
'feedback_all': 'All', // 'Tous'
'feedback_replied': 'Replied', // 'Répondu'
'feedback_unanswered': 'Unanswered', // 'Sans réponse'
'document_requests': 'Document Requests', // 'Demandes de documents'
'requests': 'Requests', // 'Demandes'
'doc_all': 'All', // 'Tous'
'doc_replied': 'Replied', // 'Répondu'
'doc_unanswered': 'Unanswered', // 'Sans réponse'
'app_init': 'Pending Review', // 'En cours d\'examen'
'app_in_progress': 'In Progress', // 'En cours'
'app_accepted': 'Accepted', // 'Accepté'
'app_rejected': 'Rejected', // 'Rejeté'
```

---

## ⚡ Quick Commands for VSCode Find & Replace

### Find hardcoded English strings in a file:
1. Open Find (Ctrl+H)
2. Search for the literal string
3. Replace with `appTheme.translate('key')`

Example:
- Find: `'Statistics'`
- Replace with: `appTheme.translate('statistics')`

---

## 🐛 Troubleshooting

### "appTheme is not defined"
**Solution**: Make sure you added `final appTheme = context.watch<AppTheme>();` in the build method

### Translation key returns the key itself (not translated)
**Solution**: Check app_theme.dart - the key probably doesn't exist. Add it to both 'en' and 'fr' dictionaries

### Screen doesn't rebuild when language changes
**Solution**: Make sure you're using `context.watch<AppTheme>()` not just `Provider.of(context)`

### Enum extension labels still hardcoded
**Solution**: Create a new method in the extension that takes `AppTheme` as parameter and calls translate()

---

## 📞 Support

For questions:
1. Check the full TRANSLATION_IMPLEMENTATION_PLAN.md
2. Look at existing implementations (left_sidebar.dart, chat_screen.dart)
3. Review the CommonPatterns section above

---

Generated: May 4, 2026
