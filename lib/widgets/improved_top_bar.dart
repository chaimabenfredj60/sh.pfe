import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

class ImprovedTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfile;
  final VoidCallback? onLogout;

  const ImprovedTopBar({
    super.key,
    this.onProfile,
    this.onLogout,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final bgColor = isDark ? const Color(0xFF1A1F2E) : Colors.white;
        final textColor = isDark ? Colors.white : const Color(0xFF1A1A1A);

        return Container(
          height: preferredSize.height,
          color: bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              // Logo/Title
              Text(
                'Cooptalite',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const Spacer(),
              // Language Selector
              PopupMenuButton<String>(
                onSelected: (String value) {
                  appTheme.setLanguage(value);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'en',
                    child: Row(
                      children: [
                        if (appTheme.language == 'en')
                          const Icon(Icons.check,
                              color: Color(0xFF1F4788), size: 18)
                        else
                          const SizedBox(width: 18),
                        const SizedBox(width: 8),
                        const Text('English'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'fr',
                    child: Row(
                      children: [
                        if (appTheme.language == 'fr')
                          const Icon(Icons.check,
                              color: Color(0xFF1F4788), size: 18)
                        else
                          const SizedBox(width: 18),
                        const SizedBox(width: 8),
                        const Text('Français'),
                      ],
                    ),
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.language,
                          size: 20,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        appTheme.language.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Notifications
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_none,
                        size: 20,
                        color: isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade600),
                    onPressed: () {},
                    tooltip: 'Notifications',
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE74C3C),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // User Menu
              PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'profile') {
                    onProfile?.call();
                  } else if (value == 'logout') {
                    onLogout?.call();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        const Icon(Icons.person, size: 18),
                        const SizedBox(width: 10),
                        Text(appTheme.translate('profile')),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        const Icon(Icons.logout, size: 18),
                        const SizedBox(width: 10),
                        Text(appTheme.translate('logout')),
                      ],
                    ),
                  ),
                ],
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF1F4788),
                  child: Text(
                    'BW',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
