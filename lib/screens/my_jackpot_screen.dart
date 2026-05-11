import 'package:flutter/material.dart';
import 'dart:math' as math;

// ═══════════════════════════════════════════════════════════════════════════════
// MODÈLES
// ═══════════════════════════════════════════════════════════════════════════════

class LinkedUser {
  final String id;
  final String name;
  final String email;
  final String dailyRate;
  final String craStatus;
  final String type;
  final double gains;
  final double retraits;

  const LinkedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.dailyRate,
    required this.craStatus,
    required this.type,
    required this.gains,
    required this.retraits,
  });

  double get jackpot => gains - retraits;
  double get primePercent => gains == 0 ? 0 : (retraits / gains) * 100;
  String get gainPerDay => '${(gains / 30).toStringAsFixed(2)} €/j';
}

// ═══════════════════════════════════════════════════════════════════════════════
// BREAKPOINTS
// ═══════════════════════════════════════════════════════════════════════════════

class _BP {
  static bool isMobile(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width < 600;
  static bool isTablet(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    return w >= 600 && w < 960;
  }
  static bool isDesktop(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 960;
}

// ═══════════════════════════════════════════════════════════════════════════════
// ÉCRAN MY JACKPOT
// ═══════════════════════════════════════════════════════════════════════════════

class MyJackpotScreen extends StatefulWidget {
  const MyJackpotScreen({super.key});

  @override
  State<MyJackpotScreen> createState() => _MyJackpotScreenState();
}

class _MyJackpotScreenState extends State<MyJackpotScreen> {
  static const Color primary = Color(0xFF00B4A6);

  int _selectedYear = 2026;
  int _selectedMonth = 4;
  String _searchUser = '';
  int _nextId = 2;

  final List<LinkedUser> _users = [
    const LinkedUser(
      id: '1',
      name: 'Chiheb Sayah',
      email: 'chihabsayah66@gmail.com',
      dailyRate: 'NA',
      craStatus: 'CRA not found',
      type: 'profile',
      gains: 0,
      retraits: 0,
    ),
  ];

  // ── Calculs ────────────────────────────────────────────────────────────────

  List<LinkedUser> get _filteredUsers => _users.where((u) {
        final q = _searchUser.toLowerCase();
        return q.isEmpty ||
            u.name.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q);
      }).toList();

  double get _totalGains =>
      _filteredUsers.fold(0, (s, u) => s + u.gains);
  double get _totalRetraits =>
      _filteredUsers.fold(0, (s, u) => s + u.retraits);
  double get _jackpot => _totalGains - _totalRetraits;
  double get _jackpotTotal =>
      _users.fold(0.0, (s, u) => s + u.jackpot);
  double get _bonusPercent =>
      _totalGains == 0 ? 0 : (_totalRetraits / _totalGains) * 100;
  double get _notEarnedPercent => 100 - _bonusPercent;

  // ── Ajout candidat ─────────────────────────────────────────────────────────

  void _showAddCandidatDialog() {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final tjmCtrl = TextEditingController();
    final gainsCtrl = TextEditingController();
    final retraitsCtrl = TextEditingController();
    String selectedType = 'profile';
    String selectedCra = 'OK';
    String? errorMsg;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          title: const Row(
            children: [
              Icon(Icons.person_add_outlined,
                  color: primary, size: 20),
              SizedBox(width: 8),
              Text('Ajouter un candidat',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom + Email
                  Row(
                    children: [
                      Expanded(
                          child: _dlgField('Nom complet *', nameCtrl,
                              hint: 'ex: Alice Dupont')),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _dlgField('Email *', emailCtrl,
                              hint: 'alice@exemple.com')),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // TJM + Type
                  Row(
                    children: [
                      Expanded(
                          child: _dlgField('TJM (€)', tjmCtrl,
                              hint: 'ex: 450',
                              keyboardType: TextInputType.number)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text('Type',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF9E9E9E))),
                            const SizedBox(height: 4),
                            _dlgDropdown<String>(
                              value: selectedType,
                              items: const [
                                'profile',
                                'consultant',
                                'freelance'
                              ],
                              onChanged: (v) =>
                                  setDlgState(() =>
                                      selectedType = v!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Gains + Retraits
                  Row(
                    children: [
                      Expanded(
                          child: _dlgField(
                              'Gains ce mois (€)', gainsCtrl,
                              hint: 'ex: 2000',
                              keyboardType: TextInputType.number)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _dlgField(
                              'Retraits ce mois (€)', retraitsCtrl,
                              hint: 'ex: 500',
                              keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Statut CRA
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Statut CRA',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9E9E9E))),
                      const SizedBox(height: 4),
                      _dlgDropdown<String>(
                        value: selectedCra,
                        items: const [
                          'OK',
                          'CRA not found',
                          'En attente'
                        ],
                        onChanged: (v) =>
                            setDlgState(() => selectedCra = v!),
                      ),
                    ],
                  ),

                  if (errorMsg != null) ...[
                    const SizedBox(height: 10),
                    Text(errorMsg!,
                        style: const TextStyle(
                            color: Color(0xFFE53935),
                            fontSize: 12)),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              onPressed: () {
                final name = nameCtrl.text.trim();
                final email = emailCtrl.text.trim();
                if (name.isEmpty || email.isEmpty) {
                  setDlgState(() =>
                      errorMsg = 'Nom et email sont requis.');
                  return;
                }
                final gains =
                    double.tryParse(gainsCtrl.text) ?? 0;
                final retraits =
                    double.tryParse(retraitsCtrl.text) ?? 0;
                if (retraits > gains) {
                  setDlgState(() => errorMsg =
                      'Les retraits ne peuvent pas dépasser les gains.');
                  return;
                }
                final tjmRaw = tjmCtrl.text.trim();
                setState(() {
                  _users.add(LinkedUser(
                    id: '${_nextId++}',
                    name: name,
                    email: email,
                    dailyRate: tjmRaw.isEmpty ? 'NA' : tjmRaw,
                    craStatus: selectedCra,
                    type: selectedType,
                    gains: gains,
                    retraits: retraits,
                  ));
                });
                Navigator.pop(ctx);
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Suppression candidat ───────────────────────────────────────────────────

  void _deleteUser(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        title: const Text('Confirmer la suppression',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        content: const Text(
            'Voulez-vous vraiment supprimer ce candidat ?',
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            onPressed: () {
              setState(() => _users.removeWhere((u) => u.id == id));
              Navigator.pop(context);
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isMobile = _BP.isMobile(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              child: Column(
                children: [
                  _buildEarningsRow(context),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildLinkedUsers(context),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildExtractionList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    final isMobile = _BP.isMobile(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
          isMobile ? 12 : 16, 14, isMobile ? 12 : 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Jackpot - Membre',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E)),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right,
                            size: 13, color: Color(0xFF9E9E9E)),
                        _crumb('Home'),
                        const Icon(Icons.chevron_right,
                            size: 13, color: Color(0xFF9E9E9E)),
                        _crumb('Jackpot', active: true),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primary,
                          side: const BorderSide(color: primary),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        icon: const Icon(Icons.person_add_outlined,
                            size: 15),
                        label: const Text('Ajouter un candidat',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        onPressed: _showAddCandidatDialog,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    const Text(
                      'Jackpot - Membre',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E)),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.chevron_right,
                        size: 14, color: Color(0xFF9E9E9E)),
                    _crumb('Home'),
                    const Icon(Icons.chevron_right,
                        size: 14, color: Color(0xFF9E9E9E)),
                    _crumb('Jackpot', active: true),
                    const Spacer(),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primary,
                        side: const BorderSide(color: primary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      icon: const Icon(Icons.person_add_outlined,
                          size: 15),
                      label: const Text('Ajouter un candidat',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      onPressed: _showAddCandidatDialog,
                    ),
                  ],
                ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),

          // Filtres
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 36,
                      child: TextField(
                        onChanged: (v) =>
                            setState(() => _searchUser = v),
                        style: const TextStyle(fontSize: 13),
                        decoration: _inputDecor('Rechercher un utilisateur',
                            prefix: const Icon(Icons.search,
                                size: 16,
                                color: Color(0xFFBDBDBD))),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _yearDropdown()),
                        const SizedBox(width: 8),
                        Expanded(child: _monthDropdown()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        onPressed: _showPaymentDialog,
                        child: const Text('Demande de paiement',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 36,
                      child: TextField(
                        onChanged: (v) =>
                            setState(() => _searchUser = v),
                        style: const TextStyle(fontSize: 13),
                        decoration: _inputDecor(
                            'Rechercher un utilisateur',
                            prefix: const Icon(Icons.search,
                                size: 16,
                                color: Color(0xFFBDBDBD))),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _yearDropdown(),
                    const SizedBox(width: 10),
                    _monthDropdown(),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      onPressed: _showPaymentDialog,
                      child: const Text('Demande de paiement',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  // ── Earnings ───────────────────────────────────────────────────────────────

  Widget _buildEarningsRow(BuildContext context) {
    final isMobile = _BP.isMobile(context);

    final earningsCard = Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecor(),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Gains',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1A1A2E))),
                const SizedBox(height: 14),
                _statLine('Total restant',
                    '${_jackpot.toStringAsFixed(2)} €'),
                const SizedBox(height: 6),
                _statLine('Retraits',
                    '${_totalRetraits.toStringAsFixed(2)} €'),
                const SizedBox(height: 6),
                _statLine('Total ce mois',
                    '${_totalGains.toStringAsFixed(2)} €'),
                const SizedBox(height: 12),
                Text(
                  'Estimation: ${(_jackpot / 30).toStringAsFixed(2)} €/j',
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF9E9E9E)),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _DonutChart(
                      percent: _notEarnedPercent.clamp(0, 100),
                      color: const Color(0xFFE8704A),
                      label:
                          '${_notEarnedPercent.clamp(0, 100).toStringAsFixed(0)} %',
                      subLabel: 'non gagné',
                      size: 90,
                    ),
                    _DonutChart(
                      percent: _bonusPercent.clamp(0, 100),
                      color: primary,
                      label:
                          '${_bonusPercent.clamp(0, 100).toStringAsFixed(0)} %',
                      subLabel: 'AUTO',
                      size: 90,
                    ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Gains',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1A1A2E))),
                      const SizedBox(height: 14),
                      _statLine('Total restant',
                          '${_jackpot.toStringAsFixed(2)} €'),
                      const SizedBox(height: 6),
                      _statLine('Retraits',
                          '${_totalRetraits.toStringAsFixed(2)} €'),
                      const SizedBox(height: 6),
                      _statLine('Total ce mois',
                          '${_totalGains.toStringAsFixed(2)} €'),
                      const SizedBox(height: 12),
                      Text(
                        'Estimation (par jour et OneShot Bonus): '
                        '${(_jackpot / 30).toStringAsFixed(2)} €',
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF9E9E9E)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _DonutChart(
                  percent: _notEarnedPercent.clamp(0, 100),
                  color: const Color(0xFFE8704A),
                  label:
                      '${_notEarnedPercent.clamp(0, 100).toStringAsFixed(0)} %',
                  subLabel: 'non gagné',
                ),
                const SizedBox(width: 16),
                _DonutChart(
                  percent: _bonusPercent.clamp(0, 100),
                  color: primary,
                  label:
                      '${_bonusPercent.clamp(0, 100).toStringAsFixed(0)} %',
                  subLabel: 'AUTO',
                ),
              ],
            ),
    );

    final primeCard = Container(
      width: isMobile ? double.infinity : 180,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecor(),
      child: isMobile
          ? Row(
              children: [
                _inboxIcon(),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Liste des primes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1A1A2E))),
                    const SizedBox(height: 2),
                    Text(
                      'Total: ${_jackpotTotal.toStringAsFixed(2)} €',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                _inboxIcon(),
                const SizedBox(height: 10),
                const Text('Liste des primes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF1A1A2E))),
                const SizedBox(height: 4),
                Text(
                  'Total: ${_jackpotTotal.toStringAsFixed(2)} €',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
    );

    if (isMobile) {
      return Column(
        children: [
          earningsCard,
          const SizedBox(height: 12),
          primeCard,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: earningsCard),
        const SizedBox(width: 16),
        primeCard,
      ],
    );
  }

  Widget _inboxIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            color: Color(0xFFE3F2FD),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.inbox_outlined,
              color: Color(0xFF1976D2), size: 26),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
                color: Color(0xFFF44336), shape: BoxShape.circle),
            child: Center(
              child: Text('${_users.length}',
                  style:
                      const TextStyle(color: Colors.white, fontSize: 9)),
            ),
          ),
        ),
      ],
    );
  }

  // ── Linked Users ───────────────────────────────────────────────────────────

  Widget _buildLinkedUsers(BuildContext context) {
    final isMobile = _BP.isMobile(context);

    return Container(
      decoration: _cardDecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                const Text('Candidats liés',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1A1A2E))),
                const Spacer(),
                Text(
                  '${_filteredUsers.length} candidat${_filteredUsers.length > 1 ? 's' : ''}',
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          isMobile
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildUsersTable(),
                )
              : _buildUsersTable(),

          // Pagination
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                              fontWeight: FontWeight.bold))),
                ),
                _pgBtn('>'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersTable() {
    return Column(
      children: [
        Container(
          color: const Color(0xFFF9FAFB),
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: const Row(
            children: [
              SizedBox(width: 30),
              SizedBox(width: 170, child: _TH('CANDIDAT')),
              SizedBox(width: 80, child: _TH('TJM')),
              SizedBox(width: 110, child: _TH('STATUT CRA')),
              SizedBox(width: 80, child: _TH('TYPE')),
              SizedBox(width: 80, child: _TH('PRIME %')),
              SizedBox(width: 100, child: _TH('GAIN/JOUR')),
              SizedBox(width: 90, child: _TH('JACKPOT')),
              SizedBox(width: 40, child: _TH('')),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),

        if (_filteredUsers.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(
                child: Text('Aucun candidat trouvé.',
                    style: TextStyle(
                        color: Color(0xFF9E9E9E), fontSize: 13))),
          )
        else
          ..._filteredUsers.map(_userRow),
      ],
    );
  }

  Widget _userRow(LinkedUser u) {
    final ok = u.craStatus == 'OK';
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFF0F0F0)))),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: ok
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ok ? Icons.check : Icons.close,
              size: 13,
              color: ok
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFE53935),
            ),
          ),
          const SizedBox(width: 8),

          SizedBox(
            width: 170,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: primary.withOpacity(0.15),
                  child: Text(
                      u.name.isNotEmpty
                          ? u.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(u.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A2E))),
                      Text(u.email,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF9E9E9E))),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 80,
            child: Text(u.dailyRate,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF555555))),
          ),

          SizedBox(
            width: 110,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: ok
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                u.craStatus,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11,
                    color: ok
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFE53935),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),

          SizedBox(
            width: 80,
            child: Text(u.type,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF555555))),
          ),

          SizedBox(
            width: 80,
            child: Text(
              '${u.primePercent.toStringAsFixed(1)} %',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: u.primePercent > 50
                      ? const Color(0xFFE53935)
                      : primary),
            ),
          ),

          SizedBox(
            width: 100,
            child: Text(u.gainPerDay,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF555555))),
          ),

          SizedBox(
            width: 90,
            child: Text(
              '${u.jackpot.toStringAsFixed(2)} €',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E)),
            ),
          ),

          // Bouton supprimer
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.delete_outline,
                  size: 18, color: Color(0xFF9E9E9E)),
              tooltip: 'Supprimer',
              onPressed: () => _deleteUser(u.id),
              hoverColor: const Color(0xFFFFEBEE),
            ),
          ),
        ],
      ),
    );
  }

  // ── Extraction List ────────────────────────────────────────────────────────

  Widget _buildExtractionList() {
    return Container(
      decoration: _cardDecor(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text('Liste des extractions',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1A1A2E))),
          ),
          Divider(height: 1, color: Color(0xFFF0F0F0)),
          SizedBox(height: 40),
          Center(
            child: Text('Aucune donnée à afficher',
                style: TextStyle(
                    fontSize: 13, color: Color(0xFF9E9E9E))),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── Payment Dialog ─────────────────────────────────────────────────────────

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        title: const Text('Demande de paiement',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dlgRow('Gains du mois',
                '${_totalGains.toStringAsFixed(2)} €'),
            _dlgRow('Retraits du mois',
                '${_totalRetraits.toStringAsFixed(2)} €'),
            const Divider(),
            _dlgRow('Jackpot (gains − retraits)',
                '${_jackpot.toStringAsFixed(2)} €',
                bold: true),
            _dlgRow('Prime % (retraits / gains × 100)',
                '${_bonusPercent.toStringAsFixed(1)} %'),
            _dlgRow('Jackpot total (tous candidats)',
                '${_jackpotTotal.toStringAsFixed(2)} €'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(color: Color(0xFF9E9E9E))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  BoxDecoration _cardDecor() => BoxDecoration(
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

  Widget _crumb(String label, {bool active = false}) => Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: active ? primary : const Color(0xFF9E9E9E),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
        ),
      );

  Widget _statLine(String label, String value) => Row(
        children: [
          Flexible(
            child: Text('$label  ',
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF9E9E9E))),
          ),
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00B4A6))),
        ],
      );

  Widget _dlgRow(String label, String value, {bool bold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF555555)))),
            Text(value,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        bold ? FontWeight.bold : FontWeight.w500,
                    color: const Color(0xFF1A1A2E))),
          ],
        ),
      );

  Widget _dlgField(String label, TextEditingController ctrl,
      {String? hint, TextInputType? keyboardType}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: Color(0xFF9E9E9E))),
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

  Widget _dlgDropdown<T>({
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) =>
      _ddWrapper(
        DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            items: items
                .map((e) => DropdownMenuItem<T>(
                    value: e,
                    child: Text('$e',
                        style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: onChanged,
            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          ),
        ),
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
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF555555)))),
        ),
      );

  InputDecoration _inputDecor(String hint, {Widget? prefix}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            fontSize: 12, color: Color(0xFFBDBDBD)),
        prefixIcon: prefix,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
      );

  Widget _yearDropdown() => _ddWrapper(
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedYear,
            isExpanded: true,
            items: [2024, 2025, 2026]
                .map((y) => DropdownMenuItem(
                    value: y,
                    child: Text('$y',
                        style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: (v) => setState(() => _selectedYear = v!),
            icon:
                const Icon(Icons.keyboard_arrow_down, size: 18),
          ),
        ),
      );

  Widget _monthDropdown() => _ddWrapper(
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedMonth,
            isExpanded: true,
            items: List.generate(
                12,
                (i) => DropdownMenuItem(
                      value: i + 1,
                      child: Text(
                          '$_selectedYear-${(i + 1).toString().padLeft(2, '0')}',
                          style: const TextStyle(fontSize: 13)),
                    )).toList(),
            onChanged: (v) =>
                setState(() => _selectedMonth = v!),
            icon:
                const Icon(Icons.keyboard_arrow_down, size: 18),
          ),
        ),
      );

  Widget _ddWrapper(Widget child) => Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: child,
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// DONUT CHART
// ═══════════════════════════════════════════════════════════════════════════════

class _DonutChart extends StatelessWidget {
  final double percent;
  final Color color;
  final String label;
  final String subLabel;
  final double size;

  const _DonutChart({
    required this.percent,
    required this.color,
    required this.label,
    required this.subLabel,
    this.size = 110,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _DonutPainter(percent: percent, color: color),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size < 100 ? 13 : 15,
                      color: color)),
              Text(subLabel,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF9E9E9E))),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double percent;
  final Color color;

  _DonutPainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = size.width / 2 - 10;
    const strokeW = 14.0;

    final bg = Paint()
      ..color = const Color(0xFFF0F0F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    final rect =
        Rect.fromCircle(center: Offset(cx, cy), radius: radius);
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi, false, bg);
    if (percent > 0) {
      canvas.drawArc(rect, -math.pi / 2,
          2 * math.pi * (percent / 100), false, fg);
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
      old.percent != percent || old.color != color;
}

// ── Column header ──────────────────────────────────────────────────────────────

class _TH extends StatelessWidget {
  final String text;
  const _TH(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF9E9E9E),
            letterSpacing: 0.4),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN — point d'entrée standalone (retirer si intégré dans votre app)
// ═══════════════════════════════════════════════════════════════════════════════

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyJackpotScreen(),
  ));
}