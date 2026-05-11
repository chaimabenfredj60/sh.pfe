import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'package:intl/intl.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MODÈLES
// ═══════════════════════════════════════════════════════════════════════════════

enum DocStatus { all, replied, unanswered }

enum DocType {
  attestation,
  contrat,
  bulletin,
  certificat,
  facture,
  autre,
}

extension DocTypeLabel on DocType {
  String get label {
    switch (this) {
      case DocType.attestation:
        return 'Attestation de travail';
      case DocType.contrat:
        return 'Contrat';
      case DocType.bulletin:
        return 'Bulletin de paie';
      case DocType.certificat:
        return 'Certificat';
      case DocType.facture:
        return 'Facture';
      case DocType.autre:
        return 'Autre';
    }
  }
}

class DocumentRequest {
  final String id;
  final String userName;
  final String userEmail;
  final String initials;
  final String request;
  final DocType docType;
  final String? response;
  final DateTime date;

  const DocumentRequest({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.initials,
    required this.request,
    required this.docType,
    this.response,
    required this.date,
  });

  bool get isReplied => response != null && response!.isNotEmpty;

  DocumentRequest copyWith({String? response}) => DocumentRequest(
        id: id,
        userName: userName,
        userEmail: userEmail,
        initials: initials,
        request: request,
        docType: docType,
        response: response ?? this.response,
        date: date,
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// BREAKPOINTS
// ═══════════════════════════════════════════════════════════════════════════════

enum _Screen { mobile, tablet, desktop }

_Screen _screen(double w) {
  if (w < 600) return _Screen.mobile;
  if (w < 900) return _Screen.tablet;
  return _Screen.desktop;
}

// ═══════════════════════════════════════════════════════════════════════════════
// ÉCRAN
// ═══════════════════════════════════════════════════════════════════════════════

class MyDocumentsScreen extends StatefulWidget {
  final String language;

  const MyDocumentsScreen({
    super.key,
    this.language = 'en',
  });

  @override
  State<MyDocumentsScreen> createState() => _MyDocumentsScreenState();
}

class _MyDocumentsScreenState extends State<MyDocumentsScreen> {
  static const Color primary = Color(0xFF00B4A6);

  DocStatus _status = DocStatus.all;
  int _selectedYear = 2026;
  int? _selectedMonth;
  int _nextId = 1;

  final List<DocumentRequest> _requests = [];

  // ── Filtrage ───────────────────────────────────────────────────────────────

  List<DocumentRequest> get _filtered => _requests.where((r) {
        final matchStatus = _status == DocStatus.all ||
            (_status == DocStatus.replied && r.isReplied) ||
            (_status == DocStatus.unanswered && !r.isReplied);
        final matchYear = r.date.year == _selectedYear;
        final matchMonth =
            _selectedMonth == null || r.date.month == _selectedMonth;
        return matchStatus && matchYear && matchMonth;
      }).toList();

  // ── Ajout demande ──────────────────────────────────────────────────────────

  void _showAddDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final detailCtrl = TextEditingController();
    DocType selectedType = DocType.attestation;
    String? errorMsg;
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Row(children: [
            Icon(Icons.file_present_outlined, color: primary, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text('Nouvelle demande de document',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ]),
          content: SizedBox(
            width: isMobile ? double.maxFinite : 460,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom + Email — colonne sur mobile, ligne sur desktop
                  if (isMobile) ...[
                    _formField('Nom complet *', nameCtrl,
                        hint: 'ex: Alice Dupont'),
                    const SizedBox(height: 12),
                    _formField('Email *', emailCtrl, hint: 'alice@exemple.com'),
                  ] else
                    Row(children: [
                      Expanded(
                          child: _formField('Nom complet *', nameCtrl,
                              hint: 'ex: Alice Dupont')),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _formField('Email *', emailCtrl,
                              hint: 'alice@exemple.com')),
                    ]),
                  const SizedBox(height: 12),

                  // Type de document
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Type de document *',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF9E9E9E))),
                      const SizedBox(height: 4),
                      _ddWrap(
                        DropdownButtonHideUnderline(
                          child: DropdownButton<DocType>(
                            value: selectedType,
                            isExpanded: true,
                            items: DocType.values
                                .map((t) => DropdownMenuItem(
                                    value: t,
                                    child: Text(t.label,
                                        style: const TextStyle(fontSize: 13))))
                                .toList(),
                            onChanged: (v) => setDlg(() => selectedType = v!),
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 18),
                          ),
                        ),
                        fullWidth: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Détail
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Détail / Motif',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF9E9E9E))),
                      const SizedBox(height: 4),
                      TextField(
                        controller: detailCtrl,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 13),
                        decoration: _inputDecor('Décrivez votre demande...'),
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
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annuler',
                  style: TextStyle(color: Color(0xFF9E9E9E))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final name = nameCtrl.text.trim();
                final email = emailCtrl.text.trim();
                if (name.isEmpty || email.isEmpty) {
                  setDlg(() => errorMsg = 'Nom et email sont requis.');
                  return;
                }
                final parts = name.split(' ');
                final initials = parts.length >= 2
                    ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
                    : name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
                final detail = detailCtrl.text.trim();
                setState(() {
                  _requests.add(DocumentRequest(
                    id: '${_nextId++}',
                    userName: name,
                    userEmail: email,
                    initials: initials,
                    request: detail.isEmpty
                        ? selectedType.label
                        : '${selectedType.label} — $detail',
                    docType: selectedType,
                    date: DateTime.now(),
                  ));
                  _selectedYear = DateTime.now().year;
                });
                Navigator.pop(ctx);
              },
              child: const Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Répondre ───────────────────────────────────────────────────────────────

  void _showReplyDialog(DocumentRequest r) {
    final replyCtrl = TextEditingController(text: r.response ?? '');
    final isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Row(children: [
          Icon(Icons.reply_outlined, color: primary, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text('Répondre à la demande',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
        ]),
        content: SizedBox(
          width: isMobile ? double.maxFinite : 460,
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
                child: Row(children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: primary.withOpacity(0.15),
                    child: Text(r.initials,
                        style: const TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.userName,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A2E))),
                        Text(r.userEmail,
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFF9E9E9E))),
                        const SizedBox(height: 4),
                        _docTypeBadge(r.docType),
                        const SizedBox(height: 2),
                        Text(r.request,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF555555))),
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 12),
              const Text('Votre réponse',
                  style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
              const SizedBox(height: 4),
              TextField(
                controller: replyCtrl,
                maxLines: 4,
                style: const TextStyle(fontSize: 13),
                decoration: _inputDecor('Saisissez votre réponse...'),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              final idx = _requests.indexWhere((x) => x.id == r.id);
              if (idx != -1) {
                setState(() {
                  _requests[idx] =
                      _requests[idx].copyWith(response: replyCtrl.text.trim());
                });
              }
              Navigator.pop(ctx);
            },
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );
  }

