# 🎨 Design System - Professional & Academic Style

## Overview
This document outlines the professional and academic design system implemented in Cooptalite. The design emphasizes clarity, professionalism, and academic excellence through consistent typography, color schemes, and component patterns.

---

## 📊 Color Palette

### Primary Colors
- **Primary Blue**: `#1F4788` - Professional, trustworthy, and academic
- **Light Primary**: `#2E5FA3` - For hover states
- **Dark Primary**: `#162D5A` - For active states

### Secondary Colors
- **Secondary Blue**: `#00A3FF` - Accent and highlights
- **Success Green**: `#27AE60` - Positive actions and confirmations
- **Warning Orange**: `#E67E22` - Warnings and alerts
- **Error Red**: `#E74C3C` - Errors and destructive actions

### Neutral Colors
- **Gray 900**: `#1A1A1A` - Text and dark elements
- **Gray 800**: `#2D2D2D` - Secondary text
- **Gray 700**: `#424242` - Borders and dividers
- **Gray 600**: `#616161` - Placeholder text
- **Gray 300**: `#E0E0E0` - Light borders
- **Gray 200**: `#F5F5F5` - Card backgrounds
- **Gray 100**: `#FAFAFC` - Page backgrounds

### Light Mode
- **Background**: `#FAFAFC` (soft gray)
- **Card Background**: `#FFFFFF` (pure white)
- **Text Primary**: `#1A1A1A` (almost black)
- **Text Secondary**: `#616161` (medium gray)
- **Border**: `#DEE0E6` (light gray)

### Dark Mode
- **Background**: `#0F1419` (very dark blue-gray)
- **Card Background**: `#1A1F2E` (dark blue)
- **Text Primary**: `#FFFFFF` (white)
- **Text Secondary**: `#B0B0B0` (light gray)
- **Border**: `#2D3546` (dark blue-gray)

---

## 🔤 Typography

### Font Scale
| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| Headline Large | 32px | Bold | Page titles |
| Headline Medium | 26px | Bold | Section headers |
| Headline Small | 20px | Semi-bold | Card titles |
| Title Large | 18px | Semi-bold | Subsection titles |
| Body Large | 16px | Medium | Primary content |
| Body Medium | 14px | Normal | Secondary content |
| Label Small | 12px | Semi-bold | Badges, captions |

---

## 🧩 Component Library

### 1. ProfessionalCard
A container with professional styling (shadows, borders, rounded corners)

```dart
ProfessionalCard(
  padding: EdgeInsets.all(16),
  child: Text('Card Content'),
)
```

**Features:**
- Adaptive background (light/dark mode)
- Subtle shadow effect
- Professional borders
- Optional tap callback

### 2. ProfessionalButton
Professional styled button with loading state support

```dart
ProfessionalButton(
  label: 'Submit',
  onPressed: () {},
  icon: Icons.check,
  isLoading: false,
)
```

**Features:**
- Elevated and outlined variants
- Loading state with spinner
- Icon support
- Accessible sizing

### 3. ProfessionalTextField
Professional input field with proper styling

```dart
ProfessionalTextField(
  label: 'Email Address',
  hint: 'john@example.com',
  inputType: TextInputType.emailAddress,
  prefixIcon: Icons.email_outlined,
)
```

**Features:**
- Label and hint support
- Icon support (prefix & suffix)
- Password toggle capability
- Validation support
- Multi-line support

### 4. SectionHeader
Professional section header with optional "See All" link

```dart
SectionHeader(
  title: 'Recent Activities',
  subtitle: 'Your latest updates',
  onSeeAll: () {},
)
```

### 5. StatCard
Dashboard stat card with icon and change indicator

```dart
StatCard(
  label: 'Total Users',
  value: '1,234',
  icon: Icons.people_outline,
  iconColor: Color(0xFF1F4788),
  change: '+12% from last month',
  isPositive: true,
)
```

### 6. ProfessionalBadge
Status/category badge

```dart
ProfessionalBadge(
  label: 'Active',
  backgroundColor: Color(0xFF27AE60).withOpacity(0.1),
  textColor: Color(0xFF27AE60),
)
```

### 7. ProfessionalDivider
Enhanced divider with optional text

```dart
ProfessionalDivider(text: 'Or continue with')
```

---

## 📐 Spacing System

### Standard Spacing Units
- **4px** - Tiny gaps (rarely used)
- **8px** - Small spacing
- **12px** - Between form elements
- **16px** - Default padding/margins
- **20px** - Section spacing
- **24px** - Between major sections
- **32px** - Large section separation
- **40px** - Extra large gaps
- **60px+** - Major visual breaks

### Padding Conventions
- **Cards**: 16px
- **Screen Edges**: 24px
- **TextFields**: 12px between stacked elements
- **Buttons**: 14px vertical, 24px horizontal

---

## 🎯 Layout Guidelines

### App Bar
- Height: 56px
- Elevation: 1px
- Background: White (light) / Dark (dark mode)
- Text: Use Theme.textTheme.titleLarge (20px, semi-bold)

### Cards & Containers
- Border Radius: 12px
- Padding: 16px
- Elevation: 2
- Border: 1px solid theme color

### Forms
- Label above field pattern
- 12px spacing between label and input
- 20px spacing between form fields
- Use proper grouping with dividers

