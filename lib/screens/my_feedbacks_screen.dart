import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'package:intl/intl.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MODÈLES
// ═══════════════════════════════════════════════════════════════════════════════

enum FeedbackStatus { all, replied, unanswered }

class FeedbackItem {
  final String id;
  final String userName;
  final String userEmail;
  final String initials;
  final String feedback;
  final String? response;
  final DateTime date;

  const FeedbackItem({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.initials,
    required this.feedback,
    this.response,
    required this.date,
  });

  bool get isReplied => response != null && response!.isNotEmpty;

  FeedbackItem copyWith({String? response}) => FeedbackItem(
        id: id,
        userName: userName,
        userEmail: userEmail,
        initials: initials,
        feedback: feedback,
        response: response ?? this.response,
        date: date,
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// BREAKPOINTS
// ═══════════════════════════════════════════════════════════════════════════════

class _BP {
  static bool isMobile(BuildContext ctx) => MediaQuery.of(ctx).size.width < 600;
  static bool isTablet(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 600 &&
      MediaQuery.of(ctx).size.width < 1024;
  static bool isDesktop(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 1024;
}

// ═══════════════════════════════════════════════════════════════════════════════
// ÉCRAN
// ═══════════════════════════════════════════════════════════════════════════════

class MyFeedbacksScreen extends StatefulWidget {
  final String language;

  const MyFeedbacksScreen({
    super.key,
    this.language = 'en',
  });

  @override
  State<MyFeedbacksScreen> createState() => _MyFeedbacksScreenState();
}

class _MyFeedbacksScreenState extends State<MyFeedbacksScreen> {
  static const Color primary = Color(0xFF00B4A6);

  FeedbackStatus _status = FeedbackStatus.all;
  int _selectedYear = 2026;
  int? _selectedMonth;
  String _searchUser = '';
  int _nextId = 2;

  final List<FeedbackItem> _feedbacks = [
    FeedbackItem(
      id: '1',
      userName: 'Membre',
      userEmail: 'wbouguila@gmail.com',
      initials: 'BW',
      feedback: 'TEST',
      date: DateTime(2023, 8, 11, 15, 6),
    ),
  ];

  // ── Filtrage ───────────────────────────────────────────────────────────────

  List<FeedbackItem> get _filtered => _feedbacks.where((f) {
        final matchStatus = _status == FeedbackStatus.all ||
            (_status == FeedbackStatus.replied && f.isReplied) ||
            (_status == FeedbackStatus.unanswered && !f.isReplied);
        final matchYear = f.date.year == _selectedYear;
        final matchMonth =
            _selectedMonth == null || f.date.month == _selectedMonth;
        final matchUser = _searchUser.isEmpty ||
            f.userName.toLowerCase().contains(_searchUser.toLowerCase());
        return matchStatus && matchYear && matchMonth && matchUser;
      }).toList();

  // ── Ajout feedback ─────────────────────────────────────────────────────────

  void _showAddFeedbackDialog() {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final feedbackCtrl = TextEditingController();
    String? errorMsg;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) {
          final mobile = _BP.isMobile(ctx);
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Row(
              children: [
                Icon(Icons.feedback_outlined, color: primary, size: 20),
                SizedBox(width: 8),
                Flexible(
                  child: Text('Ajouter un feedback',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
            content: SizedBox(
              width: mobile ? double.maxFinite : 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom + Email : colonne sur mobile, ligne sinon
                  mobile
                      ? Column(children: [
                          _formField('Nom *', nameCtrl,
                              hint: 'ex: Alice Dupont'),
                          const SizedBox(height: 10),
                          _formField('Email *', emailCtrl,
                              hint: 'alice@exemple.com'),
                        ])
                      : Row(children: [
                          Expanded(
                              child: _formField('Nom *', nameCtrl,
                                  hint: 'ex: Alice Dupont')),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _formField('Email *', emailCtrl,
                                  hint: 'alice@exemple.com')),
                        ]),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Feedback *',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF9E9E9E))),
                      const SizedBox(height: 4),
                      TextField(
                        controller: feedbackCtrl,
                        maxLines: 4,
                        style: const TextStyle(fontSize: 13),
                        decoration:
                            _inputDeco(hint: 'Saisissez le feedback...'),
                      ),
                    ],
                  ),
                  if (errorMsg != null) ...[
                    const SizedBox(height: 8),
                    Text(errorMsg!,
                        style: const TextStyle(
                            color: Color(0xFFE53935), fontSize: 12)),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Annuler',
                    style: TextStyle(color: Color(0xFF9E9E9E))),
              ),
              ElevatedButton(
                style: _btnStyle(primary),
                onPressed: () {
                  final name = nameCtrl.text.trim();
                  final email = emailCtrl.text.trim();
                  final feedbackText = feedbackCtrl.text.trim();

                  if (name.isEmpty || email.isEmpty || feedbackText.isEmpty) {
                    setDlg(() =>
                        errorMsg = 'Tous les champs marqués * sont requis.');
                    return;
                  }

                  final parts = name.split(' ');
                  final initials = parts.length >= 2
                      ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
                      : name
                          .substring(0, name.length >= 2 ? 2 : 1)
                          .toUpperCase();

                  setState(() {
                    _feedbacks.add(FeedbackItem(
                      id: '${_nextId++}',
                      userName: name,
                      userEmail: email,
                      initials: initials,
                      feedback: feedbackText,
                      date: DateTime.now(),
                    ));
                    _selectedYear = DateTime.now().year;
                  });
                  Navigator.pop(ctx);
                },
                child: const Text('Ajouter'),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Répondre au feedback ───────────────────────────────────────────────────

  void _showReplyDialog(FeedbackItem item) {
    final replyCtrl = TextEditingController(text: item.response ?? '');

    showDialog(
      context: context,
      builder: (ctx) {
        final mobile = _BP.isMobile(ctx);
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Row(
            children: [
              Icon(Icons.reply_outlined, color: primary, size: 20),
              SizedBox(width: 8),
              Flexible(
                child: Text('Répondre au feedback',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
          content: SizedBox(
            width: mobile ? double.maxFinite : 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        _avatar(item.initials),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.userName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1A1A2E))),
                                Text(item.userEmail,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF9E9E9E))),
                              ]),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Text(item.feedback,
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF555555))),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Votre réponse',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
                const SizedBox(height: 4),
                TextField(
                  controller: replyCtrl,
                  maxLines: 4,
                  style: const TextStyle(fontSize: 13),
                  decoration: _inputDeco(hint: 'Saisissez votre réponse...'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annuler',
                  style: TextStyle(color: Color(0xFF9E9E9E))),
            ),
            ElevatedButton(
              style: _btnStyle(primary),
              onPressed: () {
                final reply = replyCtrl.text.trim();
                final idx = _feedbacks.indexWhere((f) => f.id == item.id);
                if (idx != -1) {
                  setState(() {
                    _feedbacks[idx] = _feedbacks[idx].copyWith(response: reply);
                  });
                }
                Navigator.pop(ctx);
              },
              child: const Text('Envoyer'),
            ),
          ],
        );
      },
    );
  }

  // ── Suppression ────────────────────────────────────────────────────────────

  void _deleteItem(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Supprimer le feedback',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        content: const Text('Voulez-vous vraiment supprimer ce feedback ?',
            style: TextStyle(fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(color: Color(0xFF9E9E9E))),
          ),
          ElevatedButton(
            style: _btnStyle(const Color(0xFFE53935)),
            onPressed: () {
              setState(() => _feedbacks.removeWhere((f) => f.id == id));
              Navigator.pop(context);
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  // ── Build principal ────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    final dateFmt = DateFormat('dd MMM yyyy, HH:mm');
    final mobile = _BP.isMobile(context);
    final tablet = _BP.isTablet(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Padding(
        padding: EdgeInsets.all(mobile ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            mobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Liste des Feedbacks',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E))),
                      const SizedBox(height: 4),
                      Wrap(children: [
                        _crumb('Home'),
                        const Icon(Icons.chevron_right,
                            size: 14, color: Color(0xFF9E9E9E)),
                        _crumb('Communication'),
                        const Icon(Icons.chevron_right,
                            size: 14, color: Color(0xFF9E9E9E)),
                        _crumb('Feedback', active: true),
                      ]),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                          icon: const Icon(Icons.add, size: 15),
                          label: const Text('Ajouter un feedback',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600)),
                          onPressed: _showAddFeedbackDialog,
                        ),
                      ),
                    ],
                  )
                : Row(children: [
                    const Text('Liste des Feedbacks',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E))),
                    const SizedBox(width: 10),
                    _crumb('Home'),
                    const Icon(Icons.chevron_right,
                        size: 14, color: Color(0xFF9E9E9E)),
                    _crumb('Communication'),
                    const Icon(Icons.chevron_right,
                        size: 14, color: Color(0xFF9E9E9E)),
                    _crumb('Feedback', active: true),
                    const Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      icon: const Icon(Icons.add, size: 15),
                      label: const Text('Ajouter un feedback',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                      onPressed: _showAddFeedbackDialog,
                    ),
                  ]),
            const SizedBox(height: 16),

            // ── Barre de filtres ──────────────────────────────────────────
            Container(
              padding: EdgeInsets.all(mobile ? 10 : 12),
              decoration: _cardDeco(),
              child: mobile
                  // Mobile : 2 lignes
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tabs
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            _tab('All', FeedbackStatus.all),
                            const SizedBox(width: 6),
                            _tab('Répondus', FeedbackStatus.replied),
                            const SizedBox(width: 6),
                            _tab('Sans réponse', FeedbackStatus.unanswered),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        // Dropdowns + search
                        Row(children: [
                          Expanded(
                              child: _ddWrap(DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                            value: _selectedYear,
                            isExpanded: true,
                            items: [2023, 2024, 2025, 2026]
                                .map((y) => DropdownMenuItem(
                                    value: y,
                                    child: Text('$y',
                                        style: const TextStyle(fontSize: 12))))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedYear = v!),
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 16),
                          )))),
                          const SizedBox(width: 6),
                          Expanded(
                              child: _ddWrap(DropdownButtonHideUnderline(
                                  child: DropdownButton<int?>(
                            value: _selectedMonth,
                            isExpanded: true,
                            hint: const Text('Tous',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF9E9E9E))),
                            items: [null, ...List.generate(12, (i) => i + 1)]
                                .map((m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(
                                        m == null
                                            ? 'Tous'
                                            : DateFormat('MMM')
                                                .format(DateTime(2026, m)),
                                        style: const TextStyle(fontSize: 12))))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedMonth = v),
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 16),
                          )))),
                        ]),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 36,
                          child: TextField(
                            onChanged: (v) => setState(() => _searchUser = v),
                            style: const TextStyle(fontSize: 13),
                            decoration: _inputDeco(
                              hint: 'Rechercher un utilisateur',
                              prefixIcon: const Icon(Icons.search,
                                  size: 16, color: Color(0xFFBDBDBD)),
                            ),
                          ),
                        ),
                      ],
                    )
                  // Tablet / Desktop : 1 ligne
                  : Row(children: [
                      _tab('All', FeedbackStatus.all),
                      const SizedBox(width: 6),
                      _tab('Répondus', FeedbackStatus.replied),
                      const SizedBox(width: 6),
                      _tab('Sans réponse', FeedbackStatus.unanswered),
                      const Spacer(),
                      _ddWrap(DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                        value: _selectedYear,
                        items: [2023, 2024, 2025, 2026]
                            .map((y) => DropdownMenuItem(
                                value: y,
                                child: Text('$y',
                                    style: const TextStyle(fontSize: 13))))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedYear = v!),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                      ))),
                      const SizedBox(width: 8),
                      _ddWrap(DropdownButtonHideUnderline(
                          child: DropdownButton<int?>(
                        value: _selectedMonth,
                        hint: const Text('Tous les mois',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF9E9E9E))),
                        items: [null, ...List.generate(12, (i) => i + 1)]
                            .map((m) => DropdownMenuItem(
                                value: m,
                                child: Text(
                                    m == null
                                        ? 'Tous'
                                        : DateFormat('MMMM')
                                            .format(DateTime(2026, m)),
                                    style: const TextStyle(fontSize: 13))))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedMonth = v),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                      ))),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: tablet ? 150 : 180,
                        height: 36,
                        child: TextField(
                          onChanged: (v) => setState(() => _searchUser = v),
                          style: const TextStyle(fontSize: 13),
                          decoration: _inputDeco(
                            hint: 'Rechercher un utilisateur',
                            prefixIcon: const Icon(Icons.search,
                                size: 16, color: Color(0xFFBDBDBD)),
                          ),
                        ),
                      ),
                    ]),
            ),
            const SizedBox(height: 12),

            // ── Tableau / Liste ───────────────────────────────────────────
            Expanded(
              child: Container(
                decoration: _cardDeco(),
                child: Column(children: [
                  // En-tête : masqué sur mobile
                  if (!mobile)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                          color: Color(0xFFF9FAFB),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8))),
                      child: Row(children: [
                        Expanded(flex: 2, child: const _TH('UTILISATEUR')),
                        Expanded(flex: 3, child: const _TH('FEEDBACK')),
                        if (!tablet)
                          Expanded(flex: 3, child: const _TH('RÉPONSE')),
                        Expanded(flex: 2, child: const _TH('DATE')),
                        const SizedBox(width: 80, child: _TH('STATUT')),
                        const SizedBox(width: 80, child: _TH('ACTIONS')),
                      ]),
                    ),
                  if (!mobile)
                    const Divider(height: 1, color: Color(0xFFF0F0F0)),

                  _filtered.isEmpty
                      ? const Expanded(
                          child: Center(
                              child: Text('Aucun feedback à afficher.',
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xFF9E9E9E)))))
                      : Expanded(
                          child: ListView.separated(
                            itemCount: _filtered.length,
                            separatorBuilder: (_, __) => const Divider(
                                height: 1, color: Color(0xFFF0F0F0)),
                            itemBuilder: (ctx, i) {
                              final f = _filtered[i];
                              return mobile
                                  ? _feedbackCard(f, dateFmt)
                                  : _feedbackRow(f, dateFmt, tablet);
                            },
                          ),
                        ),

                  // Pagination
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF9FAFB),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(8)),
                        border:
                            Border(top: BorderSide(color: Color(0xFFE5E7EB)))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_filtered.length} feedback${_filtered.length > 1 ? 's' : ''}',
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF9E9E9E)),
                          ),
                          Row(children: [
                            _pgBtn('<'),
                            Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                    color: primary, shape: BoxShape.circle),
                                child: const Center(
                                    child: Text('1',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)))),
                            _pgBtn('>'),
                          ]),
                        ]),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Ligne tableau (tablet/desktop) ─────────────────────────────────────────

  Widget _feedbackRow(FeedbackItem f, DateFormat dateFmt, bool tablet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Row(children: [
            _avatar(f.initials),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(f.userName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1A2E))),
                  Text(f.userEmail,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
          ]),
        ),
        Expanded(
          flex: 3,
          child: Text(f.feedback,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 12, color: Color(0xFF555555))),
        ),
        // Colonne Réponse masquée sur tablet
        if (!tablet)
          Expanded(
            flex: 3,
            child: f.isReplied
                ? Text(f.response!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFF555555)))
                : const Text('—',
                    style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD))),
          ),
        Expanded(
          flex: 2,
          child: Text(dateFmt.format(f.date),
              style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
        ),
        SizedBox(width: 80, child: _statusBadge(f.isReplied)),
        SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: 'Répondre',
                child: InkWell(
                  onTap: () => _showReplyDialog(f),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      f.isReplied ? Icons.edit_outlined : Icons.reply_outlined,
                      size: 18,
                      color: primary,
                    ),
                  ),
                ),
              ),
              Tooltip(
                message: 'Supprimer',
                child: InkWell(
                  onTap: () => _deleteItem(f.id),
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.delete_outline,
                        size: 18, color: Color(0xFF9E9E9E)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  // ── Card mobile ────────────────────────────────────────────────────────────

  Widget _feedbackCard(FeedbackItem f, DateFormat dateFmt) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 1))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Utilisateur + statut
          Row(children: [
            _avatar(f.initials),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(f.userName,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E))),
                  Text(f.userEmail,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E))),
                ])),
            _statusBadge(f.isReplied),
          ]),
          const SizedBox(height: 10),
          // Feedback
          Text('Feedback',
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 0.4)),
          const SizedBox(height: 2),
          Text(f.feedback,
              style: const TextStyle(fontSize: 13, color: Color(0xFF555555))),
          if (f.isReplied) ...[
            const SizedBox(height: 8),
            Text('Réponse',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF9E9E9E),
                    letterSpacing: 0.4)),
            const SizedBox(height: 2),
            Text(f.response!,
                style: const TextStyle(fontSize: 13, color: Color(0xFF555555))),
          ],
          const SizedBox(height: 10),
          // Pied : date + actions
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(dateFmt.format(f.date),
                style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            Row(children: [
              InkWell(
                onTap: () => _showReplyDialog(f),
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    f.isReplied ? Icons.edit_outlined : Icons.reply_outlined,
                    size: 20,
                    color: primary,
                  ),
                ),
              ),
              InkWell(
                onTap: () => _deleteItem(f.id),
                borderRadius: BorderRadius.circular(4),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.delete_outline,
                      size: 20, color: Color(0xFF9E9E9E)),
                ),
              ),
            ]),
          ]),
        ],
      ),
    );
  }

  // ── Widgets partagés ───────────────────────────────────────────────────────

  Widget _avatar(String initials) => CircleAvatar(
        radius: 16,
        backgroundColor: const Color(0xFFEF4444).withOpacity(0.15),
        child: Text(initials,
            style: const TextStyle(
                color: Color(0xFFEF4444),
                fontWeight: FontWeight.bold,
                fontSize: 11)),
      );

  Widget _statusBadge(bool replied) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: replied ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          replied ? 'Répondu' : 'En attente',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color:
                  replied ? const Color(0xFF2E7D32) : const Color(0xFFE65100)),
        ),
      );

  Widget _formField(String label, TextEditingController ctrl,
          {String? hint, TextInputType? keyboardType}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
          const SizedBox(height: 4),
          SizedBox(
            height: 36,
            child: TextField(
              controller: ctrl,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 13),
              decoration: _inputDeco(hint: hint),
            ),
          ),
        ],
      );

  Widget _tab(String label, FeedbackStatus status) {
    final sel = _status == status;
    return GestureDetector(
      onTap: () => setState(() => _status = status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: sel ? primary : const Color(0xFFE0E0E0)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                color: sel ? primary : const Color(0xFF555555),
                fontWeight: sel ? FontWeight.w600 : FontWeight.normal)),
      ),
    );
  }

  Widget _ddWrap(Widget child) => Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(6)),
      child: child);

  Widget _pgBtn(String label) => InkWell(
      onTap: () {},
      child: Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(4)),
          child: Center(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF555555))))));

  Widget _crumb(String label, {bool active = false}) => Text(label,
      style: TextStyle(
          fontSize: 12,
          color: active ? primary : const Color(0xFF9E9E9E),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal));

  // ── Décos statiques ────────────────────────────────────────────────────────

  static BoxDecoration _cardDeco() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ]);

  static InputDecoration _inputDeco({String? hint, Widget? prefixIcon}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: primary, width: 1.5)),
        filled: true,
        fillColor: Colors.white,
      );

  static ButtonStyle _btnStyle(Color bg) => ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );
}

// ── Column header ──────────────────────────────────────────────────────────────

class _TH extends StatelessWidget {
  final String text;
  const _TH(this.text);

  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF9E9E9E),
          letterSpacing: 0.4));
}
