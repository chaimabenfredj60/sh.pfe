# Translation Implementation - Code Patches

Quick copy-paste ready patches for each screen file.

---

## 1. dashboard_screen.dart

### Step 1: Add Imports
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

### Step 2: Update _DashboardScreenState.build()
Add this line at the start:
```dart
final appTheme = context.watch<AppTheme>();
```

### Step 3: Replace Text Strings

**In _buildStatsSection():**
```dart
// BEFORE:
const Text(
  'Statistics',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
),

// AFTER:
Text(
  appTheme.translate('statistics'),
  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
),
```

**In _buildSectionLabel():**
```dart
// BEFORE:
_buildSectionLabel('CURRENT MONTH', '2026-3'),
_buildSectionLabel('SINCE ENTRY', null),

// AFTER:
_buildSectionLabel(appTheme.translate('current_month'), '2026-3'),
_buildSectionLabel(appTheme.translate('since_entry'), null),
```

**In _buildSectionLabel() method - update Text displays:**
```dart
// BEFORE:
Text('Total CA', ...)
Text('Reserve', ...)
Text('Usable Reserve (CA)', ...)
Text('Usable Reserve (in days)', ...)

// AFTER:
Text(appTheme.translate('total_ca'), ...)
Text(appTheme.translate('reserve'), ...)
Text(appTheme.translate('usable_reserve_ca'), ...)
Text(appTheme.translate('usable_reserve_days'), ...)
```

---

## 2. profile_screen.dart

### Step 1: Add Imports
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

### Step 2: Update build()
Add at start:
```dart
final appTheme = context.watch<AppTheme>();
```

### Step 3: Update _levels constant
```dart
// Replace this in the constant list used for skill levels:
// Instead of hardcoding 'Beginner', 'Intermediate', etc.
// Use: appTheme.translate('level_beginner'), etc.

// OR update the dropdown to translate on display:
String _translateLevel(String level) {
  switch (level) {
    case 'Beginner':
      return appTheme.translate('level_beginner');
    case 'Intermediate':
      return appTheme.translate('level_intermediate');
    case 'Advanced':
      return appTheme.translate('level_advanced');
    case 'Expert':
      return appTheme.translate('level_expert');
    default:
      return level;
  }
}

// Then in the dropdown, display using _translateLevel()
```

### Step 4: Update the _expanded map
```dart
// The section names in the _expanded map are only internal keys
// BUT in the UI they're displayed - update those displays:

// In _buildSection() or similar, replace:
// Text('Domain Skills') with Text(appTheme.translate('domain_skills'))
// Text('Experiences') with Text(appTheme.translate('experiences'))
// etc.
```

---

## 3. my_tasks_screen.dart

### Step 1: Simple Text Replacements

**In the AppBar:**
```dart
// BEFORE:
appBar: AppBar(
  title: const Text('My Tasks'),

// AFTER:
appBar: AppBar(
  title: Text(appTheme.translate('my_tasks')),
```

**In the Button:**
```dart
// BEFORE:
label: const Text('Add Task'),

// AFTER:
label: Text(appTheme.translate('add_task')),
```

**Done!** ✅ Just 2 changes, already has Provider set up.

---

## 4. news_screen.dart

### Step 1: Add Imports
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

### Step 2: Update build()
Add at start:
```dart
final appTheme = context.watch<AppTheme>();
```

### Step 3: Replace Title
```dart
// BEFORE:
title: const Text(
  'News',
  style: TextStyle(...),
),

// AFTER:
title: Text(
  appTheme.translate('news'),
  style: const TextStyle(...),
),
```

---

## 5. events_screen.dart

### Step 1: Add Imports
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

### Step 2: Update build()
Add at start:
```dart
final appTheme = context.watch<AppTheme>();
```

### Step 3: Update AppBar Title
```dart
// BEFORE:
title: const Text(
  'List of Events',
  style: TextStyle(...),
),

// AFTER:
title: Text(
  appTheme.translate('events'),
  style: const TextStyle(...),
),
```

### Step 4: Update "Coopt a Talented Employee" Button
```dart
// BEFORE:
label: const Text('Coopt a Talented Employee',

// AFTER:
label: Text(appTheme.translate('coopt_employee'),
```

### Step 5: Update Breadcrumbs
```dart
// BEFORE:
_crumb('Home'),
...
_crumb('Actu & event'),

// AFTER:
_crumb(appTheme.translate('home')),
...
_crumb(appTheme.translate('news_events')),
```

