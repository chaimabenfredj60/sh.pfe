# 🎯 Quick Start Guide - Applying Professional Design to Screens

## 📚 Implementation Templates

Use these templates as starting points for updating your remaining screens.

---

## 🏠 Dashboard Screen Template

```dart
import 'package:flutter/material.dart';
import '../widgets/professional_components.dart';
import '../utils/theme_colors.dart';
import '../providers/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ThemeColors.getBgColor(isDark),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back to your workspace',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            // Stats Grid
            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              spacing: 16,
              runSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StatCard(
                  label: 'Total Users',
                  value: '1,234',
                  icon: Icons.people_outline,
                  iconColor: ThemeColors.primary,
                  change: '+12% from last month',
                  isPositive: true,
                ),
                StatCard(
                  label: 'Active Tasks',
                  value: '48',
                  icon: Icons.assignment_outlined,
                  iconColor: const Color(0xFF00A3FF),
                  change: '+5 today',
                  isPositive: true,
                ),
                StatCard(
                  label: 'Completion Rate',
                  value: '87%',
                  icon: Icons.trending_up,
                  iconColor: const Color(0xFF27AE60),
                  change: '+3% this week',
                  isPositive: true,
                ),
                StatCard(
                  label: 'Pending Issues',
                  value: '12',
                  icon: Icons.warning_outlined,
                  iconColor: const Color(0xFFE67E22),
                  change: '-2 resolved',
                  isPositive: true,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Recent Activities
            SectionHeader(
              title: 'Recent Activities',
              subtitle: 'Your latest updates',
              onSeeAll: () {},
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ProfessionalCard(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ThemeColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.task_outlined,
                            color: ThemeColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Task completed',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Project Alpha - Phase 1',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '2h ago',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 👤 Profile Screen Template

```dart
import 'package:flutter/material.dart';
import '../widgets/professional_components.dart';
import '../utils/theme_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ThemeColors.getBgColor(isDark),
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ThemeColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      size: 50,
                      color: ThemeColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@example.com',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Personal Information Section
            SectionHeader(
              title: 'Personal Information',
            ),
            const SizedBox(height: 16),
            ProfessionalCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProfessionalTextField(
                    label: 'First Name',
                    hint: 'Enter first name',
                    controller: _firstNameController,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  ProfessionalTextField(
                    label: 'Last Name',
                    hint: 'Enter last name',
                    controller: _lastNameController,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  ProfessionalTextField(
                    label: 'Email Address',
                    hint: 'john.doe@example.com',
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Professional Information Section
            SectionHeader(
              title: 'Professional Information',
            ),
            const SizedBox(height: 16),
            ProfessionalCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProfessionalTextField(
                    label: 'Job Title',
                    hint: 'Enter job title',
                    prefixIcon: Icons.work_outline,
                  ),
                  const SizedBox(height: 16),
                  ProfessionalTextField(
                    label: 'Department',
                    hint: 'Enter department',
                    prefixIcon: Icons.domain_outlined,
                  ),
                  const SizedBox(height: 16),
                  ProfessionalTextField(
                    label: 'Phone Number',
                    hint: 'Enter phone number',
                    inputType: TextInputType.phone,
                    prefixIcon: Icons.phone_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ProfessionalButton(
                label: 'Save Changes',
                onPressed: () {},
                icon: Icons.check_circle_outline,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ProfessionalButton(
                label: 'Cancel',
                onPressed: () => Navigator.pop(context),
                isOutlined: true,
                icon: Icons.close,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
```

---

## ✅ Task/Todo List Template

```dart
import 'package:flutter/material.dart';
import '../widgets/professional_components.dart';
import '../utils/theme_colors.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ThemeColors.getBgColor(isDark),
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search tasks...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.getCardBgColor(isDark),
                    border: Border.all(
                      color: ThemeColors.getBorderColor(isDark),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(child: Text('All')),
                      const PopupMenuItem(child: Text('Pending')),
                      const PopupMenuItem(child: Text('Completed')),
                    ],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.filter_list),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Task List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                final isCompleted = index % 2 == 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ProfessionalCard(
                    onTap: () {},
                    child: Row(
                      children: [
                        Checkbox(
                          value: isCompleted,
                          onChanged: (value) {},
                          activeColor: ThemeColors.primary,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Task ${index + 1}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      decoration: isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Description of task ${index + 1}',
                                style:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        ProfessionalBadge(
                          label: index % 2 == 0 ? 'Completed' : 'In Progress',
                          backgroundColor: index % 2 == 0
                              ? const Color(0xFF27AE60).withOpacity(0.1)
                              : const Color(0xFF00A3FF).withOpacity(0.1),
                          textColor: index % 2 == 0
                              ? const Color(0xFF27AE60)
                              : const Color(0xFF00A3FF),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📝 Form/Feedback Template

```dart
import 'package:flutter/material.dart';
import '../widgets/professional_components.dart';
import '../utils/theme_colors.dart';

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ThemeColors.getBgColor(isDark),
      appBar: AppBar(
        title: const Text('Send Feedback'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instructions
              ProfessionalCard(
                backgroundColor: ThemeColors.primary.withOpacity(0.05),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: ThemeColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your feedback helps us improve the app',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              ProfessionalTextField(
                label: 'Full Name',
                hint: 'Your name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              ProfessionalTextField(
                label: 'Email Address',
                hint: 'your.email@example.com',
                inputType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              Text(
                'Category',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                value: _selectedCategory,
                items: [
                  'Bug Report',
                  'Feature Request',
                  'General Feedback',
                  'Performance Issue',
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
                decoration: InputDecoration(
                  hintText: 'Select category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.category_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Message Field
              ProfessionalTextField(
                label: 'Your Feedback',
                hint: 'Describe your feedback or issue...',
                maxLines: 5,
                prefixIcon: Icons.message_outlined,
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ProfessionalButton(
                  label: 'Send Feedback',
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  isLoading: _isSubmitting,
                  icon: Icons.send_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);
      
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  const Text('Feedback sent successfully!'),
                ],
              ),
              backgroundColor: const Color(0xFF27AE60),
            ),
          );
          Navigator.pop(context);
        }
      });
    }
  }
}
```

---

## 📊 List/Grid Template

```dart
import 'package:flutter/material.dart';
import '../widgets/professional_components.dart';
import '../utils/theme_colors.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = List.generate(12, (i) => 'Item ${i + 1}');

    return Scaffold(
      backgroundColor: ThemeColors.getBgColor(isDark),
      appBar: AppBar(
        title: const Text('Items'),
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).size.width > 600 ? 3 : 2,
          spacing: 16,
          runSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ProfessionalCard(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    color: ThemeColors.primary,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  items[index],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Description of item',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text('View'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

---

## 🎓 Best Practices

✅ **Always**
- Use component library widgets
- Reference ThemeColors for all colors
- Maintain spacing multiples (4/8/12/16/20/24/32px)
- Use Theme.of(context).textTheme for typography
- Test in both light and dark modes

❌ **Never**
- Hardcode colors (use ThemeColors)
- Use random spacing values
- Mix different button styles
- Ignore accessibility requirements
- Skip the design system

---

## 🚀 Template Usage

1. Copy the relevant template
2. Adapt to your specific needs
3. Import required components
4. Apply consistent spacing
5. Test both light and dark modes

**All templates follow professional design principles!**
