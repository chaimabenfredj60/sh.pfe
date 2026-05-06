# Flutter Translation Implementation Plan

**Date**: May 4, 2026  
**Status**: Analysis Complete  
**Scope**: 17 Screen Files Analyzed

---

## Executive Summary

This document provides a comprehensive plan to add translation support to all screen files using the existing `AppTheme.translate()` method. The analysis identified:

- **12 screens** already using `Consumer<AppTheme>` or `context.watch<AppTheme>()`
- **5 screens** that need the translation provider wrapper added
- **~150+ hardcoded strings** that need to be replaced with translation keys
- **Recommended approach**: Use `context.watch<AppTheme>()` pattern (simpler than Consumer)

---

## Current Translation Infrastructure

### Translation Method Signature
```dart
String translate(String key)
```

### Supported Languages
- `en` - English
- `fr` - French

### Available Translation Keys (90+)
Dashboard, Offer, RH, Personal, News, Jackpot, Applications, Communication, Profile, Logout, My CRA, My Expenses, Calendar, My Tasks, News & Events, Job Offers, Chats, Feedbacks, Documents, Send Feedback, First Name, Last Name, Category, Phone, Email, Daily Role, Summary, General Information, Domain Skills, Professional Skills, Experiences, Technical Skills, Education History, Languages, Certifications, Training, Save, Add New, No Items, Offers, Apply, CRA Tracking, Events, Cooptation, Challenge, Results, Add Task, My News, Delete, Edit, Close, Cancel, Search, No Data, Error, Success, Loading, Empty, Back, Next, Previous, View All, More, Less, Yes, No, OK, Company, Location, Price, Type, Remote, Hybrid, On Site, Rate, Description, Posted On, Start Date, Experience, Candidates, Expired, Active, Pending, Completed, In Progress, Online, Offline, Message, Send Message, Type Message, Document, Upload, Download, Delete Confirm, Expense, Amount, Date, Description Short, Status, No Conversations, No Documents, No Expenses

---

## Implementation Pattern

### Standard Pattern (Recommended)
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

class YourScreen extends StatefulWidget {
  @override
  State<YourScreen> createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();  // Get theme provider
    
