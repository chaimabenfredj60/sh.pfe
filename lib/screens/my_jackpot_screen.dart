import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'dart:math' as math;

// ═══════════════════════════════════════════════════════════════════════════════
// MODÈLES
// ═══════════════════════════════════════════════════════════════════════════════

class LinkedUser {
  final String id;
  final String name;
  final String email;
  final String dailyRate;
  final String craStatus; // 'CRA not found' | 'OK'
  final String type; // 'profile' | 'mission' | 'AUTO'
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

  /// jackpot individuel = gains - retraits
  double get jackpot => gains - retraits;

  /// prime % = (retraits / gains) * 100
  double get primePercent => gains == 0 ? 0 : (retraits / gains) * 100;

  String get gainPerDay => '${(gains / 30).toStringAsFixed(2)} € per day';
}

class MonthlyEntry {
  final int year;
  final int month;
  final double gains;
  final double retraits;

  const MonthlyEntry({
    required this.year,
    required this.month,
    required this.gains,
    required this.retraits,
  });

  /// jackpot mensuel = gains - retraits
  double get jackpot => gains - retraits;
}

// ═══════════════════════════════════════════════════════════════════════════════
// DONNÉES DE DÉMO
// ═══════════════════════════════════════════════════════════════════════════════

final List<LinkedUser> _demoUsers = [
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

final List<MonthlyEntry> _demoEntries = [
  MonthlyEntry(year: 2026, month: 4, gains: 120, retraits: 30),
  MonthlyEntry(year: 2026, month: 3, gains: 200, retraits: 50),
  MonthlyEntry(year: 2026, month: 2, gains: 150, retraits: 20),
];

// ═══════════════════════════════════════════════════════════════════════════════
// ÉCRAN MY JACKPOT
// ═══════════════════════════════════════════════════════════════════════════════

class MyJackpotScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MyJackpotScreen({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });

  @override
  State<MyJackpotScreen> createState() => _MyJackpotScreenState();
}

class _MyJackpotScreenState extends State<MyJackpotScreen> {
  static const Color primary = Color(0xFF00B4A6);

  int _selectedYear = 2026;
  int _selectedMonth = 4;
  String _searchUser = '';

  // ── Calculs ────────────────────────────────────────────────────────────────

  List<MonthlyEntry> get _monthEntries => _demoEntries
      .where((e) => e.year == _selectedYear && e.month == _selectedMonth)
      .toList();

  /// Gains du mois sélectionné
  double get _totalGains => _monthEntries.fold(0, (s, e) => s + e.gains);

  /// Retraits du mois sélectionné
  double get _totalRetraits => _monthEntries.fold(0, (s, e) => s + e.retraits);

  /// jackpot = gains - retraits
  double get _jackpot => _totalGains - _totalRetraits;

  /// jackpot total = Σ gains tous mois - Σ retraits tous mois
  double get _jackpotTotal => _demoEntries.fold(0.0, (s, e) => s + e.jackpot);

  /// bonus % = (retraits / gains) * 100
  double get _bonusPercent =>
      _totalGains == 0 ? 0 : (_totalRetraits / _totalGains) * 100;

  /// % not earned = 100 - bonusPercent (donut orange)
  double get _notEarnedPercent => 100 - _bonusPercent;