  // ── Suppression ────────────────────────────────────────────────────────────

  void _deleteRequest(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Supprimer la demande',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        content: const Text('Voulez-vous vraiment supprimer cette demande ?',
            style: TextStyle(fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(color: Color(0xFF9E9E9E))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              setState(() => _requests.removeWhere((r) => r.id == id));
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

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screen = _screen(constraints.maxWidth);
          final isMobile = screen == _Screen.mobile;

          return Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ─────────────────────────────────────────────────
                _buildHeader(context, screen),
                const SizedBox(height: 16),

                // ── Carte tableau ───────────────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: _card(),
                    child: Column(children: [
                      // Barre de filtres
                      _buildFilterBar(screen),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),

                      // En-tête colonnes (desktop uniquement)
                      if (screen == _Screen.desktop) ...[
                        _buildTableHeader(),
                        const Divider(height: 1, color: Color(0xFFF0F0F0)),
                      ],

                      // Corps
                      Expanded(
                        child: _filtered.isEmpty
                            ? _emptyState()
                            : ListView.separated(
                                itemCount: _filtered.length,
                                separatorBuilder: (_, __) => const Divider(
                                    height: 1, color: Color(0xFFF0F0F0)),
                                itemBuilder: (ctx, i) => screen ==
                                        _Screen.desktop
                                    ? _tableRow(_filtered[i], dateFmt)
                                    : _cardRow(_filtered[i], dateFmt, screen),
                              ),
                      ),

                      // Pied de page
                      _buildFooter(),
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, _Screen screen) {
    final isMobile = screen == _Screen.mobile;

    return Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Demandes de documents',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            // Breadcrumb masqué sur mobile
            if (!isMobile) ...[
              const SizedBox(height: 2),
              Row(children: [
                _crumb('Home'),
                const Icon(Icons.chevron_right,
                    size: 14, color: Color(0xFF9E9E9E)),
                _crumb('Communication'),
                const Icon(Icons.chevron_right,
                    size: 14, color: Color(0xFF9E9E9E)),
                _crumb('Requests', active: true),
              ]),
            ],
          ],
        ),
      ),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 12,
            vertical: 8,
          ),
        ),
        icon: const Icon(Icons.add, size: 15),
        // Texte court sur mobile
        label: Text(
          isMobile ? 'Nouveau' : 'Nouvelle demande',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        onPressed: () => _showAddDialog(context),
      ),
    ]);
  }

  // ── Barre de filtres ───────────────────────────────────────────────────────

  Widget _buildFilterBar(_Screen screen) {
    final isMobile = screen == _Screen.mobile;

    // Sur mobile : Wrap vertical, sur desktop : Row horizontal
    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs
            Wrap(spacing: 6, runSpacing: 6, children: [
              _tab('All', DocStatus.all),
              _tab('Traités', DocStatus.replied),
              _tab('En attente', DocStatus.unanswered),
            ]),
            const SizedBox(height: 10),
            // Filtres date
            Row(children: [
              Expanded(
                  child: _ddWrap(
                DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                  value: _selectedYear,
                  isExpanded: true,
                  items: [2023, 2024, 2025, 2026]
                      .map((y) => DropdownMenuItem(
                          value: y,
                          child:
                              Text('$y', style: const TextStyle(fontSize: 13))))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedYear = v!),
                  icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                )),
                fullWidth: true,
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: _ddWrap(
                DropdownButtonHideUnderline(
                    child: DropdownButton<int?>(
                  value: _selectedMonth,
                  isExpanded: true,
                  hint: const Text('Tous',
                      style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E))),
                  items: [null, ...List.generate(12, (i) => i + 1)]
                      .map((m) => DropdownMenuItem(
                          value: m,
                          child: Text(
                            m == null
                                ? 'Tous'
                                : DateFormat('MMM').format(DateTime(2026, m)),
                            style: const TextStyle(fontSize: 13),
                          )))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedMonth = v),
                  icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                )),
                fullWidth: true,
              )),
            ]),
          ],
        ),
      );
    }

    // Tablette / Desktop : Row classique
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(children: [
        _tab('All', DocStatus.all),
        const SizedBox(width: 6),
        _tab('Traités', DocStatus.replied),
        const SizedBox(width: 6),
        _tab('En attente', DocStatus.unanswered),
        const Spacer(),
        _ddWrap(DropdownButtonHideUnderline(
            child: DropdownButton<int>(
          value: _selectedYear,
          items: [2023, 2024, 2025, 2026]
              .map((y) => DropdownMenuItem(
                  value: y,
                  child: Text('$y', style: const TextStyle(fontSize: 13))))
              .toList(),
          onChanged: (v) => setState(() => _selectedYear = v!),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        ))),
        const SizedBox(width: 8),
        _ddWrap(DropdownButtonHideUnderline(
            child: DropdownButton<int?>(
          value: _selectedMonth,
          hint: const Text('Tous les mois',
              style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E))),
          items: [null, ...List.generate(12, (i) => i + 1)]
              .map((m) => DropdownMenuItem(
                  value: m,
                  child: Text(
                    m == null
                        ? 'Tous'
                        : DateFormat('MMMM').format(DateTime(2026, m)),
                    style: const TextStyle(fontSize: 13),
                  )))
              .toList(),
          onChanged: (v) => setState(() => _selectedMonth = v),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        ))),
      ]),
    );
  }

  // ── En-tête tableau (desktop) ───────────────────────────────────────────────

  Widget _buildTableHeader() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: const Color(0xFFF9FAFB),
        child: const Row(children: [
          Expanded(flex: 2, child: _TH('DEMANDEUR')),
          Expanded(flex: 2, child: _TH('TYPE')),
          Expanded(flex: 3, child: _TH('DÉTAIL')),
          Expanded(flex: 3, child: _TH('RÉPONSE')),
          Expanded(flex: 2, child: _TH('DATE')),
          SizedBox(width: 80, child: _TH('STATUT')),
          SizedBox(width: 80, child: _TH('ACTIONS')),
        ]),
      );

  // ── État vide ───────────────────────────────────────────────────────────────

  Widget _emptyState() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open_outlined,
                size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            const Text('Aucune demande',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9E9E9E))),
            const SizedBox(height: 4),
            const Text('Cliquez sur "Nouvelle demande" pour commencer.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD))),
          ],
        ),
      );

  // ── Pied de page ─────────────────────────────────────────────────────────────

  Widget _buildFooter() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_filtered.length} demande${_filtered.length > 1 ? 's' : ''}',
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
            ),
            Row(children: [
              _pgBtn('<'),
              Container(
                width: 28,
                height: 28,
                decoration:
                    const BoxDecoration(color: primary, shape: BoxShape.circle),
                child: const Center(
                  child: Text('1',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              _pgBtn('>'),
            ]),
          ],
        ),
      );

  // ── Ligne tableau (desktop) ────────────────────────────────────────────────

  Widget _tableRow(DocumentRequest r, DateFormat dateFmt) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(children: [
          // Demandeur
          Expanded(
              flex: 2,
              child: Row(children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: primary.withOpacity(0.15),
                  child: Text(r.initials,
                      style: const TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11)),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.userName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1A1A2E))),
                    Text(r.userEmail,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF9E9E9E))),
                  ],
                )),
              ])),

          // Type
          Expanded(flex: 2, child: _docTypeBadge(r.docType)),

          // Détail
          Expanded(
              flex: 3,
              child: Text(r.request,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF555555)))),

          // Réponse
          Expanded(
              flex: 3,
              child: r.isReplied
                  ? Text(r.response!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF555555)))
                  : const Text('—',
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)))),

          // Date
          Expanded(
              flex: 2,
              child: Text(dateFmt.format(r.date),
                  style:
                      const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)))),

          // Statut
          SizedBox(width: 80, child: _statusBadge(r.isReplied)),

          // Actions
          SizedBox(width: 80, child: _actionButtons(r)),
        ]),
      );

  // ── Carte item (mobile / tablette) ─────────────────────────────────────────

  Widget _cardRow(DocumentRequest r, DateFormat dateFmt, _Screen screen) {
    final isTablet = screen == _Screen.tablet;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 16 : 12,
        vertical: 12,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Avatar
        CircleAvatar(
          radius: 20,
          backgroundColor: primary.withOpacity(0.15),
          child: Text(r.initials,
              style: const TextStyle(
                  color: primary, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        const SizedBox(width: 12),

        // Contenu principal
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ligne 1 : nom + statut
              Row(children: [
                Expanded(
                  child: Text(r.userName,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E))),
                ),
                _statusBadge(r.isReplied),
              ]),

              const SizedBox(height: 2),
              // Email (masqué sur mobile pour gagner de la place)
              if (isTablet)
                Text(r.userEmail,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9E9E9E))),

              const SizedBox(height: 6),
              _docTypeBadge(r.docType),
              const SizedBox(height: 6),

              // Détail
              Text(r.request,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF555555))),

              // Réponse (si existante)
              if (r.isReplied) ...[
                const SizedBox(height: 4),
                Text('↩ ${r.response!}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF00B4A6))),
              ],

              const SizedBox(height: 6),
              // Date + actions
              Row(children: [
                Icon(Icons.access_time, size: 11, color: Colors.grey.shade400),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(dateFmt.format(r.date),
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E))),
                ),
                _actionButtons(r, compact: true),
              ]),
            ],
          ),
        ),
      ]),
    );
  }

  // ── Boutons d'action ───────────────────────────────────────────────────────

  Widget _actionButtons(DocumentRequest r, {bool compact = false}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: r.isReplied ? 'Modifier la réponse' : 'Répondre',
            child: InkWell(
              onTap: () => _showReplyDialog(r),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: EdgeInsets.all(compact ? 4 : 6),
                child: Icon(
                  r.isReplied ? Icons.edit_outlined : Icons.reply_outlined,
                  size: compact ? 16 : 18,
                  color: primary,
                ),
              ),
            ),
          ),
          Tooltip(
            message: 'Supprimer',
            child: InkWell(
              onTap: () => _deleteRequest(r.id),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: EdgeInsets.all(compact ? 4 : 6),
                child: Icon(Icons.delete_outline,
                    size: compact ? 16 : 18, color: const Color(0xFF9E9E9E)),
              ),
            ),
          ),
        ],
      );

  // ── Badge statut ────────────────────────────────────────────────────────────

  Widget _statusBadge(bool isReplied) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isReplied ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          isReplied ? 'Traité' : 'En attente',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color:
                isReplied ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
          ),
        ),
      );

  // ── Helpers ────────────────────────────────────────────────────────────────

  static Widget _docTypeBadge(DocType type) {
    final colors = <DocType, Color>{
      DocType.attestation: const Color(0xFF1976D2),
      DocType.contrat: const Color(0xFF7B1FA2),
      DocType.bulletin: const Color(0xFF00897B),
      DocType.certificat: const Color(0xFFF57C00),
      DocType.facture: const Color(0xFFE53935),
      DocType.autre: const Color(0xFF757575),
    };
    final c = colors[type] ?? const Color(0xFF757575);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: c.withOpacity(0.3)),
      ),
      child: Text(type.label,
          overflow: TextOverflow.ellipsis,
          style:
              TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: c)),
    );
  }

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
              decoration: _inputDecor(hint ?? ''),
            ),
          ),
        ],
      );

  static InputDecoration _inputDecor(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
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

  Widget _tab(String label, DocStatus status) {
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
              fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
            )),
      ),
    );
  }

  Widget _ddWrap(Widget child, {bool fullWidth = false}) => Container(
        height: 36,
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: child,
      );

  Widget _pgBtn(String label) => InkWell(
        onTap: () {},
        child: Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(label,
                style: const TextStyle(fontSize: 13, color: Color(0xFF555555))),
          ),
        ),
      );

  Widget _crumb(String label, {bool active = false}) => Text(label,
      style: TextStyle(
        fontSize: 12,
        color: active ? primary : const Color(0xFF9E9E9E),
        fontWeight: active ? FontWeight.w600 : FontWeight.normal,
      ));

  BoxDecoration _card() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
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