    return Scaffold(
      appBar: AppBar(
        title: Text(appTheme.translate('translation_key')),  // Use translate method
      ),
    );
  }
}
```

### Alternative Pattern (For Complex Widgets)
```dart
return Consumer<AppTheme>(
  builder: (context, appTheme, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTheme.translate('translation_key')),
      ),
    );
  },
);
```

---

## Screen-by-Screen Implementation Guide

### 1. **dashboard_screen.dart** ⚠️ NEEDS IMPLEMENTATION

**Current Status**: No translation support, all hardcoded English text

**Import Changes Required**:
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

**Build Method Update**:
```dart
@override
Widget build(BuildContext context) {
  final appTheme = context.watch<AppTheme>();
  // Rest of build method follows
}
```

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Notes |
|---|---|---|
| 'Statistics' | ⚠️ **NEW KEY NEEDED**: 'statistics' | Add to app_theme.dart |
| '2026' | N/A | Date value - keep as is |
| 'CURRENT MONTH' | ⚠️ **NEW KEY NEEDED**: 'current_month' | Add to app_theme.dart |
| 'SINCE ENTRY' | ⚠️ **NEW KEY NEEDED**: 'since_entry' | Add to app_theme.dart |
| 'Total CA' | ⚠️ **NEW KEY NEEDED**: 'total_ca' | Add to app_theme.dart |
| 'Reserve' | ⚠️ **NEW KEY NEEDED**: 'reserve' | Add to app_theme.dart |
| 'Usable Reserve (CA)' | ⚠️ **NEW KEY NEEDED**: 'usable_reserve_ca' | Add to app_theme.dart |
| 'Usable Reserve (in days)' | ⚠️ **NEW KEY NEEDED**: 'usable_reserve_days' | Add to app_theme.dart |
| 'CA Since Entry' | ⚠️ **NEW KEY NEEDED**: 'ca_since_entry' | Add to app_theme.dart |
| 'Reserve Since Entry' | ⚠️ **NEW KEY NEEDED**: 'reserve_since_entry' | Add to app_theme.dart |
| 'Usable Reserve Since Entry' | ⚠️ **NEW KEY NEEDED**: 'usable_reserve_since_entry' | Add to app_theme.dart |
| 'Usable Reserve Since Entry (in days)' | ⚠️ **NEW KEY NEEDED**: 'usable_reserve_since_entry_days' | Add to app_theme.dart |

**Special Considerations**:
- This screen contains many financial metrics - consider adding a complete 'dashboard' section to translations
- Multiple hardcoded section headers ('Congratulations Banner', 'Cooptation Evolution', 'Scoring', 'Donut', 'Evolution Application', 'Jackpot Report', 'Leader Board', 'Footer')
- Numeric values (0,00 €, days) should remain unformatted but labels should be translated

**Estimated Changes**: ~15-20 string replacements

---

### 2. **profile_screen.dart** ⚠️ NEEDS IMPLEMENTATION

**Current Status**: No translation support, uses hardcoded English labels

**Import Changes Required**:
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

**Build Method Update**:
```dart
@override
Widget build(BuildContext context) {
  final appTheme = context.watch<AppTheme>();
  // Rest of build method follows
}
```

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'Domain Skills' | 'domain_skills' | ✅ EXISTS |
| 'Fonctionel Skills' | 'professional_skills' | ✅ EXISTS |
| 'Experiences' | 'experiences' | ✅ EXISTS |
| 'Technical Skills' | 'technical_skills' | ✅ EXISTS |
| 'Education history' | 'education_history' | ✅ EXISTS |
| 'Languages' | 'languages' | ✅ EXISTS |
| 'Certifications' | 'certifications' | ✅ EXISTS |
| 'Training' | 'training' | ✅ EXISTS |
| 'Beginner' | ⚠️ **NEW KEY NEEDED**: 'level_beginner' | Add to app_theme.dart |
| 'Intermediate' | ⚠️ **NEW KEY NEEDED**: 'level_intermediate' | Add to app_theme.dart |
| 'Advanced' | ⚠️ **NEW KEY NEEDED**: 'level_advanced' | Add to app_theme.dart |
| 'Expert' | ⚠️ **NEW KEY NEEDED**: 'level_expert' | Add to app_theme.dart |

**Special Considerations**:
- Skill level dropdown needs 4 new translation keys (Beginner, Intermediate, Advanced, Expert)
- This screen has expandable sections with pre-defined section names
- Consider creating a consistent naming pattern for skill levels across the app

**Estimated Changes**: ~10-12 string replacements (plus 4 new translation keys)

---

### 3. **my_tasks_screen.dart** ⚠️ PARTIALLY IMPLEMENTED

**Current Status**: Already imports Provider, but only uses `context.watch<AppTheme>()` without calling translate()

**Import Changes Required**: Already has correct imports ✅

**Build Method Update**: Already uses `context.watch<AppTheme>()` ✅

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'My Tasks' | 'my_tasks' | ✅ EXISTS |
| 'Add Task' | 'add_task' | ✅ EXISTS |

**Special Considerations**:
- Already well-structured with proper provider usage
- Only 2 main hardcoded strings need replacement
- Task filtering logic uses internal enum names (MyTasks, Important, Completed, Deleted) - these should remain as UI values, not translated

**Estimated Changes**: 2 simple string replacements

---

### 4. **news_screen.dart** ⚠️ NEEDS IMPLEMENTATION

**Current Status**: No translation support, hardcoded English text for titles and buttons

**Import Changes Required**:
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

**Build Method Update**:
```dart
@override
Widget build(BuildContext context) {
  final appTheme = context.watch<AppTheme>();
  // Rest of build method follows
}
```

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'News' (AppBar title) | 'news' | ✅ EXISTS |
| 'Read More' button | ⚠️ **NEW KEY NEEDED**: 'read_more' | Add to app_theme.dart |
| Article title: 'Launch of Cooptalite' | N/A | Content - keep as is |
| Article title: 'Bonne Année 2025' | N/A | Content - keep as is |

**Special Considerations**:
- News content (article titles and body) should remain as hardcoded content (not translatable)
- Only UI buttons and labels should use translation keys
- "Read More" button is missing from current translation dictionary

**Estimated Changes**: 2-3 string replacements

---

### 5. **events_screen.dart** ⚠️ NEEDS IMPLEMENTATION

**Current Status**: No translation support, hardcoded English UI text

**Import Changes Required**:
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

**Build Method Update**:
```dart
@override
Widget build(BuildContext context) {
  final appTheme = context.watch<AppTheme>();
  // Rest of build method follows
}
```

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'List of Events' (AppBar) | 'events' | ✅ EXISTS |
| 'Coopt a Talented Employee' (button) | ⚠️ **NEW KEY NEEDED**: 'coopt_employee' | Add to app_theme.dart |
| 'Home' (breadcrumb) | ⚠️ **NEW KEY NEEDED**: 'home' | Add to app_theme.dart |
| 'Actu & event' (breadcrumb) | ⚠️ **NEW KEY NEEDED**: 'news_events' | EXISTS as 'news_events' |
| 'Title Search :' | 'search' | ✅ EXISTS (use 'title_search') |

**Special Considerations**:
- Breadcrumb navigation should use consistent translation keys
- "Home" is likely used across multiple screens - add as common translation key
- Event data (dates, titles) are content - keep as hardcoded demo data

**Estimated Changes**: 4-5 string replacements

---

### 6. **offer_list_screen.dart** ⚠️ NEEDS IMPLEMENTATION

**Current Status**: No translation support, uses hardcoded English text throughout

**Import Changes Required**:
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

**Build Method Update** (in Offer widget builder):
```dart
@override
Widget build(BuildContext context) {
  final appTheme = context.watch<AppTheme>();
  // Rest of build method follows
}
```

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'REMOTE' | 'remote' | ✅ EXISTS |
| 'HYBRIDE' / 'HYBRID' | 'hybrid' | ✅ EXISTS |
| 'ON SITE' | 'on_site' | ✅ EXISTS |
| Filter category options | Multiple keys | Category names are hardcoded - add as needed |
| 'RATE ↑' | ⚠️ **NEW KEY NEEDED**: 'rate_ascending' | Add to app_theme.dart |
| 'RATE ↓' | ⚠️ **NEW KEY NEEDED**: 'rate_descending' | Add to app_theme.dart |
| Skill options | N/A | Keep as hardcoded list |
| Offer titles, descriptions | N/A | Content - keep as is |

**Special Considerations**:
- This screen has many constants and list options - category, contract, and skill options
- Consider whether filter labels should be translated - they appear to be technical filters
- Offer content (titles, descriptions) is demo data - keep as is
- Type options (CDI, CDD, FREELANCE, PARTTIME) - unclear if these should be translated as they are contract type abbreviations

**Estimated Changes**: 5-8 string replacements

---

### 7. **offer_detail_screen.dart** ⚠️ NEEDS IMPLEMENTATION

**Current Status**: No translation support, hardcoded English text

**Import Changes Required**:
```dart
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
```

**Build Method Update**:
```dart
@override
Widget build(BuildContext context) {
  final appTheme = context.watch<AppTheme>();
  // Rest of build method follows
}
```

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| "Offer Details" (top bar) | 'offer' or ⚠️ **NEW**: 'offer_details' | Add to app_theme.dart if needed |
| "Détails de l'offre" (header) | ⚠️ **NEW KEY NEEDED**: 'offer_details_fr' | FR content - keep as is or use shared key |
| "Postuler" (Apply button) | 'apply' | ✅ EXISTS |

**Special Considerations**:
- This component shows offer details - content (title, company, description) is display data
- Button text "Postuler" is currently French - should use translation key 'apply'
- Only UI buttons and labels need translation, not content

**Estimated Changes**: 2-3 string replacements

---

### 8. **chat_screen.dart** ✅ PARTIALLY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Import Changes Required**: Already present ✅

**Build Method Update**: Already correct ✅

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| Contact names (SuperAdmin, Gestion, etc.) | N/A | Content - keep as is |
| Message content | N/A | Content - keep as is |

**Special Considerations**:
- This screen is well-implemented with Provider already active
- Contact data and messages are content/state - keep as is
- No UI string translation needed at this time

**Estimated Changes**: 0 changes (already implemented)

---

### 9. **cra_screen.dart** ⚠️ PARTIAL

**Current Status**: Imports Provider but needs `context.watch<AppTheme>()` in build method

**Import Changes Required**: Already present ✅

**Build Method Update Required**:
```dart
@override
Widget build(BuildContext context) {
  final appTheme = context.watch<AppTheme>();  // ADD THIS
  // Rest of build method
}
```

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'Work' | ⚠️ **NEW KEY NEEDED**: 'activity_work' | Add to app_theme.dart |
| 'Absence' | ⚠️ **NEW KEY NEEDED**: 'activity_absence' | Add to app_theme.dart |
| 'Travel' | ⚠️ **NEW KEY NEEDED**: 'activity_travel' | Add to app_theme.dart |
| 'Congé annuel de Pâques' | N/A | Content - keep as is |
| 'Déplacement client' | N/A | Content - keep as is |
| 'Chèque de travail' | N/A | Content - keep as is |

**Special Considerations**:
- Activity type labels need translation - currently hardcoded in extension
- Calendar demo data (dates, descriptions) should remain as is
- Activity type enum extension should use translated labels via appTheme

**Estimated Changes**: 3 new translation keys + code to use them in the extension

---

### 10. **my_cra_tracking_screen.dart** ✅ ALREADY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Hardcoded Strings Analysis**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'My CRA Tracking' (title) | 'cra_tracking' | ✅ EXISTS |
| 'Historique de vos comptes rendus d\'activité' | ⚠️ **NEW**: 'cra_history_subtitle' | Add if needed |
| 'Total soumis' | ⚠️ **NEW**: 'total_submitted' | Add to app_theme.dart |
| 'Validés' | ⚠️ **NEW**: 'validated' or 'approved' | Add to app_theme.dart |
| 'En attente' | 'pending' | ✅ EXISTS |
| 'Rejetés' | ⚠️ **NEW**: 'rejected' or 'declined' | Add to app_theme.dart |
| 'Validé' | ⚠️ **NEW**: 'status_validated' | Add to app_theme.dart |
| 'En attente' | 'pending' | ✅ EXISTS |
| 'Rejeté' | ⚠️ **NEW**: 'status_rejected' | Add to app_theme.dart |

**Special Considerations**:
- Already has Provider setup
- Status labels are hardcoded in CraStatusExt enum extension - should be externalized to translation keys
- Some labels exist but with different names (pending) - check consistency

**Estimated Changes**: Extract 3-4 status labels to use appTheme.translate()

---

### 11. **my_expenses_screen.dart** ✅ ALREADY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Hardcoded Strings Analysis**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'My Expenses' (title) | 'my_expenses' | ✅ EXISTS |
| 'Gestion de vos notes de frais' (subtitle) | ⚠️ **NEW**: 'manage_expenses_subtitle' | FR content - keep or add key |
| 'Transport' | ⚠️ **NEW**: 'expense_transport' | Add to app_theme.dart |
| 'Repas' | ⚠️ **NEW**: 'expense_meal' | Add to app_theme.dart |
| 'Hébergement' | ⚠️ **NEW**: 'expense_accommodation' | Add to app_theme.dart |
| 'Autre' | ⚠️ **NEW**: 'expense_other' | Add to app_theme.dart |

**Special Considerations**:
- Provider already set up correctly
- Expense category labels are hardcoded in ExpCatExt enum extension - should be externalized
- Expense data (titles, amounts) are content - keep as is

**Estimated Changes**: Extract 4 category labels to use appTheme.translate()

---

### 12. **personalcalendar_screen.dart** ⚠️ PARTIAL

**Current Status**: Uses `context.watch<AppTheme>()` but doesn't actually call translate() for any visible text

**Import Changes Required**: Already present ✅

**Build Method Update**: Already has `context.watch<AppTheme>()` ✅

**Hardcoded Strings to Replace**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'Ajouter une note' (dialog title) | ⚠️ **NEW**: 'add_note' | Add to app_theme.dart |
| 'Votre note…' (hint) | ⚠️ **NEW**: 'your_note_hint' | Add to app_theme.dart |
| Holiday names: 'Jour de l\'An', 'Fête du Travail', etc. | N/A | Content - keep as is |
| 'Lundi de Pâques', 'Ascension', etc. (mobile holidays) | N/A | Content - keep as is |

**Special Considerations**:
- Fixed French holiday names are content - keep as is (culture-specific)
- Mobile holidays (Easter-based) are content - keep as is
- Dialog titles and hints should be translated
- User notes content is content - keep as is

**Estimated Changes**: 2 new translation keys for dialog UI

---

### 13. **postes_screen.dart** ✅ ALREADY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Hardcoded Strings Analysis**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'Poste List' (title) | 'postes' | ✅ EXISTS |
| 'Home' (breadcrumb) | ⚠️ **NEW**: 'home' | Add to app_theme.dart |
| 'Postes' (breadcrumb) | 'postes' | ✅ EXISTS |
| 'Coopt a Talented Employee' (button) | ⚠️ **NEW**: 'coopt_employee' | Add to app_theme.dart |
| 'Search' (placeholder) | 'search' | ✅ EXISTS |
| 'Add Poste' (button) | ⚠️ **NEW**: 'add_poste' | Add to app_theme.dart |

**Special Considerations**:
- Provider already set up
- Post content (titles, authors, content) is data - keep as is
- UI buttons and breadcrumb should use translation keys

**Estimated Changes**: 3 new translation keys + usage

---

### 14. **my_jackpot_screen.dart** ✅ ALREADY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Hardcoded Strings Analysis**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'Total Jackpot' | ⚠️ **NEW**: 'total_jackpot' | Add to app_theme.dart |
| 'Total Gains' | ⚠️ **NEW**: 'total_gains' | Add to app_theme.dart |
| 'Total Withdrawals' | ⚠️ **NEW**: 'total_withdrawals' | Add to app_theme.dart |
| 'Bonus %' | ⚠️ **NEW**: 'bonus_percent' | Add to app_theme.dart |

**Special Considerations**:
- Provider already set up
- User data (names, emails) is content - keep as is
- Financial values/amounts should not be translated, only labels

**Estimated Changes**: 4 new translation keys for labels

---

### 15. **my_feedbacks_screen.dart** ✅ ALREADY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Hardcoded Strings Analysis**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'List of feed Back' (title) | 'feedbacks' | ✅ EXISTS |
| 'Home' (breadcrumb) | ⚠️ **NEW**: 'home' | Add to app_theme.dart |
| 'Communication' (breadcrumb) | 'communication' | ✅ EXISTS |
| 'feedback' (breadcrumb) | 'feedbacks' | ✅ EXISTS |
| 'Coopt a Talented Employee' (button) | ⚠️ **NEW**: 'coopt_employee' | Add to app_theme.dart |
| Status tabs: 'All', 'Replied', 'Unanswered' | ⚠️ **NEW**: 'feedback_all', 'feedback_replied', 'feedback_unanswered' | Add to app_theme.dart |

**Special Considerations**:
- Provider already set up
- Feedback content (user names, feedback text) is data - keep as is
- Status filter labels should be translated

**Estimated Changes**: 4 new translation keys for status filters + buttons

---

### 16. **my_documents_screen.dart** ✅ ALREADY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Hardcoded Strings Analysis**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'Document requests' (title) | ⚠️ **NEW**: 'document_requests' | Add to app_theme.dart |
| 'Home' (breadcrumb) | ⚠️ **NEW**: 'home' | Add to app_theme.dart |
| 'Communication' (breadcrumb) | 'communication' | ✅ EXISTS |
| 'Requests' (breadcrumb) | ⚠️ **NEW**: 'requests' | Add to app_theme.dart |
| 'Coopt a Talented Employee' (button) | ⚠️ **NEW**: 'coopt_employee' | Add to app_theme.dart |
| Status tabs: 'All', 'Replied', 'Unanswered' | ⚠️ **NEW**: 'doc_all', 'doc_replied', 'doc_unanswered' | Add to app_theme.dart |

**Special Considerations**:
- Provider already set up
- Document request data is content - keep as is
- Status filter labels should be translated

**Estimated Changes**: 4 new translation keys for status filters + UI labels

---

### 17. **my_applications_screen.dart** ✅ ALREADY IMPLEMENTED

**Current Status**: Already uses `context.watch<AppTheme>()` correctly

**Hardcoded Strings Analysis**:
| Hardcoded Text | Translation Key | Status |
|---|---|---|
| 'My Applications' (title) | 'applications' | ✅ EXISTS |
| 'Home' (breadcrumb) | ⚠️ **NEW**: 'home' | Add to app_theme.dart |
| 'Pages' (breadcrumb) | ⚠️ **NEW**: 'pages' | Add to app_theme.dart |
| Status labels: 'init', 'In Progress', 'Accepted', 'Rejected' | ⚠️ **NEW**: 'app_init', 'app_in_progress', 'app_accepted', 'app_rejected' | Add to app_theme.dart |
| Pipeline steps: 'Received', 'Under review', 'Interview', 'Hired' | ⚠️ **NEW**: Pipeline labels | Add to app_theme.dart |

**Special Considerations**:
- Provider already set up
- Application data (candidate names, emails, offers) is content - keep as is
- Status and pipeline step labels should be translated

**Estimated Changes**: 5-6 new translation keys for status and pipeline labels

---

## Summary of Required Actions

### 1. **Screens Needing Provider Setup** (5 screens)
- `dashboard_screen.dart`
- `profile_screen.dart`
- `news_screen.dart`
- `events_screen.dart`
- `offer_list_screen.dart`
- `offer_detail_screen.dart`

**Action**: Add `import 'package:provider/provider.dart'` and `final appTheme = context.watch<AppTheme>();` in build method

### 2. **Screens Needing Translation Keys** (12 screens)
Replace hardcoded strings with `appTheme.translate('key')`

### 3. **New Translation Keys Needed in app_theme.dart**

| Key | English | French | Category |
|---|---|---|---|
| home | Home | Accueil | UI |
| pages | Pages | Pages | UI |
| statistics | Statistics | Statistiques | Dashboard |
| current_month | Current Month | Mois courant | Dashboard |
| since_entry | Since Entry | Depuis l'entrée | Dashboard |
| total_ca | Total CA | CA Total | Dashboard |
| reserve | Reserve | Réserve | Dashboard |
| usable_reserve_ca | Usable Reserve (CA) | Réserve utilisable (CA) | Dashboard |
| usable_reserve_days | Usable Reserve (in days) | Réserve utilisable (en jours) | Dashboard |
| ca_since_entry | CA Since Entry | CA depuis l'entrée | Dashboard |
| reserve_since_entry | Reserve Since Entry | Réserve depuis l'entrée | Dashboard |
| usable_reserve_since_entry | Usable Reserve Since Entry | Réserve utilisable depuis l'entrée | Dashboard |
| usable_reserve_since_entry_days | Usable Reserve Since Entry (in days) | Réserve utilisable depuis l'entrée (en jours) | Dashboard |
| level_beginner | Beginner | Débutant | Skills |
| level_intermediate | Intermediate | Intermédiaire | Skills |
| level_advanced | Advanced | Avancé | Skills |
| level_expert | Expert | Expert | Skills |
| read_more | Read More | Lire la suite | UI |
| coopt_employee | Coopt a Talented Employee | Coopter un employé talentueux | UI |
| rate_ascending | RATE ↑ | TARIF ↑ | Filters |
| rate_descending | RATE ↓ | TARIF ↓ | Filters |
| offer_details | Offer Details | Détails de l'offre | UI |
| activity_work | Work | Travail | Activity |
| activity_absence | Absence | Absence | Activity |
| activity_travel | Travel | Déplacement | Activity |
| total_submitted | Total Submitted | Total soumis | CRA |
| status_validated | Validated | Validé | Status |
| status_rejected | Rejected | Rejeté | Status |
| rejected | Rejected | Rejeté | Status |
| expense_transport | Transport | Transport | Expenses |
| expense_meal | Meal | Repas | Expenses |
| expense_accommodation | Accommodation | Hébergement | Expenses |
| expense_other | Other | Autre | Expenses |
| add_note | Add Note | Ajouter une note | UI |
| your_note_hint | Your note... | Votre note... | Hint |
| add_poste | Add Poste | Ajouter Poste | UI |
| total_jackpot | Total Jackpot | Total Jackpot | Jackpot |
| total_gains | Total Gains | Gains Total | Jackpot |
| total_withdrawals | Total Withdrawals | Retraits Total | Jackpot |
| bonus_percent | Bonus % | Bonus % | Jackpot |
| feedback_all | All | Tous | Feedback |
| feedback_replied | Replied | Répondu | Feedback |
| feedback_unanswered | Unanswered | Sans réponse | Feedback |
| coopt_employee | Coopt a Talented Employee | Coopter un employé talentueux | UI |
| document_requests | Document Requests | Demandes de documents | UI |
| requests | Requests | Demandes | UI |
| doc_all | All | Tous | Documents |
| doc_replied | Replied | Répondu | Documents |
| doc_unanswered | Unanswered | Sans réponse | Documents |
| app_init | Pending Review | En cours d'examen | Applications |
| app_in_progress | In Progress | En cours | Applications |
| app_accepted | Accepted | Accepté | Applications |
| app_rejected | Rejected | Rejeté | Applications |

---

## Implementation Priority

### Phase 1 - Quick Wins (2-3 hours)
1. Add `context.watch<AppTheme>()` to 5 screens needing Provider setup
2. Replace existing hardcoded text with translation keys in 4 screens (my_tasks, chat, postes, offers)

### Phase 2 - Core Screens (4-6 hours)
3. Add translation keys to app_theme.dart (all ~45 new keys)
4. Implement dashboard_screen and profile_screen (most complex)
5. Update event, news, and application screens

### Phase 3 - Polish (2-3 hours)
6. Extract hardcoded labels from enum extensions (CRA activities, expense categories, status labels)
7. Test all screens with language switcher
8. Verify French/English consistency

---

## Code Snippet Library

### Pattern: Simple Text Replacement
**Before**:
```dart
Text('Statistics')
```

**After**:
```dart
Text(appTheme.translate('statistics'))
```

### Pattern: Button Label
**Before**:
```dart
ElevatedButton(
  child: const Text('Add Task'),
  onPressed: () {},
)
```

**After**:
```dart
ElevatedButton(
  child: Text(appTheme.translate('add_task')),
  onPressed: () {},
)
```

### Pattern: Enum Extension (Extract to translate())
**Before**:
```dart
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
}
```

**After** (in the method that displays it):
```dart
// In build method where activity is displayed:
Text(appTheme.translate(_getActivityLabel(activity.type)))

