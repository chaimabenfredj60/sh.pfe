import 'package:flutter/material.dart';
import 'feedback_dialog.dart';
import '../providers/app_provider.dart';

class TopBar extends StatefulWidget {
  final VoidCallback? onProfile;
  final VoidCallback? onApplication;
  final VoidCallback? onJackpot;
  final VoidCallback? onChats;
  final VoidCallback? onCv;
  final VoidCallback? onSupport;
  final VoidCallback? onLogout;
  final Function(String)? onLanguageChanged;
  final String currentLanguage;

  const TopBar({
    Key? key,
    this.onProfile,
    this.onApplication,
    this.onJackpot,
    this.onChats,
    this.onCv,
    this.onSupport,
    this.onLogout,
    this.onLanguageChanged,
    this.currentLanguage = 'en',
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late String _language;

  @override
  void initState() {
    super.initState();
    _language = widget.currentLanguage;
  }

  String _translate(String key) {
    return AppLocalizations.translate(key, _language);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          const Spacer(),
          Row(
            children: [
              // Language Dropdown
              DropdownButton<String>(
                value: _language,
                underline: const SizedBox(),
                icon: const Icon(Icons.language, size: 18, color: Colors.grey),
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English',
                        style: const TextStyle(color: Colors.black)),
                  ),
                  DropdownMenuItem(
                    value: 'fr',
                    child: Text('Français',
                        style: const TextStyle(color: Colors.black)),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _language = value);
                    widget.onLanguageChanged?.call(value);
                  }
                },
              ),
              const SizedBox(width: 16),
              // User Profile
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey[300],
                    child:
                        const Icon(Icons.person, size: 18, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Membre',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
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
                icon:
                    const Icon(Icons.expand_more, size: 20, color: Colors.grey),
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
                    case 'cv':
                      widget.onCv?.call();
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
                        const Icon(Icons.person, size: 18, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('profile')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'application',
                    child: Row(
                      children: [
                        const Icon(Icons.edit_note,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('my_application')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'jackpot',
                    child: Row(
                      children: [
                        const Icon(Icons.casino, size: 18, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('my_jackpot')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'chats',
                    child: Row(
                      children: [
                        const Icon(Icons.chat, size: 18, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(_translate('chats')),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'cv',
                    child: Row(
                      children: [
                        const Icon(Icons.description,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 10),
                        const Text('Mes CVs'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'support',
                    child: Row(
                      children: [
                        const Icon(Icons.help, size: 18, color: Colors.grey),
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
      ), // ← parenthèse fermante du Container manquante
    );
  }
} // ← accolade fermante de _TopBarState manquante
