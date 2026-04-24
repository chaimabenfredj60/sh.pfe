import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MODÈLES
// ═══════════════════════════════════════════════════════════════════════════════

enum CraEntryType { absence, travel, work }

class CraEntry {
  final DateTime date;
  final CraEntryType type;
  final String label;

  const CraEntry({
    required this.date,
    required this.type,
    required this.label,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// ÉCRAN CRA
// ═══════════════════════════════════════════════════════════════════════════════

class CraScreen extends StatefulWidget {
  const CraScreen({super.key});

  @override
  State<CraScreen> createState() => _CraScreenState();
}

class _CraScreenState extends State<CraScreen> {
  static const Color primary = Color(0xFF00B4A6);
  static const Color orange = Color(0xFFFF9800);
  static const Color blue = Color(0xFF3B82F6);

  DateTime _focusedMonth = DateTime(2026, 4);
  String _filter = 'all'; // all | absence | travel
  String _view = 'month'; // month | list
  final _descController = TextEditingController();

  // Reserve management
  final _reserveAmountCtrl = TextEditingController(text: '0');
  final _reserveDaysCtrl = TextEditingController(text: '0');
  final _reserveEarnCtrl = TextEditingController(text: '0');
  final _reserveNbDaysCtrl = TextEditingController(text: '0');

  // Données demo
  final List<CraEntry> _entries = [
    CraEntry(
        date: DateTime(2026, 4, 7),
        type: CraEntryType.absence,
        label: 'Lundi de Pâques'),
    CraEntry(
        date: DateTime(2026, 4, 25),
        type: CraEntryType.travel,
        label: 'Déplacement client'),
    CraEntry(
        date: DateTime(2026, 4, 26),
        type: CraEntryType.travel,
        label: 'Déplacement client'),
    CraEntry(
        date: DateTime(2026, 4, 30),
        type: CraEntryType.absence,
        label: 'Congé payé'),
  ];

  int get _absenceCount =>
      _entries.where((e) => e.type == CraEntryType.absence).length;
  int get _travelCount =>
      _entries.where((e) => e.type == CraEntryType.travel).length;

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAlertBanner(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Colonne gauche : actions + filtres + illustration ──
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        _buildActionButtons(),
                        const SizedBox(height: 16),
                        _buildFilters(),
                        const SizedBox(height: 16),
                        _buildCounters(),
                        const SizedBox(height: 16),
                        _buildIllustration(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // ── Colonne droite : calendrier ──────────────────────
                  Expanded(
                    child: Column(
                      children: [
                        _buildCalendarCard(),
                        const SizedBox(height: 16),
                        _buildDescriptionCard(),
                        const SizedBox(height: 16),
                        _buildReserveCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bandeau alerte ─────────────────────────────────────────────────────────

  Widget _buildAlertBanner() {
    return Container(
      color: const Color(0xFFFFF8E1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _alertRow(Icons.info_outline, const Color(0xFFE65100),
              'Please make sure that you click on the button at the bottom to send the CRA for validation.'),
          const SizedBox(height: 4),
          Row(
            children: [
              _alertRow(Icons.info_outline, const Color(0xFF1565C0),
                  'If you want to attach a signed client CRA:',
                  flex: false),
              const SizedBox(width: 8),
              _smallBtn(Icons.upload_file, 'Import CRA', primary, () {}),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _alertRow(
                  Icons.info_outline, Colors.grey, "Don't know how to do it?",
                  flex: false),
              const SizedBox(width: 8),
              _smallBtn(
                  Icons.play_circle_outline, 'Cliquez ici', Colors.teal, () {}),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('My EXTRACENS',
                  style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertRow(IconData icon, Color iconColor, String text,
      {bool flex = true}) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 6),
        flex
            ? Expanded(
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF555555))))
            : Text(text,
                style: const TextStyle(fontSize: 12, color: Color(0xFF555555))),
      ],
    );
    return flex ? row : row;
  }

  Widget _smallBtn(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11, color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // ── Actions ────────────────────────────────────────────────────────────────

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onPressed: () {},
            child: const Column(
              children: [
                Icon(Icons.auto_fix_high, size: 18),
                SizedBox(height: 2),
                Text('Fill with\nOne Click',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        _iconActionBtn(Icons.download, () {}),
        const SizedBox(width: 6),
        _iconActionBtn(Icons.delete_outline, () {}, color: Colors.red.shade300),
      ],
    );
  }

  Widget _iconActionBtn(IconData icon, VoidCallback onTap, {Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Icon(icon, size: 18, color: color ?? const Color(0xFF555555)),
      ),
    );
  }

  // ── Filtres ────────────────────────────────────────────────────────────────

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FILTER',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 1)),
          const SizedBox(height: 8),
          _filterChip(Colors.blue.shade700, 'View all', 'all'),
          _filterChip(blue, 'Absence', 'absence'),
          _filterChip(orange, 'Travel', 'travel'),
        ],
      ),
    );
  }

  Widget _filterChip(Color color, String label, String value) {
    final selected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: selected ? color : color.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color: selected ? color : const Color(0xFF555555),
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  // ── Compteurs ──────────────────────────────────────────────────────────────

  Widget _buildCounters() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          _counterRow(blue, 'Absence', '$_absenceCount/0 j'),
          const SizedBox(height: 6),
          _counterRow(orange, 'Travel', '$_travelCount/0 j'),
        ],
      ),
    );
  }