String _getActivityLabel(ActivityType type) {
  switch (type) {
    case ActivityType.work:
      return 'activity_work';
    case ActivityType.absence:
      return 'activity_absence';
    case ActivityType.travel:
      return 'activity_travel';
  }
}
```

---

## Testing Checklist

- [ ] All screens display English text correctly
- [ ] Language toggle to French displays correct translations
- [ ] No hardcoded text appears on UI for implemented screens
- [ ] All new translation keys exist in both English and French
- [ ] Breadcrumbs use consistent "Home" translation across screens
- [ ] Status labels consistent across different screens
- [ ] Financial labels (CA, Reserve, Expense) consistently translated
- [ ] Form hint text properly translated
- [ ] Dialog titles and buttons translated
- [ ] Button labels consistent across screens

---

## Notes for Developers

1. **Consistency**: Use the same translation key for the same concept across screens (e.g., "Home" should always be 'home')
2. **Content vs UI**: Only translate UI elements (buttons, labels, titles). Keep data/content (user names, descriptions, messages) as is
3. **Performance**: `context.watch<AppTheme>()` is more efficient than `Consumer<AppTheme>` for full-screen widgets
4. **Naming Convention**: Use snake_case for translation keys (e.g., 'total_jackpot', 'add_task')
5. **Organization**: Group related translations in app_theme.dart by category (Dashboard, Forms, Status, etc.)

---

## Generated: May 4, 2026
**Total Screens Analyzed**: 17  
**Screens Needing Provider Setup**: 5-6  
**New Translation Keys Needed**: ~45  
**Estimated Implementation Time**: 8-12 hours