---

## 6. offer_list_screen.dart

### Step 1: Add Imports
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

### Step 2: Update build()
Add at start:
```dart
final appTheme = context.watch<AppTheme>();
```

### Step 3: Update Type Options Display
```dart
// If displaying type options like 'REMOTE', 'HYBRID', 'ON SITE':
// Create a helper method:
String _translateType(String type) {
  switch (type.toUpperCase()) {
    case 'REMOTE':
      return appTheme.translate('remote');
    case 'HYBRIDE':
    case 'HYBRID':
      return appTheme.translate('hybrid');
    case 'ON SITE':
      return appTheme.translate('on_site');
    default:
      return type;
  }
}
```

### Step 4: Update Filter Labels
```dart
// BEFORE:
{'value': 'RATE_ASC', 'label': 'RATE ↑'},
{'value': 'RATE_DESC', 'label': 'RATE ↓'},

// Create display method:
String _getSortLabel(String value) {
  switch (value) {
    case 'RATE_ASC':
      return appTheme.translate('rate_ascending');
    case 'RATE_DESC':
      return appTheme.translate('rate_descending');
    case 'START':
      return appTheme.translate('start_date');
    default:
      return value;
  }
}
```

---

## 7. offer_detail_screen.dart

### Step 1: Add Imports
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

### Step 2: Update build()
Add at start:
```dart
final appTheme = context.watch<AppTheme>();
```

### Step 3: Update TopBar Title
```dart
// BEFORE:
const Text("Offer Details"),

// AFTER:
Text(appTheme.translate('offer')),
```

### Step 4: Update Apply Button
```dart
// BEFORE:
child: const Text("Postuler"),

// AFTER:
child: Text(appTheme.translate('apply')),
```

---

## 8. chat_screen.dart

**✅ ALREADY DONE** - No changes needed!

---

## 9. cra_screen.dart

### Step 1: Update ActivityTypeExt
```dart
// BEFORE:
extension ActivityTypeExt on ActivityType {
  String get label {
    switch (this) {
      case ActivityType.work:
        return 'Work';
      case ActivityType.absence:
        return 'Absence';
      case ActivityType.travel:
        return 'Travel';
    }
  }
  
  // ... rest of code
}

// AFTER:
extension ActivityTypeExt on ActivityType {
  String getLabel(AppTheme appTheme) {  // Add appTheme parameter
    switch (this) {
      case ActivityType.work:
        return appTheme.translate('activity_work');
      case ActivityType.absence:
        return appTheme.translate('activity_absence');
      case ActivityType.travel:
        return appTheme.translate('activity_travel');
    }
  }
  
  Color get color {  // Keep this as is
    switch (this) {
      case ActivityType.work:
        return const Color(0xFF00B4A6);
      case ActivityType.absence:
        return const Color(0xFF3B82F6);
      case ActivityType.travel:
        return const Color(0xFFFF9800);
    }
  }
}
```

### Step 2: Update Usage
Wherever you used `activity.type.label`, change to:
```dart
// BEFORE:
Text(activity.type.label)

// AFTER:
Text(activity.type.getLabel(appTheme))
```

---

## 10. my_cra_tracking_screen.dart

### Step 1: Update CraStatusExt Extension
```dart
// BEFORE:
extension CraStatusExt on CraStatus {
  String get label {
    switch (this) {
      case CraStatus.validated:
        return 'Validé';
      case CraStatus.pending:
        return 'En attente';
      case CraStatus.rejected:
        return 'Rejeté';
    }
  }
  // ... color code follows
}

// AFTER:
extension CraStatusExt on CraStatus {
  String getLabel(AppTheme appTheme) {  // Add appTheme parameter
    switch (this) {
      case CraStatus.validated:
        return appTheme.translate('status_validated');
      case CraStatus.pending:
        return appTheme.translate('pending');
      case CraStatus.rejected:
        return appTheme.translate('status_rejected');
    }
  }
  
  Color get color {  // Keep color getter
    switch (this) {
      case CraStatus.validated:
        return const Color(0xFF4CAF50);
      case CraStatus.pending:
        return const Color(0xFFFF9800);
      case CraStatus.rejected:
        return const Color(0xFFEF4444);
    }
  }
}
```