  List<LinkedUser> get _filteredUsers => _demoUsers.where((u) {
        final q = _searchUser.toLowerCase();
        return q.isEmpty ||
            u.name.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q);
      }).toList();

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildEarningsRow(),
                  const SizedBox(height: 16),
                  _buildLinkedUsers(),
                  const SizedBox(height: 16),
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

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre + breadcrumb + bouton
          Row(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                icon: const Icon(Icons.person_add_outlined, size: 15),
                label: const Text('Coopt a Talented Employee',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),

          // Filtres
          Row(
            children: [
              // Search
              SizedBox(
                width: 180,
                height: 36,
                child: TextField(
                  onChanged: (v) => setState(() => _searchUser = v),
                  style: const TextStyle(fontSize: 13),
                  decoration: _inputDecor('Search User',
                      prefix: const Icon(Icons.search,
                          size: 16, color: Color(0xFFBDBDBD))),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: _showPaymentDialog,
                child: const Text('Payment Request',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Earnings ───────────────────────────────────────────────────────────────

  Widget _buildEarningsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card principale Earnings
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecor(),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Earnings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1A1A2E))),
                      const SizedBox(height: 14),
                      _statLine('Total Remaining',
                          '${_jackpot.toStringAsFixed(2)} €'),
                      const SizedBox(height: 6),
                      _statLine('Withdrawn',
                          '${_totalRetraits.toStringAsFixed(2)} €'),
                      const SizedBox(height: 6),
                      _statLine('Total This Month',
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
                // Donut orange — not earned
                _DonutChart(
                  percent: _notEarnedPercent.clamp(0, 100),
                  color: const Color(0xFFE8704A),
                  label:
                      '${_notEarnedPercent.clamp(0, 100).toStringAsFixed(0)} %',
                  subLabel: 'not earned',
                ),
                const SizedBox(width: 16),
                // Donut teal — AUTO (bonus %)
                _DonutChart(
                  percent: _bonusPercent.clamp(0, 100),
                  color: primary,
                  label: '${_bonusPercent.clamp(0, 100).toStringAsFixed(0)} %',
                  subLabel: 'AUTO',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Card Prime List
        Container(
          width: 170,
          padding: const EdgeInsets.all(16),
          decoration: _cardDecor(),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
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
                      child: const Center(
                        child: Text('0',
                            style: TextStyle(color: Colors.white, fontSize: 9)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Prime List',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1A1A2E))),
              const SizedBox(height: 4),
              Text(
                'Total prime Amount: ${_jackpotTotal.toStringAsFixed(2)} €',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Linked Users ───────────────────────────────────────────────────────────

  Widget _buildLinkedUsers() {
    return Container(
      decoration: _cardDecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text('Linked users',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1A1A2E))),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          // En-tête tableau
          Container(
            color: const Color(0xFFF9FAFB),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: const Row(
              children: [
                SizedBox(width: 30),
                Expanded(flex: 3, child: _TH('USER')),
                Expanded(child: _TH('DAILY RATE')),
                Expanded(child: _TH('CRASTATUS')),
                Expanded(child: _TH('TYPE')),
                Expanded(child: _TH('PRIME %')),
                Expanded(child: _TH('GAIN/JOUR')),
                Expanded(child: _TH('JACKPOT')),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          if (_filteredUsers.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text('Aucun utilisateur trouvé.',
                      style:
                          TextStyle(color: Color(0xFF9E9E9E), fontSize: 13))),
            )
          else
            ..._filteredUsers.map(_userRow),

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

  Widget _userRow(LinkedUser u) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0)))),
      child: Row(
        children: [
          // Indicateur statut
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: u.craStatus == 'OK'
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              u.craStatus == 'OK' ? Icons.check : Icons.close,
              size: 13,
              color: u.craStatus == 'OK'
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFE53935),
            ),
          ),
          const SizedBox(width: 8),

          // Nom + email
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: primary.withOpacity(0.15),
                  child: Text(u.name[0].toUpperCase(),
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
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A2E))),
                      Text(u.email,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xFF9E9E9E))),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Daily rate
          Expanded(
              child: Text(u.dailyRate,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF555555)))),

          // CRA status badge
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: u.craStatus == 'OK'
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                u.craStatus,
                style: TextStyle(
                    fontSize: 11,
                    color: u.craStatus == 'OK'
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFE53935),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),

          // Type
          Expanded(
              child: Text(u.type,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF555555)))),

          // Prime %  = (retraits/gains)*100
          Expanded(
            child: Text(
              '${u.primePercent.toStringAsFixed(1)} %',
              style: const TextStyle(fontSize: 12, color: Color(0xFF555555)),
            ),
          ),

          // Gain/jour
          Expanded(
            child: Text(
              u.gainPerDay,
              style: const TextStyle(fontSize: 12, color: Color(0xFF555555)),
            ),
          ),

          // Jackpot = gains - retraits
          Expanded(
            child: Text(
              '${u.jackpot.toStringAsFixed(2)} €',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text('Extraction List',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1A1A2E))),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 40),
          const Center(
            child: Text('No data to display',
                style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E))),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ── Payment Dialog ─────────────────────────────────────────────────────────

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Payment Request',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dlgRow('Gains du mois', '${_totalGains.toStringAsFixed(2)} €'),
            _dlgRow(
                'Retraits du mois', '${_totalRetraits.toStringAsFixed(2)} €'),
            const Divider(),
            _dlgRow('Jackpot (gains − retraits)',
                '${_jackpot.toStringAsFixed(2)} €',
                bold: true),
            _dlgRow('Bonus %  (retraits / gains × 100)',
                '${_bonusPercent.toStringAsFixed(1)} %'),
            _dlgRow('Jackpot total (tous mois)',
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
          Text('$label  ',
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00B4A6))),
        ],
      );

  Widget _dlgRow(String label, String value, {bool bold = false}) => Padding(
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
                    fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                    color: const Color(0xFF1A1A2E))),
          ],
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
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF555555)))),
        ),
      );

  InputDecoration _inputDecor(String hint, {Widget? prefix}) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
        prefixIcon: prefix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
            items: [2024, 2025, 2026]
                .map((y) => DropdownMenuItem(
                    value: y,
                    child: Text('$y', style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: (v) => setState(() => _selectedYear = v!),
            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          ),
        ),
      );

  Widget _monthDropdown() => _ddWrapper(
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedMonth,
            items: List.generate(
                12,
                (i) => DropdownMenuItem(
                      value: i + 1,
                      child: Text(
                          '$_selectedYear-${(i + 1).toString().padLeft(2, '0')}',
                          style: const TextStyle(fontSize: 13)),
                    )).toList(),
            onChanged: (v) => setState(() => _selectedMonth = v!),
            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
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

  const _DonutChart({
    required this.percent,
    required this.color,
    required this.label,
    required this.subLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(110, 110),
            painter: _DonutPainter(percent: percent, color: color),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15, color: color)),
              Text(subLabel,
                  style:
                      const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
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
    final radius = size.width / 2 - 12;
    const strokeW = 16.0;

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

    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi, false, bg);
    if (percent > 0) {
      canvas.drawArc(
          rect, -math.pi / 2, 2 * math.pi * (percent / 100), false, fg);
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
