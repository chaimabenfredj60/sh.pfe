import 'package:flutter/material.dart';

/// Professional Card Widget with shadows and borders
class ProfessionalCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final VoidCallback? onTap;
  final Border? border;

  const ProfessionalCard({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ??
              (isDark ? const Color(0xFF1A1F2E) : Colors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: border ??
              Border.all(
                color:
                    isDark ? const Color(0xFF2D3546) : const Color(0xFFDEE0E6),
                width: 1,
              ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

/// Professional Button
class ProfessionalButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isOutlined;

  const ProfessionalButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btnBgColor = backgroundColor ?? const Color(0xFF1F4788);
    final btnTextColor = textColor ?? Colors.white;

    if (isOutlined) {
      return SizedBox(
        width: width,
        child: OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(icon ?? Icons.check),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            side: BorderSide(color: btnBgColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(icon ?? Icons.check),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: btnBgColor,
          foregroundColor: btnTextColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}

/// Professional Input Field
class ProfessionalTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType inputType;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? Function(String?)? validator;
  final int maxLines;
  final int minLines;

  const ProfessionalTextField({
    Key? key,
    required this.label,
    this.hint,
    this.controller,
    this.inputType = TextInputType.text,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          obscureText: isPassword,
          maxLines: isPassword ? 1 : maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon),
                    onPressed: onSuffixIconTap,
                  )
                : null,
            filled: true,
            fillColor:
                isDark ? const Color(0xFF2D3546) : const Color(0xFFF5F5F5),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    isDark ? const Color(0xFF2D3546) : const Color(0xFFDEE0E6),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    isDark ? const Color(0xFF2D3546) : const Color(0xFFDEE0E6),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF1F4788),
                width: 2,
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

/// Professional Section Header
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (onSeeAll != null)
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF1F4788),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}

/// Stat Card for Dashboard
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final String? change;
  final bool isPositive;

  const StatCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
    this.change,
    this.isPositive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor =
        iconColor?.withOpacity(0.1) ?? const Color(0xFF1F4788).withOpacity(0.1);

    return ProfessionalCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor ?? const Color(0xFF1F4788),
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (change != null) ...[
            const SizedBox(height: 8),
            Text(
              change!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isPositive
                        ? const Color(0xFF27AE60)
                        : const Color(0xFFE74C3C),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Badge Widget
class ProfessionalBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;

  const ProfessionalBadge({
    Key? key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF1F4788).withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius ?? 6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor ?? const Color(0xFF1F4788),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

/// Divider with optional text
class ProfessionalDivider extends StatelessWidget {
  final String? text;
  final EdgeInsets? padding;

  const ProfessionalDivider({
    Key? key,
    this.text,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (text == null) {
      return Divider(
        color: isDark ? const Color(0xFF2D3546) : const Color(0xFFDEE0E6),
        height: 24,
        thickness: 1,
      );
    }

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: isDark ? const Color(0xFF2D3546) : const Color(0xFFDEE0E6),
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: Divider(
              color: isDark ? const Color(0xFF2D3546) : const Color(0xFFDEE0E6),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
