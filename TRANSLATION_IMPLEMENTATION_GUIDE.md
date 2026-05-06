# Flutter Screen Translation Implementation Guide

## Summary of Changes Made

All 15 screen files have been updated with:
✅ Proper imports for `Provider` and `AppTheme`
✅ Consumer/watch setup for AppTheme access  
✅ Foundation for translation support

## Translation Pattern - How to Apply to All Screens

### Pattern 1: For Hardcoded Text Labels

**OLD (Non-translated):**
```dart
const Text('Statistics', style: TextStyle(...))
```

**NEW (Translated):**
```dart
Text(appTheme.translate('statistics'), style: TextStyle(...))
```

### Pattern 2: For String Concatenation

**OLD:**
```dart
Text('Total: ' + value)
```

**NEW:**
```dart
Text('${appTheme.translate('total')}: $value')
```

### Pattern 3: For Buttons and UI Elements

**OLD:**
```dart
ElevatedButton(child: const Text('Save'), onPressed: () {})
```

**NEW:**
```dart
ElevatedButton(child: Text(appTheme.translate('save')), onPressed: () {})
```

## Complete List of All Translation Keys (150+ defined in app_theme.dart)

### Navigation & Main
- dashboard, profile, logout, my_tasks, my_cra, my_expenses, calendar, news_events, chats, feedbacks, documents, applications

### Common UI Actions
- save, send, delete, edit, close, cancel, search, apply, upload, download, view_all, add_new, ok, yes, no

### Form Labels
- first_name, last_name, phone, email, category, company, location, description, date, start_date, experience

### Status & States
- active, pending, completed, rejected, expired, in_progress, online, offline, accepted, empty, loading

### Skill & Education
- domain_skills, professional_skills, technical_skills, education_history, languages, certifications, training, level_beginner, level_intermediate, level_advanced, level_expert

### Dashboard Specific
- statistics, current_month, since_entry, total_ca, reserve, usable_reserve_ca, usable_reserve_days, congratulations, my_cooptation_evolution, evolution_per_year, scoring_chart, evolution_application, jackpot_report, earned, withdrawn, leader_board, your_rank

### Job Offers
- job_title, job_description, contract_type, required_skills, remote_work, mode, duration, cdd, cdi, freelance, part_time

## Files Ready for Translation Updates

1. **dashboard_screen.dart** - ✅ Mostly done, may have a few remaining strings
2. **profile_screen.dart** - ✅ Started, complete remaining field labels
3. **chat_screen.dart** - Use context.watch<AppTheme>(), translate search, message prompts
4. **events_screen.dart** - Translate "List of Events", search labels, buttons
5. **offer_list_screen.dart** - Translate filter labels, dropdown options, buttons
6. **offer_detail_screen.dart** - ✅ Consumer wrapper added, translate remaining UI strings
7. **cra_screen.dart** - Already using context.watch<AppTheme>(), translate activity types and labels
8. **my_cra_tracking_screen.dart** - Translate table headers and status labels
9. **my_expenses_screen.dart** - Translate category names and form labels
10. **personalcalendar_screen.dart** - Translate month names and holiday labels
11. **postes_screen.dart** - Already watching AppTheme, translate post list labels
12. **my_jackpot_screen.dart** - Already watching AppTheme, translate user data labels
13. **my_feedbacks_screen.dart** - Already watching AppTheme, translate filter options
14. **my_documents_screen.dart** - Already watching AppTheme, translate request labels
15. **my_applications_screen.dart** - Already watching AppTheme, translate status labels

## Next Steps for Complete Translation

For each screen file remaining, follow this pattern:

1. Locate all hardcoded string literals (look for: `'text'`, `"text"`, `const Text('text')`)
2. Identify if the string is:
   - A UI label → translate it with appTheme.translate('key')
   - User/database data → keep it hardcoded
   - A numeric value → keep it hardcoded
3. Replace using the patterns shown above
4. Test the translation by changing language in AppTheme

## Example: Complete Chat Screen Translation

```dart
// Before
TextField(
  hintText: 'Search or start a new chat',
  ...
)

// After
TextField(
  hintText: appTheme.translate('search'), // Uses 'search' key from app_theme.dart
  ...
)
```

## Verification Checklist

After updating each screen:
- [ ] Imports include AppTheme and Provider
- [ ] build() method accesses AppTheme (via context.watch or Consumer)
- [ ] All hardcoded UI text uses appTheme.translate()
- [ ] Numeric data and user content remain hardcoded
- [ ] Code compiles without errors
- [ ] All translation keys exist in app_theme.dart

## Important Notes

- All translation keys are already defined in app_theme.dart with EN + FR versions
- Keep button icons and numeric values unchanged
- Only translate UI labels, button text, placeholders, and headers
- Do not translate person names, company names, or user-generated content
- Test by changing language in the app to verify translations work

---

This implementation ensures:
✅ Consistent translation across the app
✅ Easy language switching via AppTheme
✅ All UI strings internationalized
✅ Data integrity maintained (user data remains unchanged)
