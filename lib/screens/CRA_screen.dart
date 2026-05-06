import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'package:intl/intl.dart';

// ── Types ─────────────────────────────────────────────────────────────────────
enum ActivityType { work, absence, travel }

extension ActivityTypeExt on ActivityType {
  String get label {
    switch (this) {
      case ActivityType.work:
        return 'Travail';
      case ActivityType.absence:
        return 'Absence';
      case ActivityType.travel:
        return 'Travel';
    }
  }

  Color get color {
    switch (this) {
      case ActivityType.work:
        return const Color(0xFF00B4A6);
      case ActivityType.absence:
        return const Color(0xFFFFA726);
      case ActivityType.travel:
        return const Color(0xFFFF9800);
    }
  }
}

class DayActivity {
  final DateTime date;
  ActivityType type;
  String description;
  DayActivity(
      {required this.date, required this.type, required this.description});
}

// ═══════════════════════════════════════════════════════════════════════════════
class CraScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const CraScreen({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });
  @override
  State<CraScreen> createState() => _CraScreenState();
}

class _CraScreenState extends State<CraScreen> {
  static const Color primary = Color(0xFF00B4A6);

  late DateTime _focusedMonth;
  DateTime? _selectedDay;
  bool _monthView = true;

  // Filter state: which types are visible
  bool _filterAll = true;
  bool _filterAbsence = true;
  bool _filterWork = true;

  final Map<DateTime, DayActivity> _activities = {};
  final _descCtrl = TextEditingController();
  final _reserveAmtCtrl = TextEditingController(text: '0');
  final _reserveDaysCtrl = TextEditingController(text: '0');
  final _earnAmtCtrl = TextEditingController(text: '0');
  final _lockDaysCtrl = TextEditingController(text: '0');
  final _actInputCtrl = TextEditingController();
  ActivityType _dlgType = ActivityType.work;

  @override
  void initState() {
    super.initState();
    _focusedMonth = DateTime(DateTime.now().year, DateTime.now().month);
    final y = DateTime.now().year;
    final m = DateTime.now().month;
    _add(y, m, 1, ActivityType.absence, 'Fête du travail');
    _add(y, m, 8, ActivityType.absence, 'Fête de la Victoire 1945');
    _add(y, m, 14, ActivityType.absence, 'Ascension');
  }

  void _add(int y, int m, int d, ActivityType t, String desc) {
    final date = DateTime(y, m, d);
    _activities[_norm(date)] =
        DayActivity(date: date, type: t, description: desc);
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _reserveAmtCtrl.dispose();
    _reserveDaysCtrl.dispose();
    _earnAmtCtrl.dispose();
    _lockDaysCtrl.dispose();
    _actInputCtrl.dispose();
    super.dispose();
  }

  DateTime _norm(DateTime d) => DateTime(d.year, d.month, d.day);