### Lists & Grids
- List items: 12px padding, 8px spacing
- Grid: 2-3 columns on mobile, 3-4 on tablet
- Card minimum width: 160px

---

## 🎨 Button Styles

### Primary Button
- Background: Professional Blue (`#1F4788`)
- Text: White
- Padding: 12px vertical, 24px horizontal
- Border Radius: 8px
- Elevation: 2

### Secondary Button
- Background: Gray 200
- Text: Professional Blue
- Padding: Same as primary
- Border Radius: 8px
- Elevation: 0

### Outlined Button
- Background: Transparent
- Border: 1px solid Professional Blue
- Text: Professional Blue
- Padding: Same as primary
- Border Radius: 8px

---

## 🌙 Dark Mode Implementation

All components use theme context to adapt:
- Use `Theme.of(context).brightness` to detect mode
- Colors are dynamically selected from ThemeColors
- Text contrast is maintained at WCAG AA level
- Borders become lighter in dark mode

---

## 📱 Responsive Design

### Breakpoints
- **Mobile**: < 600px
- **Tablet**: 600px - 900px
- **Desktop**: > 900px

### Grid Layouts
```dart
LayoutBuilder(
  builder: (context, constraints) {
    int columns = constraints.maxWidth > 600 ? 3 : 1;
    // Use GridView.builder with crossAxisCount
  },
)
```

---

## ♿ Accessibility Guidelines

1. **Color Contrast**
   - Text on background: Minimum 4.5:1 ratio
   - Use professional blues with light backgrounds
   - Ensure gray text isn't too light

2. **Typography**
   - Minimum font size: 12px for captions
   - Proper font weights for hierarchy
   - Adequate line-height (1.5 for body text)

3. **Interactive Elements**
   - Minimum touch target: 48x48dp
   - Clear focus indicators
   - Sufficient spacing between clickables

4. **Icons & Images**
   - Always provide semantic labels
   - Use semantic icon naming
   - Include alt text for images

---

## 🎭 Professional Patterns

### Empty State
```dart
ProfessionalCard(
  padding: EdgeInsets.all(40),
  child: Column(
    children: [
      Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
      SizedBox(height: 16),
      Text('No data available', style: Theme.of(context).textTheme.titleLarge),
    ],
  ),
)
```

### Loading State
Use CircularProgressIndicator with primary color:
```dart
Center(
  child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1F4788)),
  ),
)
```

### Error State
Use ProfessionalCard with error red icon:
```dart
ProfessionalCard(
  backgroundColor: Color(0xFFFFEBEE),
  child: Row(
    children: [
      Icon(Icons.error_outline, color: Color(0xFFE74C3C)),
      SizedBox(width: 12),
      Expanded(child: Text('Error message')),
    ],
  ),
)
```

---

## 🔄 Transitions & Animations

### Standard Durations
- **Quick**: 100ms - Small UI changes
- **Standard**: 250ms - Default transitions
- **Slow**: 500ms - Significant layout changes

### Recommended Animations
- Page transitions: MaterialPageRoute
- Card reveals: Fade + Slide
- Button responses: Ripple effect (built-in)
- Loading indicators: Circular spinner

---

## 📋 Implementation Checklist

When building new screens:
- [ ] Use `ProfessionalCard` for content containers
- [ ] Apply proper spacing (multiples of 4/8)
- [ ] Use ThemeColors for all color references
- [ ] Add icons to text inputs
- [ ] Include proper labels for form fields
- [ ] Use SectionHeader for grouped content
- [ ] Add elevation/shadow to interactive elements
- [ ] Test in both light and dark modes
- [ ] Verify color contrast ratios
- [ ] Check responsive layout on multiple screen sizes
- [ ] Add proper error/loading states
- [ ] Include empty state UI

---

## 🚀 Usage Example

```dart
import 'package:flutter/material.dart';
import '../widgets/professional_components.dart';
import '../utils/theme_colors.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Professional Screen'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Dashboard',
              subtitle: 'Welcome back',
            ),
            SizedBox(height: 20),
            
            // Stat Cards
            GridView.count(
              crossAxisCount: 2,
              spacing: 16,
              runSpacing: 16,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                StatCard(
                  label: 'Total',
                  value: '1,234',
                  icon: Icons.trending_up,
                  iconColor: ThemeColors.primary,
                ),
                // More cards...
              ],
            ),
            
            SizedBox(height: 24),
            
            // Professional Card
            ProfessionalCard(
              child: Column(
                children: [
                  Text('Content here'),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // Action Button
            ProfessionalButton(
              label: 'Continue',
              onPressed: () {},
              icon: Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎓 Academic Style Principles

### 1. **Clarity First**
- Clean layouts with clear hierarchy
- Generous whitespace
- No visual clutter

### 2. **Professional Palette**
- Deep blues and grays
- Minimal color saturation
- High contrast for readability

### 3. **Proper Typography**
- Clear font hierarchy
- Appropriate weights and sizes
- Good line-height for readability

### 4. **Consistent Patterns**
- Repeating component styles
- Predictable interactions
- Uniform spacing

### 5. **Academic Excellence**
- Attention to detail
- Professional finish
- Institutional quality

---

## 📞 Support

For component updates or design questions, refer to:
- `lib/widgets/professional_components.dart` - Component library
- `lib/utils/theme_colors.dart` - Color definitions
- `lib/providers/app_theme.dart` - Theme configuration