### Step 2: Update Usage
```dart
// BEFORE:
Text(record.status.label)

// AFTER:
Text(record.status.getLabel(appTheme))
```

### Step 3: Update Hardcoded Labels
```dart
// BEFORE:
const Text('Total soumis', ...)
const Text('Validés', ...)
const Text('En attente', ...)

// AFTER:
Text(appTheme.translate('total_submitted'), ...)
Text(appTheme.translate('status_validated'), ...)
Text(appTheme.translate('pending'), ...)
```

---

## 11. my_expenses_screen.dart

### Step 1: Update ExpCatExt Extension
```dart
// BEFORE:
extension ExpCatExt on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.meal:
        return 'Repas';
      case ExpenseCategory.accommodation:
        return 'Hébergement';
      case ExpenseCategory.other:
        return 'Autre';
    }
  }
  
  // ... color and icon follow
}

// AFTER:
extension ExpCatExt on ExpenseCategory {
  String getLabel(AppTheme appTheme) {  // Add appTheme parameter
    switch (this) {
      case ExpenseCategory.transport:
        return appTheme.translate('expense_transport');
      case ExpenseCategory.meal:
        return appTheme.translate('expense_meal');
      case ExpenseCategory.accommodation:
        return appTheme.translate('expense_accommodation');
      case ExpenseCategory.other:
        return appTheme.translate('expense_other');
    }
  }
  
  Color get color {  // Keep these unchanged
    // ...
  }
  
  IconData get icon {  // Keep unchanged
    // ...
  }
}
```

### Step 2: Update Usage
```dart
// BEFORE:
Text(e.category.label)

// AFTER:
Text(e.category.getLabel(appTheme))
```

---

## 12. personalcalendar_screen.dart

### Step 1: Update Dialog Title
```dart
// BEFORE:
title: Text(
  'Ajouter une note',
  style: const TextStyle(...),
),

// AFTER:
title: Text(
  appTheme.translate('add_note'),
  style: const TextStyle(...),
),
```

### Step 2: Update Hint Text
```dart
// BEFORE:
hintText: 'Votre note…',

// AFTER:
hintText: appTheme.translate('your_note_hint'),
```

---

## 13. postes_screen.dart

### Step 1: Update Title
```dart
// BEFORE:
const Text('Poste List',

// AFTER:
Text(appTheme.translate('postes'),
```

### Step 2: Update Breadcrumbs
```dart
// BEFORE:
_crumb('Home'),

// AFTER:
_crumb(appTheme.translate('home')),
```

### Step 3: Update Button
```dart
// BEFORE:
label: const Text('Coopt a Talented Employee',

// AFTER:
label: Text(appTheme.translate('coopt_employee'),
```

### Step 4: Update Search Placeholder
```dart
// BEFORE:
hintText: 'Search',

// AFTER:
hintText: appTheme.translate('search'),
```

### Step 5: Update Add Button
```dart
// BEFORE:
label: const Text('Add Poste',

// AFTER:
label: Text(appTheme.translate('add_poste'),
```

---

## 14. my_jackpot_screen.dart

### Step 1: Find and Update Header Labels
In your `_buildHeader()` or similar method:

```dart
// BEFORE:
Column(
  children: [
    const Text('Total Jackpot'),
    const Text('Total Gains'),
    const Text('Total Withdrawals'),
    const Text('Bonus %'),
  ],
)

// AFTER:
Column(
  children: [
    Text(appTheme.translate('total_jackpot')),
    Text(appTheme.translate('total_gains')),
    Text(appTheme.translate('total_withdrawals')),
    Text(appTheme.translate('bonus_percent')),
  ],
)
```

---

## 15. my_feedbacks_screen.dart

### Step 1: Update Title
```dart
// BEFORE:
const Text('List of feed Back',

// AFTER:
Text(appTheme.translate('feedbacks'),
```

### Step 2: Update Status Tabs
```dart
// BEFORE:
_tab('all', 'All', FeedbackStatus.all),
_tab('replied', 'Replied', FeedbackStatus.replied),
_tab('unanswered', 'Unanswered', FeedbackStatus.unanswered),

// AFTER:
_tab('all', appTheme.translate('feedback_all'), FeedbackStatus.all),
_tab('replied', appTheme.translate('feedback_replied'), FeedbackStatus.replied),
_tab('unanswered', appTheme.translate('feedback_unanswered'), FeedbackStatus.unanswered),
```