  Widget _counterRow(Color color, String label, String value) => Row(
        children: [
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Expanded(
              child: Text(label,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF555555)))),
          Text(value,
              style: TextStyle(
                  fontSize: 12, color: color, fontWeight: FontWeight.w600)),
        ],
      );

  // ── Illustration ───────────────────────────────────────────────────────────

  Widget _buildIllustration() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFE6F9F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insert_chart_outlined,
                size: 40, color: Color(0xFF00B4A6)),
            SizedBox(height: 4),
            Text('CRA en cours',
                style: TextStyle(fontSize: 11, color: Color(0xFF00B4A6))),
          ],
        ),
      ),
    );
  }

  // ── Calendrier ─────────────────────────────────────────────────────────────

  Widget _buildCalendarCard() {
    return Container(
      decoration: _cardDecor(),
      child: Column(
        children: [
          // Barre info + vue
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F5F7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline,
                            size: 14, color: Color(0xFF9E9E9E)),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Click on a calendar day to enter your activity',
                            style: TextStyle(
                                fontSize: 11, color: Color(0xFF9E9E9E)),
                          ),
                        ),
                        Icon(Icons.close,
                            size: 14, color: Colors.grey.shade400),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _viewToggle(),
              ],
            ),
          ),

          // Navigation mois
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, size: 20),
                  onPressed: () => setState(() => _focusedMonth =
                      DateTime(_focusedMonth.year, _focusedMonth.month - 1)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat('MMMM yyyy', 'fr_FR').format(_focusedMonth),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1A1A2E)),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, size: 20),
                  onPressed: () => setState(() => _focusedMonth =
                      DateTime(_focusedMonth.year, _focusedMonth.month + 1)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Grille
          _buildCalendarGrid(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _viewToggle() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleBtn('Month', 'month'),
          _toggleBtn('List', 'list'),
        ],
      ),
    );
  }

  Widget _toggleBtn(String label, String val) {
    final sel = _view == val;
    return GestureDetector(
      onTap: () => setState(() => _view = val),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                color: sel ? Colors.white : const Color(0xFF555555),
                fontWeight: sel ? FontWeight.w600 : FontWeight.normal)),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    const headers = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final days = _getDaysInMonth(_focusedMonth);

    return Column(
      children: [
        // Headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: headers.map((h) {
              return Expanded(
                child: Center(
                  child: Text(h,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9E9E9E))),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 4),

        // Days grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.4,
          ),
          itemCount: days.length,
          itemBuilder: (ctx, i) {
            final day = days[i];
            final inMonth = day.month == _focusedMonth.month;
            final entry = _getEntry(day);
            final isToday = _isSameDay(day, DateTime.now());

            return GestureDetector(
              onTap: inMonth ? () => _showDayDialog(day) : null,
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: !inMonth
                      ? Colors.transparent
                      : entry != null
                          ? _entryColor(entry.type).withOpacity(0.15)
                          : isToday
                              ? const Color(0xFFE6F9F7)
                              : Colors.white,
                  border: Border.all(
                    color: !inMonth
                        ? const Color(0xFFF3F4F6)
                        : entry != null
                            ? _entryColor(entry.type).withOpacity(0.4)
                            : const Color(0xFFE5E7EB),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 11,
                        color: !inMonth
                            ? const Color(0xFFD1D5DB)
                            : entry != null
                                ? _entryColor(entry.type)
                                : isToday
                                    ? primary
                                    : const Color(0xFF374151),
                        fontWeight: (entry != null || isToday)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    if (entry != null)
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _entryColor(entry.type),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ── Description ────────────────────────────────────────────────────────────

  Widget _buildDescriptionCard() {
    return Container(
      decoration: _cardDecor(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Description of month tasks',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E))),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: _descController,
              maxLines: 3,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                hintText: 'Décrivez les tâches du mois...',
                hintStyle: TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Reserve Management ─────────────────────────────────────────────────────

  Widget _buildReserveCard() {
    return Container(
      decoration: _cardDecor(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reserve management:',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E))),
          const SizedBox(height: 12),

          // Boutons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                onPressed: () {},
                child: const Text('check my reserve',
                    style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () {},
                child: const Text('Simulate my salary / my reserve ✨',
                    style: TextStyle(fontSize: 12)),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Champs
          Row(
            children: [
              Expanded(
                  child: _reserveField(
                      'Amount to use from reserve (€)', _reserveAmountCtrl,
                      hasError: true)),
              const SizedBox(width: 8),
              Expanded(
                  child: _reserveField(
                      'Amount to use from reserve (days)', _reserveDaysCtrl,
                      hasError: true)),
              const SizedBox(width: 8),
              Expanded(
                  child: _reserveField(
                      'Amount to add on reserve (€)', _reserveEarnCtrl)),
              const SizedBox(width: 8),
              Expanded(
                  child: _reserveField(
                      'Number of days to book on reserve (days)',
                      _reserveNbDaysCtrl)),
            ],
          ),

          const SizedBox(height: 20),

          // Signature
          Column(
            children: [
              const Text('Signature',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF1A1A2E))),
              const SizedBox(height: 10),
              Container(
                width: 180,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFCCCCCC),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload, size: 14),
                    label: const Text('Import Signature',
                        style: TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF555555)),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFE53935)),
                    child: const Text('Reset', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bouton validation
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4A6),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.send, size: 16),
              label: const Text('Request for Validation',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              onPressed: () => _showValidationDialog(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reserveField(String label, TextEditingController ctrl,
      {bool hasError = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF555555))),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          style: const TextStyle(fontSize: 13),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: hasError
                    ? const Color(0xFFE53935)
                    : const Color(0xFFE0E0E0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: hasError
                    ? const Color(0xFFE53935)
                    : const Color(0xFFE0E0E0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: primary, width: 1.5),
            ),
            suffixIcon: hasError
                ? const Icon(Icons.error_outline,
                    color: Color(0xFFE53935), size: 16)
                : null,
          ),
        ),
        if (hasError)
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text('Please do not exceed the available reserve',
                style: TextStyle(fontSize: 10, color: Color(0xFFE53935))),
          ),
      ],
    );
  }

  // ── Dialogue jour ──────────────────────────────────────────────────────────

  void _showDayDialog(DateTime day) {
    CraEntryType? selected;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(day),
              style: const TextStyle(fontSize: 14)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _typeOption(CraEntryType.absence, 'Absence', blue, selected,
                  (v) => setS(() => selected = v)),
              _typeOption(CraEntryType.travel, 'Travel', orange, selected,
                  (v) => setS(() => selected = v)),
            ],
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
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                if (selected != null) {
                  setState(() {
                    _entries.removeWhere((e) => _isSameDay(e.date, day));
                    _entries.add(CraEntry(
                        date: day,
                        type: selected!,
                        label: selected == CraEntryType.absence
                            ? 'Absence'
                            : 'Travel'));
                  });
                }
                Navigator.pop(ctx);
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeOption(
    CraEntryType type,
    String label,
    Color color,
    CraEntryType? selected,
    ValueChanged<CraEntryType> onChanged,
  ) {
    final sel = selected == type;
    return GestureDetector(
      onTap: () => onChanged(type),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: sel ? color.withOpacity(0.1) : Colors.transparent,
          border: Border.all(color: sel ? color : const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
                width: 12,
                height: 12,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                    color: sel ? color : const Color(0xFF555555),
                    fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 13)),
          ],
        ),
      ),
    );
  }

  void _showValidationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Confirmer l\'envoi',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Voulez-vous envoyer le CRA pour validation ?',
            style: TextStyle(fontSize: 13, color: Color(0xFF555555))),
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
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () => Navigator.pop(context),
            child: const Text('Envoyer'),
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

  Color _entryColor(CraEntryType t) =>
      t == CraEntryType.absence ? blue : orange;

  CraEntry? _getEntry(DateTime day) {
    final filtered = _entries.where((e) => _isSameDay(e.date, day));
    return filtered.isEmpty ? null : filtered.first;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<DateTime> _getDaysInMonth(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final last = DateTime(month.year, month.month + 1, 0);
    final blanks = first.weekday % 7;
    final days = <DateTime>[];
    for (int i = blanks; i > 0; i--) {
      days.add(first.subtract(Duration(days: i)));
    }
    for (int i = 1; i <= last.day; i++) {
      days.add(DateTime(month.year, month.month, i));
    }
    final rem = days.length % 7 == 0 ? 0 : 7 - days.length % 7;
    for (int i = 1; i <= rem; i++) {
      days.add(last.add(Duration(days: i)));
    }
    return days;
  }
}
