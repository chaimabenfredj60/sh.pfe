import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';

class Contact {
  final String id;
  final String name;
  final String role;
  final bool isOnline;
  final String initials;
  final Color avatarColor;
  List<ChatMessage> messages;

  Contact(
      {required this.id,
      required this.name,
      required this.role,
      this.isOnline = false,
      required this.initials,
      required this.avatarColor,
      this.messages = const []});
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;
  ChatMessage({required this.text, required this.isMe, required this.time});
}

class ChatScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const ChatScreen({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const Color primary = Color(0xFF00B4A6);
  final _searchCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  String _search = '';
  Contact? _selected;
  final _scrollCtrl = ScrollController();

  final List<Contact> _contacts = [
    Contact(
        id: '1',
        name: 'SuperAdmin',
        role: 'SuperAdmin',
        isOnline: true,
        initials: 'SA',
        avatarColor: const Color(0xFF00B4A6),
        messages: [
          ChatMessage(
              text: 'Bonjour !',
              isMe: false,
              time: DateTime(2026, 4, 20, 9, 0)),
          ChatMessage(
              text: 'Bonjour, comment puis-je vous aider ?',
              isMe: true,
              time: DateTime(2026, 4, 20, 9, 1)),
        ]),
    Contact(
        id: '2',
        name: 'Gestion',
        role: 'gestion',
        isOnline: false,
        initials: 'G',
        avatarColor: const Color(0xFF6B7280),
        messages: []),
    Contact(
        id: '3',
        name: 'Compte de Test',
        role: '',
        isOnline: false,
        initials: 'GT',
        avatarColor: const Color(0xFF9E9E9E),
        messages: []),
    Contact(
        id: '4',
        name: 'MANAA Sarah',
        role: 'Admin gestion',
        isOnline: true,
        initials: 'MS',
        avatarColor: const Color(0xFF7C3AED),
        messages: []),
    Contact(
        id: '5',
        name: 'Communication Interne',
        role: 'Communication interne',
        isOnline: false,
        initials: 'CI',
        avatarColor: const Color(0xFF00B4A6),
        messages: []),
    Contact(
        id: '6',
        name: 'Admin CV tech 1',
        role: 'Admin CV',
        isOnline: false,
        initials: 'AC',
        avatarColor: const Color(0xFF3B82F6),
        messages: []),
  ];

  List<Contact> get _filtered => _contacts
      .where((c) =>
          _search.isEmpty ||
          c.name.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty || _selected == null) return;
    setState(() {
      _selected!.messages = [
        ..._selected!.messages,
        ChatMessage(text: text, isMe: true, time: DateTime.now()),
      ];
      _msgCtrl.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Row(children: [
        // ── Contact list ──────────────────────────────────────────────────
        Container(
          width: 220,
          color: Colors.white,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 36,
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _search = v),
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Search or start a new chat',
                    hintStyle:
                        const TextStyle(fontSize: 11, color: Color(0xFFBDBDBD)),
                    prefixIcon: const Icon(Icons.search,
                        size: 16, color: Color(0xFFBDBDBD)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: primary, width: 1.5)),
                    filled: true,
                    fillColor: const Color(0xFFF4F5F7),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(appTheme.translate('chats'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF1A1A2E)))),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Contacts',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF9E9E9E)))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (ctx, i) {
                  final c = _filtered[i];
                  final sel = _selected?.id == c.id;
                  return InkWell(
                    onTap: () => setState(() => _selected = c),
                    child: Container(
                      color:
                          sel ? primary.withOpacity(0.08) : Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      child: Row(children: [
                        Stack(children: [
                          CircleAvatar(
                              radius: 18,
                              backgroundColor: c.avatarColor.withOpacity(0.2),
                              child: Text(c.initials,
                                  style: TextStyle(
                                      color: c.avatarColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                          if (c.isOnline)
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF4CAF50),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 1.5)))),
                        ]),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(c.name,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: sel
                                          ? primary
                                          : const Color(0xFF1A1A2E))),
                              if (c.role.isNotEmpty)
                                Text(c.role,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF9E9E9E))),
                            ])),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),

        const VerticalDivider(width: 1, color: Color(0xFFE0E0E0)),

        // ── Chat area ─────────────────────────────────────────────────────
        Expanded(
          child: _selected == null
              ? _emptyChat()
              : Column(children: [
                  // Chat header
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(children: [
                      CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              _selected!.avatarColor.withOpacity(0.2),
                          child: Text(_selected!.initials,
                              style: TextStyle(
                                  color: _selected!.avatarColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))),
                      const SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_selected!.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF1A1A2E))),
                            Text(
                                _selected!.isOnline ? 'En ligne' : 'Hors ligne',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: _selected!.isOnline
                                        ? const Color(0xFF4CAF50)
                                        : const Color(0xFF9E9E9E))),
                          ]),
                    ]),
                  ),
                  const Divider(height: 1, color: Color(0xFFE0E0E0)),

                  // Messages
                  Expanded(
                    child: _selected!.messages.isEmpty
                        ? _emptyChat()
                        : ListView.builder(
                            controller: _scrollCtrl,
                            padding: const EdgeInsets.all(16),
                            itemCount: _selected!.messages.length,
                            itemBuilder: (ctx, i) =>
                                _bubble(_selected!.messages[i]),
                          ),
                  ),

                  // Input
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _msgCtrl,
                          onSubmitted: (_) => _sendMessage(),
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Écrire un message...',
                            hintStyle: const TextStyle(
                                fontSize: 12, color: Color(0xFFBDBDBD)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    const BorderSide(color: Color(0xFFE0E0E0))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide:
                                    const BorderSide(color: Color(0xFFE0E0E0))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: primary, width: 1.5)),
                            filled: true,
                            fillColor: const Color(0xFFF4F5F7),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: primary, shape: BoxShape.circle),
                          child: const Icon(Icons.send,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ]),
                  ),
                ]),
        ),
      ]),
    );
  }

  Widget _bubble(ChatMessage msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        decoration: BoxDecoration(
          color: msg.isMe ? primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
            bottomRight: Radius.circular(msg.isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Text(msg.text,
            style: TextStyle(
                fontSize: 13,
                color: msg.isMe ? Colors.white : const Color(0xFF1A1A2E))),
      ),
    );
  }

  Widget _emptyChat() => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0), shape: BoxShape.circle),
            child: const Icon(Icons.chat_bubble_outline,
                size: 28, color: Color(0xFFBDBDBD))),
        const SizedBox(height: 12),
        const Text('Start Conversation',
            style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E))),
      ]));
}
