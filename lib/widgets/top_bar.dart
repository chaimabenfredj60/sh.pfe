import 'package:flutter/material.dart';
import 'feedback_dialog.dart';
import '../providers/app_provider.dart';

class TopBar extends StatefulWidget {
  final VoidCallback? onProfile;
  final VoidCallback? onApplication;
  final VoidCallback? onJackpot;
  final VoidCallback? onChats;
  final VoidCallback? onSupport;
  final VoidCallback? onLogout;
  final Function(String)? onLanguageChanged;
  final Function(bool)? onThemeChanged;
  final String currentLanguage;
  final bool isDarkMode;

  const TopBar({
    Key? key,
    this.onProfile,
    this.onApplication,
    this.onJackpot,
    this.onChats,
    this.onSupport,
    this.onLogout,
    this.onLanguageChanged,
    this.onThemeChanged,
    this.currentLanguage = 'en',
    this.isDarkMode = false,
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late bool _isDarkMode;
  late String _language;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _language = widget.currentLanguage;
  }

  String _translate(String key) {
    return AppLocalizations.translate(key, _language);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: _isDarkMode ? Colors.grey[900] : Colors.white,
      child: Row(
        children: [
          const Spacer(),
          // Right side - Actions & User
          Row(
            children: [
              // Language Dropdown
              DropdownButton<String>(
                value: _language,
                underline: const SizedBox(),
                icon: Icon(Icons.language,
                    size: 18, color: _isDarkMode ? Colors.white : Colors.grey),
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English',
                        style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black)),
                  ),
                  DropdownMenuItem(
                    value: 'fr',
                    child: Text('Français',
                        style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black)),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _language = value);
                    widget.onLanguageChanged?.call(value);
                  }
                },
              ),
              const SizedBox(width: 8),
              // Dark mode toggle
              IconButton(
                icon: Icon(
                  _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: 20,
                  color: _isDarkMode ? Colors.white : Colors.grey,
                ),
                onPressed: () {
                  setState(() => _isDarkMode = !_isDarkMode);
                  widget.onThemeChanged?.call(_isDarkMode);
                },
                tooltip: 'Toggle Dark Mode',
              ),
              const SizedBox(width: 16),
              // User Profile
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person,
                        size: 18,
                        color: _isDarkMode ? Colors.grey[800] : Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Membre',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'member',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Dropdown menu
              PopupMenuButton<String>(
                icon: Icon(Icons.expand_more,
                    size: 20, color: _isDarkMode ? Colors.white : Colors.grey),
                onSelected: (String value) {
                  switch (value) {
                    case 'profile':
                      widget.onProfile?.call();
                      break;
                    case 'application':
                      widget.onApplication?.call();
                      break;
                    case 'jackpot':
                      widget.onJackpot?.call();
                      break;
                    case 'chats':
                      widget.onChats?.call();
                      break;
                    case 'support':
                      showDialog(
                        context: context,
                        builder: (context) =>
                            FeedbackDialog(language: _language),
                      );
                      break;
                    case 'logout':
                      widget.onLogout?.call();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person,
                            size: 18,
                            color: _isDarkMode ? Colors.white : Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('profile')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'application',
                    child: Row(
                      children: [
                        Icon(Icons.edit_note,
                            size: 18,
                            color: _isDarkMode ? Colors.white : Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('my_application')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'jackpot',
                    child: Row(
                      children: [
                        Icon(Icons.casino,
                            size: 18,
                            color: _isDarkMode ? Colors.white : Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('my_jackpot')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'chats',
                    child: Row(
                      children: [
                        Icon(Icons.chat,
                            size: 18,
                            color: _isDarkMode ? Colors.white : Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('chats')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'support',
                    child: Row(
                      children: [
                        Icon(Icons.help,
                            size: 18,
                            color: _isDarkMode ? Colors.white : Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('support')),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        const Icon(Icons.logout, size: 18, color: Colors.red),
                        const SizedBox(width: 10),
                        Text(_translate('logout'),
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