### Step 3: Update Button
```dart
// BEFORE:
label: const Text('Coopt a Talented Employee',

// AFTER:
label: Text(appTheme.translate('coopt_employee'),
```

---

## 16. my_documents_screen.dart

### Step 1: Update Title
```dart
// BEFORE:
const Text('Document requests',

// AFTER:
Text(appTheme.translate('document_requests'),
```

### Step 2: Update Breadcrumbs
```dart
// BEFORE:
_crumb('Home'),
...
_crumb('Requests', active: true),

// AFTER:
_crumb(appTheme.translate('home')),
...
_crumb(appTheme.translate('requests'), active: true),
```

### Step 3: Update Status Tabs
```dart
// BEFORE:
_tab('all', 'All', DocStatus.all),
_tab('replied', 'Replied', DocStatus.replied),
_tab('unanswered', 'Unanswered', DocStatus.unanswered),

// AFTER:
_tab('all', appTheme.translate('doc_all'), DocStatus.all),
_tab('replied', appTheme.translate('doc_replied'), DocStatus.replied),
_tab('unanswered', appTheme.translate('doc_unanswered'), DocStatus.unanswered),
```

---

## 17. my_applications_screen.dart

### Step 1: Update Title
```dart
// BEFORE:
const Text('My Applications',

// AFTER:
Text(appTheme.translate('applications'),
```

### Step 2: Update AppStatusExt Extension
```dart
// BEFORE:
extension AppStatusExt on AppStatus {
  String get label {
    switch (this) {
      case AppStatus.init:
        return 'init';
      case AppStatus.inProgress:
        return 'In Progress';
      case AppStatus.accepted:
        return 'Accepted';
      case AppStatus.rejected:
        return 'Rejected';
    }
  }
  // ... color code follows
}

// AFTER:
extension AppStatusExt on AppStatus {
  String getLabel(AppTheme appTheme) {  // Add appTheme parameter
    switch (this) {
      case AppStatus.init:
        return appTheme.translate('app_init');
      case AppStatus.inProgress:
        return appTheme.translate('app_in_progress');
      case AppStatus.accepted:
        return appTheme.translate('app_accepted');
      case AppStatus.rejected:
        return appTheme.translate('app_rejected');
    }
  }
  
  Color get color {  // Keep color getter
    // ...
  }
}
```

### Step 3: Update PipelineStepExt Extension (similar pattern)
```dart
extension PipelineStepExt on PipelineStep {
  String getLabel(AppTheme appTheme) {
    switch (this) {
      case PipelineStep.received:
        return appTheme.translate('pipeline_received');
      case PipelineStep.underReview:
        return appTheme.translate('pipeline_under_review');
      case PipelineStep.interview:
        return appTheme.translate('pipeline_interview');
      case PipelineStep.hired:
        return appTheme.translate('pipeline_hired');
    }
  }
}
```

### Step 4: Update Breadcrumbs
```dart
// BEFORE:
_crumb('Home'),
_crumb('Pages'),

// AFTER:
_crumb(appTheme.translate('home')),
_crumb(appTheme.translate('pages')),
```

---

## Required app_theme.dart Additions

Add these to the 'en' and 'fr' dictionaries in app_theme.dart:

```dart
'en': {
  // ... existing keys ...
  'home': 'Home',
  'pages': 'Pages',
  'statistics': 'Statistics',
  'current_month': 'Current Month',
  'since_entry': 'Since Entry',
  'total_ca': 'Total CA',
  'reserve': 'Reserve',
  'usable_reserve_ca': 'Usable Reserve (CA)',
  'usable_reserve_days': 'Usable Reserve (in days)',
  'ca_since_entry': 'CA Since Entry',
  'reserve_since_entry': 'Reserve Since Entry',
  'usable_reserve_since_entry': 'Usable Reserve Since Entry',
  'usable_reserve_since_entry_days': 'Usable Reserve Since Entry (in days)',
  'level_beginner': 'Beginner',
  'level_intermediate': 'Intermediate',
  'level_advanced': 'Advanced',
  'level_expert': 'Expert',
  'read_more': 'Read More',
  'coopt_employee': 'Coopt a Talented Employee',
  'rate_ascending': 'RATE ↑',
  'rate_descending': 'RATE ↓',
  'offer_details': 'Offer Details',
  'activity_work': 'Work',
  'activity_absence': 'Absence',
  'activity_travel': 'Travel',
  'total_submitted': 'Total Submitted',
  'status_validated': 'Validated',
  'status_rejected': 'Rejected',
  'rejected': 'Rejected',
  'expense_transport': 'Transport',
  'expense_meal': 'Meal',
  'expense_accommodation': 'Accommodation',
  'expense_other': 'Other',
  'add_note': 'Add Note',
  'your_note_hint': 'Your note...',
  'add_poste': 'Add Poste',
  'total_jackpot': 'Total Jackpot',
  'total_gains': 'Total Gains',
  'total_withdrawals': 'Total Withdrawals',
  'bonus_percent': 'Bonus %',
  'feedback_all': 'All',
  'feedback_replied': 'Replied',
  'feedback_unanswered': 'Unanswered',
  'document_requests': 'Document Requests',
  'requests': 'Requests',
  'doc_all': 'All',
  'doc_replied': 'Replied',
  'doc_unanswered': 'Unanswered',
  'app_init': 'Pending Review',
  'app_in_progress': 'In Progress',
  'app_accepted': 'Accepted',
  'app_rejected': 'Rejected',
  'pipeline_received': 'Received',
  'pipeline_under_review': 'Under Review',
  'pipeline_interview': 'Interview',
  'pipeline_hired': 'Hired',
},
'fr': {
  // ... existing keys ...
  'home': 'Accueil',
  'pages': 'Pages',
  'statistics': 'Statistiques',
  'current_month': 'Mois courant',
  'since_entry': 'Depuis l\'entrée',
  'total_ca': 'CA Total',
  'reserve': 'Réserve',
  'usable_reserve_ca': 'Réserve utilisable (CA)',
  'usable_reserve_days': 'Réserve utilisable (en jours)',
  'ca_since_entry': 'CA depuis l\'entrée',
  'reserve_since_entry': 'Réserve depuis l\'entrée',
  'usable_reserve_since_entry': 'Réserve utilisable depuis l\'entrée',
  'usable_reserve_since_entry_days': 'Réserve utilisable depuis l\'entrée (en jours)',
  'level_beginner': 'Débutant',
  'level_intermediate': 'Intermédiaire',
  'level_advanced': 'Avancé',
  'level_expert': 'Expert',
  'read_more': 'Lire la suite',
  'coopt_employee': 'Coopter un employé talentueux',
  'rate_ascending': 'TARIF ↑',
  'rate_descending': 'TARIF ↓',
  'offer_details': 'Détails de l\'offre',
  'activity_work': 'Travail',
  'activity_absence': 'Absence',
  'activity_travel': 'Déplacement',
  'total_submitted': 'Total soumis',
  'status_validated': 'Validé',
  'status_rejected': 'Rejeté',
  'rejected': 'Rejeté',
  'expense_transport': 'Transport',
  'expense_meal': 'Repas',
  'expense_accommodation': 'Hébergement',
  'expense_other': 'Autre',
  'add_note': 'Ajouter une note',
  'your_note_hint': 'Votre note...',
  'add_poste': 'Ajouter Poste',
  'total_jackpot': 'Total Jackpot',
  'total_gains': 'Gains Total',
  'total_withdrawals': 'Retraits Total',
  'bonus_percent': 'Bonus %',
  'feedback_all': 'Tous',
  'feedback_replied': 'Répondu',
  'feedback_unanswered': 'Sans réponse',
  'document_requests': 'Demandes de documents',
  'requests': 'Demandes',
  'doc_all': 'Tous',
  'doc_replied': 'Répondu',
  'doc_unanswered': 'Sans réponse',
  'app_init': 'En cours d\'examen',
  'app_in_progress': 'En cours',
  'app_accepted': 'Accepté',
  'app_rejected': 'Rejeté',
  'pipeline_received': 'Reçu',
  'pipeline_under_review': 'En examen',
  'pipeline_interview': 'Entretien',
  'pipeline_hired': 'Embauché',
},
```

---

## Implementation Order (Recommended)

1. **First**: Add all translation keys to app_theme.dart
2. **Second**: Implement screens needing Provider setup (dashboard, profile, news, events, offer_detail)
3. **Third**: Update simple text replacements (my_tasks, postes)
4. **Fourth**: Extract enum extensions (cra, expenses, applications, feedbacks, documents)
5. **Finally**: Test all screens with language toggle

---

Generated: May 4, 2026
Each patch is ready to copy-paste!