  List<DateTime?> _calCells() {
    final first = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final last = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);
    final leading = first.weekday % 7;
    final cells = <DateTime?>[];
    for (int i = 0; i < leading; i++) cells.add(null);
    for (int d = 1; d <= last.day; d++)
      cells.add(DateTime(_focusedMonth.year, _focusedMonth.month, d));
    while (cells.length % 7 != 0) cells.add(null);
    return cells;
  }

  int get _absCount => _activities.values
      .where((a) =>
          a.type == ActivityType.absence &&
          a.date.year == _focusedMonth.year &&
          a.date.month == _focusedMonth.month)
      .length;

  int get _workCount => _activities.values
      .where((a) =>
          a.type == ActivityType.work &&
          a.date.year == _focusedMonth.year &&
          a.date.month == _focusedMonth.month)
      .length;

  List<DayActivity> get _listItems {
    final all = _activities.values.where((a) =>
        a.date.year == _focusedMonth.year &&
        a.date.month == _focusedMonth.month);
    return all.where((a) => _isTypeVisible(a.type)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  bool _isTypeVisible(ActivityType type) {
    if (_filterAll) return true;
    if (type == ActivityType.absence && _filterAbsence) return true;
    if (type == ActivityType.work && _filterWork) return true;
    return false;
  }

  DayActivity? _visibleActivity(DateTime? day) {
    if (day == null) return null;
    final act = _activities[_norm(day)];
    if (act == null) return null;
    if (!_isTypeVisible(act.type)) return null;
    return act;
  }

  // ── Responsive breakpoints ─────────────────────────────────────────────────
  bool _isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= 700;

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    final wide = _isWide(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _banner(),
          const SizedBox(height: 14),
          if (wide) _wideLayout() else _narrowLayout(),
        ]),
      ),
    );
  }

  // ── Wide layout (tablet/desktop): side-by-side ─────────────────────────────
  Widget _wideLayout() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 190,
              child: Column(children: [
                _fillButton(),
                const SizedBox(height: 12),
                _filters(),
                const SizedBox(height: 12),
                _illustration(),
              ])),
          const SizedBox(width: 16),
          Expanded(
              child: Column(children: [
            _calendarCard(),
            const SizedBox(height: 14),
            _descBox(),
            const SizedBox(height: 14),
            _reserveCard(),
            const SizedBox(height: 14),
            _signatureCard(),
            const SizedBox(height: 14),
            _validateBtn(),
          ])),
        ],
      );

  // ── Narrow layout (mobile): stacked ───────────────────────────────────────
  Widget _narrowLayout() => Column(children: [
        _fillButton(),
        const SizedBox(height: 12),
        _calendarCard(),
        const SizedBox(height: 12),
        _filters(),
        const SizedBox(height: 12),
        _descBox(),
        const SizedBox(height: 12),
        _reserveCard(),
        const SizedBox(height: 12),
        _signatureCard(),
        const SizedBox(height: 12),
        _validateBtn(),
      ]);

  // ── Banner ─────────────────────────────────────────────────────────────────
  Widget _banner() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFBBF7F0)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _bRow(
              'Please make sure that you click on the button at the bottom to send the CRA for validation.'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _bRow('If you want to attach a signed client CRA:'),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: primary,
                  side: const BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
                icon: const Icon(Icons.upload_file, size: 14),
                label: const Text('Import CRA',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _bRow("Don't know how to do it?"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
                onPressed: () {},
                child:
                    const Text('Cliquez ici', style: TextStyle(fontSize: 12)),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text('By Beeline',
                      style: TextStyle(
                          color: primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600))),
            ],
          ),
        ]),
      );

  Widget _bRow(String text) => Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.info_outline, size: 14, color: primary),
        const SizedBox(width: 6),
        Flexible(
            child: Text(text,
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF374151)))),
      ]);

  // ── Fill Button ────────────────────────────────────────────────────────────
  Widget _fillButton() => Container(
        padding: const EdgeInsets.all(12),
        decoration: _cardDeco(),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.auto_fix_high, size: 16),
                label: const Text('Fill with One Click',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                onPressed: () {
                  setState(() {
                    final y = _focusedMonth.year;
                    final m = _focusedMonth.month;
                    final days = DateTime(y, m + 1, 0).day;
                    for (int d = 1; d <= days; d++) {
                      final date = DateTime(y, m, d);
                      if (date.weekday != DateTime.saturday &&
                          date.weekday != DateTime.sunday) {
                        final nd = _norm(date);
                        _activities.putIfAbsent(
                            nd,
                            () => DayActivity(
                                date: date,
                                type: ActivityType.work,
                                description: 'Travail'));
                      }
                    }
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download,
                    size: 22, color: Color(0xFF6B7280))),
            IconButton(
                onPressed: () {
                  setState(() => _activities.removeWhere((_, a) =>
                      a.date.year == _focusedMonth.year &&
                      a.date.month == _focusedMonth.month));
                },
                icon: const Icon(Icons.delete_outline,
                    size: 22, color: Color(0xFFEF4444))),
          ],
        ),
      );

  // ── Filters ────────────────────────────────────────────────────────────────
  Widget _filters() => Container(
        padding: const EdgeInsets.all(12),
        decoration: _cardDeco(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('FILTER',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 1)),
          const SizedBox(height: 8),
          _checkFilter('View all', _filterAll, const Color(0xFF00B4A6), (val) {
            setState(() {
              _filterAll = val;
              if (val) {
                _filterAbsence = true;
                _filterWork = true;
              }
            });
          }),
          _checkFilter('Absence', _filterAbsence, const Color(0xFFFFA726),
              (val) {
            setState(() {
              _filterAbsence = val;
              _filterAll = _filterAbsence && _filterWork;
            });
          }),
          _checkFilter('Travail', _filterWork, const Color(0xFF00B4A6), (val) {
            setState(() {
              _filterWork = val;
              _filterAll = _filterAbsence && _filterWork;
            });
          }),
          const Divider(height: 16),
          _cntRow('Absence', _absCount, const Color(0xFFFFA726)),
          _cntRow('Travail', _workCount, const Color(0xFF00B4A6)),
        ]),
      );

  Widget _checkFilter(
      String label, bool value, Color color, ValueChanged<bool> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color, width: 2),
            ),
            child: value
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Text(label,
              style: TextStyle(
                  fontSize: 13,
                  color:
                      value ? const Color(0xFF1A1A2E) : const Color(0xFF9E9E9E),
                  fontWeight: value ? FontWeight.w600 : FontWeight.normal)),
        ]),
      ),
    );
  }

  Widget _cntRow(String label, int count, Color color) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('$label : ',
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
          Text('$count.0',
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: color)),
        ]),
      );

  Widget _illustration() => Container(
        height: 110,
        decoration: _cardDeco(),
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.insert_chart_outlined_rounded,
              size: 44, color: primary.withOpacity(0.35)),
          const SizedBox(height: 4),
          Text('CRA',
              style: TextStyle(
                  color: primary.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ])),
      );

  // ── Calendar card ──────────────────────────────────────────────────────────
  Widget _calendarCard() {
    final cells = _calCells();
    const wds = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Container(
      decoration: _cardDeco(),
      child: Column(children: [
        // Activity input hint
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: const BoxDecoration(
            color: Color(0xFFF9FAFB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(children: [
            const Icon(Icons.ads_click, size: 14, color: Color(0xFF9E9E9E)),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              _selectedDay != null
                  ? 'Sélectionné : ${DateFormat('d MMM yyyy', 'fr_FR').format(_selectedDay!)}'
                  : 'Click on a calendar day to enter your activity',
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            )),
            if (_selectedDay != null)
              GestureDetector(
                onTap: () => setState(() => _selectedDay = null),
                child:
                    const Icon(Icons.close, size: 16, color: Color(0xFF9E9E9E)),
              ),
          ]),
        ),

        // Month nav + toggle
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          child: Row(children: [
            GestureDetector(
              onTap: () => setState(() => _focusedMonth =
                  DateTime(_focusedMonth.year, _focusedMonth.month - 1)),
              child: const Icon(Icons.chevron_left,
                  size: 22, color: Color(0xFF555555)),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                  DateFormat('MMMM yyyy', 'fr_FR').format(_focusedMonth),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1A1A2E))),
            ),
            GestureDetector(
              onTap: () => setState(() => _focusedMonth =
                  DateTime(_focusedMonth.year, _focusedMonth.month + 1)),
              child: const Icon(Icons.chevron_right,
                  size: 22, color: Color(0xFF555555)),
            ),
            const SizedBox(width: 8),
            _toggle('Month', true),
            const SizedBox(width: 4),
            _toggle('List', false),
          ]),
        ),

        // Week headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
              children: wds
                  .map((d) => Expanded(
                        child: Center(
                            child: Text(d,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF9E9E9E)))),
                      ))
                  .toList()),
        ),
        const SizedBox(height: 4),

        // Grid / List
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
          child: _monthView ? _grid(cells) : _listView(),
        ),
      ]),
    );
  }

  Widget _toggle(String label, bool isMonth) {
    final sel = _monthView == isMonth;
    return GestureDetector(
      onTap: () => setState(() => _monthView = isMonth),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: sel ? primary : const Color(0xFFE0E0E0)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                color: sel ? Colors.white : const Color(0xFF555555),
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _grid(List<DateTime?> cells) {
    final rows = <Widget>[];
    for (int r = 0; r < cells.length ~/ 7; r++) {
      rows.add(Row(
          children: List.generate(7, (c) {
        final day = cells[r * 7 + c];
        if (day == null) return const Expanded(child: SizedBox(height: 58));
        final nd = _norm(day);
        final act = _visibleActivity(day);
        final isToday = nd == _norm(DateTime.now());
        final isSel = _selectedDay != null && nd == _norm(_selectedDay!);
        final isWE =
            day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedDay = day);
              _actDialog(day);
            },
            child: Container(
              height: 58,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: isSel
                    ? primary.withOpacity(0.14)
                    : act != null
                        ? act.type.color.withOpacity(0.1)
                        : isWE
                            ? const Color(0xFFFAFAFA)
                            : Colors.white,
                border: Border.all(
                  color: isSel
                      ? primary
                      : isToday
                          ? primary.withOpacity(0.5)
                          : const Color(0xFFE5E7EB),
                  width: isSel || isToday ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('${day.day}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isToday ? FontWeight.bold : FontWeight.normal,
                            color: isWE
                                ? const Color(0xFFBDBDBD)
                                : const Color(0xFF1A1A2E),
                          )),
                    ),
                    if (act != null)
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.fromLTRB(2, 0, 2, 2),
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: act.type.color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(act.description,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                overflow: TextOverflow.ellipsis)),
                      )),
                  ]),
            ),
          ),
        );
      })));
    }
    return Column(children: rows);
  }

  Widget _listView() {
    final items = _listItems;
    if (items.isEmpty)
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Text('Aucune activité.',
                style: TextStyle(color: Color(0xFF9E9E9E)))),
      );
    return Column(
        children: items
            .map((a) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: a.type.color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: a.type.color.withOpacity(0.3)),
                  ),
                  child: Row(children: [
                    Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: a.type.color, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text(DateFormat('d MMM', 'fr_FR').format(a.date),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xFF1A1A2E))),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(a.description,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF555555)))),
                    Text(a.type.label,
                        style: TextStyle(
                            fontSize: 11,
                            color: a.type.color,
                            fontWeight: FontWeight.w600)),
                  ]),
                ))
            .toList());
  }

  // ── Activity dialog ────────────────────────────────────────────────────────
  void _actDialog(DateTime day) {
    final nd = _norm(day);
    final ex = _activities[nd];
    _actInputCtrl.text = ex?.description ?? '';
    _dlgType = ex?.type ?? ActivityType.work;
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (ctx, setD) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(day),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF1A1A2E))),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Type',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF555555))),
                      const SizedBox(height: 8),
                      Wrap(
                          spacing: 6,
                          children: ActivityType.values.map((t) {
                            final sel = _dlgType == t;
                            return ChoiceChip(
                              label: Text(t.label,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: sel ? Colors.white : t.color)),
                              selected: sel,
                              selectedColor: t.color,
                              backgroundColor: t.color.withOpacity(0.1),
                              side: BorderSide(color: t.color.withOpacity(0.4)),
                              onSelected: (_) => setD(() => _dlgType = t),
                            );
                          }).toList()),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _actInputCtrl,
                        maxLines: 2,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: primary, width: 2)),
                        ),
                      ),
                    ]),
                actions: [
                  if (ex != null)
                    TextButton(
                      onPressed: () {
                        setState(() => _activities.remove(nd));
                        Navigator.pop(ctx);
                      },
                      child: const Text('Supprimer',
                          style: TextStyle(color: Color(0xFFEF4444))),
                    ),
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Annuler',
                          style: TextStyle(color: Color(0xFF9E9E9E)))),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      final desc = _actInputCtrl.text.trim();
                      if (desc.isNotEmpty)
                        setState(() => _activities[nd] = DayActivity(
                            date: day, type: _dlgType, description: desc));
                      Navigator.pop(ctx);
                    },
                    child: const Text('Enregistrer'),
                  ),
                ],
              ),
            ));
  }

  // ── Description box ────────────────────────────────────────────────────────
  Widget _descBox() => Container(
        padding: const EdgeInsets.all(14),
        decoration: _cardDeco(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Description of month tasks',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E))),
          const SizedBox(height: 8),
          TextField(
            controller: _descCtrl,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Ajouter une note pour ce mois...',
              hintStyle:
                  const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primary, width: 1.5)),
            ),
          ),
        ]),
      );

  // ── Reserve management ─────────────────────────────────────────────────────
  Widget _reserveCard() => Container(
        padding: const EdgeInsets.all(14),
        decoration: _cardDeco(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Reserve management',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E))),
          const SizedBox(height: 12),
          // Buttons: wrap on small screens
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
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
                          horizontal: 14, vertical: 12)),
                  onPressed: () {},
                  child: const Text('check my reserve',
                      style: TextStyle(fontSize: 13)),
                ),
              ),
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
                          horizontal: 14, vertical: 12)),
                  icon: const Icon(Icons.bar_chart, size: 16),
                  label: const Text('Simulate my salary / my reserve',
                      style: TextStyle(fontSize: 13)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Fields: 2 columns on wide, 1 column on narrow
          LayoutBuilder(builder: (ctx, constraints) {
            final twoCol = constraints.maxWidth >= 500;
            if (twoCol) {
              return Column(children: [
                Row(children: [
                  Expanded(
                      child: _rField(
                          'Amount to use from reserve (€)', _reserveAmtCtrl,
                          hasCheck: true)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _rField(
                          'Amount to use from reserve (days)', _reserveDaysCtrl,
                          hasCheck: true)),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                      child: _rField(
                          'Amount to save on reserve (€)', _earnAmtCtrl)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _rField('Number of days to save in reserve (days)',
                          _lockDaysCtrl)),
                ]),
              ]);
            } else {
              return Column(children: [
                _rField('Amount to use from reserve (€)', _reserveAmtCtrl,
                    hasCheck: true),
                const SizedBox(height: 10),
                _rField('Amount to use from reserve (days)', _reserveDaysCtrl,
                    hasCheck: true),
                const SizedBox(height: 10),
                _rField('Amount to save on reserve (€)', _earnAmtCtrl),
                const SizedBox(height: 10),
                _rField(
                    'Number of days to save in reserve (days)', _lockDaysCtrl),
              ]);
            }
          }),
        ]),
      );

  Widget _rField(String label, TextEditingController ctrl,
          {bool hasCheck = false}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                    color: hasCheck
                        ? const Color(0xFF00B4A6)
                        : const Color(0xFFE0E0E0))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: primary, width: 1.5)),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: hasCheck
                ? const Icon(Icons.check, color: Color(0xFF00B4A6), size: 20)
                : null,
          ),
        ),
      ]);

  // ── Signature ──────────────────────────────────────────────────────────────
  Widget _signatureCard() => Container(
        padding: const EdgeInsets.all(14),
        decoration: _cardDeco(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Center(
            child: Text('Signature',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF1A1A2E))),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
                color: const Color(0xFFD4D4D4),
                borderRadius: BorderRadius.circular(6)),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: primary,
                  side: const BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
              icon: const Icon(Icons.upload, size: 14),
              label: const Text('Import signature',
                  style: TextStyle(fontSize: 12)),
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            TextButton.icon(
                onPressed: () {},
                icon:
                    const Icon(Icons.close, size: 14, color: Color(0xFFEF4444)),
                label: const Text('Reset',
                    style: TextStyle(color: Color(0xFFEF4444), fontSize: 12))),
          ]),
        ]),
      );

  // ── Validation button ──────────────────────────────────────────────────────
  Widget _validateBtn() => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.person_outline),
          label: const Text('Request for Validation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    title: const Text('Confirmation',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: const Text(
                        'Voulez-vous soumettre votre CRA pour validation ?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler',
                              style: TextStyle(color: Color(0xFF9E9E9E)))),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Soumettre'),
                      ),
                    ],
                  )),
        ),
      );

  BoxDecoration _cardDeco() => BoxDecoration(
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
