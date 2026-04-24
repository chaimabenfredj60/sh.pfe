import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalCalendarScreen extends StatefulWidget {
  const PersonalCalendarScreen({super.key});

  @override
  _PersonalCalendarScreenState createState() => _PersonalCalendarScreenState();
}

class _PersonalCalendarScreenState extends State<PersonalCalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  // ── Jours fériés français fixes (année quelconque) ──────────────────────────
  // Pâques et fêtes mobiles sont calculés dynamiquement dans _getEasterBased()
  static const Map<String, String> _fixedHolidays = {
    '01-01': 'Jour de l\'An',
    '05-01': 'Fête du Travail',
    '05-08': 'Fête de la Victoire 1945',
    '07-14': 'Fête Nationale',
    '08-15': 'Assomption',
    '11-01': 'Toussaint',
    '11-11': 'Armistice 1918',
    '12-25': 'Noël',
  };

  // Notes utilisateur : clé = DateTime normalisé, valeur = liste de notes
  Map<DateTime, List<String>> _userNotes = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  // ── Calcul de Pâques (algorithme de Butcher / Anonymous Gregorian) ──────────
  DateTime _easter(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  // ── Jours fériés mobiles basés sur Pâques ───────────────────────────────────
  Map<DateTime, String> _getEasterBased(int year) {
    final easter = _easter(year);
    return {
      _normalizeDate(easter): 'Pâques',
      _normalizeDate(easter.add(const Duration(days: 1))): 'Lundi de Pâques',
      _normalizeDate(easter.add(const Duration(days: 39))): 'Ascension',
      _normalizeDate(easter.add(const Duration(days: 49))): 'Pentecôte',
      _normalizeDate(easter.add(const Duration(days: 50))): 'Lundi de Pentecôte',
    };
  }

  // ── Retourne le nom du jour férié pour une date donnée (null si aucun) ──────
  String? _holidayName(DateTime date) {
    final nd = _normalizeDate(date);
    // Fêtes mobiles
    final easterBased = _getEasterBased(nd.year);
    if (easterBased.containsKey(nd)) return easterBased[nd];
    // Fêtes fixes
    final key = DateFormat('MM-dd').format(nd);
    return _fixedHolidays[key];
  }

  bool _isHoliday(DateTime date) => _holidayName(date) != null;

  // ── Utilitaires ─────────────────────────────────────────────────────────────
  DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  List<DateTime> _getDaysInMonth(DateTime dateTime) {
    final first = DateTime(dateTime.year, dateTime.month, 1);
    final last = DateTime(dateTime.year, dateTime.month + 1, 0);
    final daysInMonth = last.day;

    // Lundi = premier jour de la semaine (weekday: 1=lun … 7=dim)
    // On calcule combien de cases vides avant le 1er
    final leadingBlanks = (first.weekday - 1) % 7; // 0 si lundi, 6 si dimanche

    final days = <DateTime>[];
    for (int i = leadingBlanks; i > 0; i--) {
      days.add(first.subtract(Duration(days: i)));
    }
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(dateTime.year, dateTime.month, i));
    }
    final remaining = days.length % 7 == 0 ? 0 : 7 - days.length % 7;
    for (int i = 1; i <= remaining; i++) {
      days.add(last.add(Duration(days: i)));
    }
    return days;
  }

  // ── Dialogue : ajouter une note ─────────────────────────────────────────────
  void _showAddNoteDialog(DateTime selectedDay) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Ajouter une note',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF00B4A6),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(selectedDay),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Votre note…',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00B4A6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF00B4A6), width: 2),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler', style: TextStyle(color: Color(0xFF6B7280))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B4A6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  final nd = _normalizeDate(selectedDay);
                  _userNotes[nd] ??= [];
                  _userNotes[nd]!.add(text);
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Ajouter', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Dialogue : voir/supprimer les notes ─────────────────────────────────────
  void _showNotesDialog(DateTime selectedDay) {
    final nd = _normalizeDate(selectedDay);
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            DateFormat('d MMMM yyyy', 'fr_FR').format(selectedDay),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00B4A6),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Jour férié éventuel
                if (_isHoliday(selectedDay))
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F9F7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.celebration, color: Color(0xFF00B4A6), size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _holidayName(selectedDay)!,
                            style: const TextStyle(
                              color: Color(0xFF00B4A6),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                // Notes utilisateur
                if (_userNotes[nd] == null || _userNotes[nd]!.isEmpty)
                  const Text(
                    'Aucune note pour cette date.',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                  )
                else
                  ..._userNotes[nd]!.asMap().entries.map((entry) {
                    final i = entry.key;
                    final note = entry.value;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.sticky_note_2_outlined,
                          color: Color(0xFF00B4A6), size: 20),
                      title: Text(note, style: const TextStyle(fontSize: 13)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Color(0xFFEF4444), size: 20),
                        onPressed: () {
                          setState(() {
                            _userNotes[nd]!.removeAt(i);
                            if (_userNotes[nd]!.isEmpty) _userNotes.remove(nd);
                          });
                          setStateDialog(() {});
                        },
                      ),
                    );
                  }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer', style: TextStyle(color: Color(0xFF6B7280))),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4A6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.add, color: Colors.white, size: 18),
              label: const Text('Note', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
                _showAddNoteDialog(selectedDay);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth(_focusedDay);
    // Semaine débutant le lundi (norme française)
    const weekDays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    final selectedNd = _normalizeDate(_selectedDay);
    final selectedHoliday = _holidayName(_selectedDay);
    final selectedNotes = _userNotes[selectedNd] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          DateFormat('MMMM yyyy', 'fr_FR').format(_focusedDay),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF00B4A6),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => setState(() {
            _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
          }),
        ),
        actions: [
          // Bouton "Aujourd'hui"
          TextButton(
            onPressed: () => setState(() {
              _focusedDay = DateTime.now();
              _selectedDay = DateTime.now();
            }),
            child: const Text(
              "Auj.",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => setState(() {
              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── En-têtes des jours ─────────────────────────────────────────────
          Container(
            color: const Color(0xFFF9FAFB),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: weekDays.map((d) {
                final isWeekend = d == 'Sam' || d == 'Dim';
                return Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: isWeekend
                            ? const Color(0xFFEF4444).withOpacity(0.7)
                            : const Color(0xFF6B7280),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),

          // ── Grille calendrier ──────────────────────────────────────────────
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(4),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final isCurrentMonth = day.month == _focusedDay.month;
                final nd = _normalizeDate(day);
                final isToday = nd == _normalizeDate(DateTime.now());
                final isSelected = nd == selectedNd;
                final isHoliday = _isHoliday(day) && isCurrentMonth;
                final hasNotes = _userNotes.containsKey(nd) &&
                    _userNotes[nd]!.isNotEmpty &&
                    isCurrentMonth;
                // Samedi = weekday 6, Dimanche = weekday 7
                final isWeekend =
                    (day.weekday == 6 || day.weekday == 7) && isCurrentMonth;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedDay = day);
                    _showNotesDialog(day);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF00B4A6)
                          : isToday
                              ? const Color(0xFFE6F9F7)
                              : isHoliday
                                  ? const Color(0xFFFFF3F3)
                                  : Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF00B4A6)
                            : isCurrentMonth
                                ? const Color(0xFFE5E7EB)
                                : const Color(0xFFF3F4F6),
                        width: isSelected || isToday ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              fontSize: 12,
                              color: !isCurrentMonth
                                  ? const Color(0xFFD1D5DB)
                                  : isSelected
                                      ? Colors.white
                                      : isHoliday
                                          ? const Color(0xFFEF4444)
                                          : isWeekend
                                              ? const Color(0xFFEF4444)
                                                  .withOpacity(0.7)
                                              : const Color(0xFF111827),
                              fontWeight: (isSelected || isToday || isHoliday)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        // Point bleu = notes utilisateur
                        if (hasNotes)
                          Positioned(
                            bottom: 3,
                            right: isHoliday ? 10 : 3,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF3B82F6),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        // Point rouge = jour férié
                        if (isHoliday)
                          Positioned(
                            bottom: 3,
                            right: 3,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Légende ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _legendDot(const Color(0xFFEF4444), 'Jour férié'),
                const SizedBox(width: 16),
                _legendDot(const Color(0xFF3B82F6), 'Note personnelle'),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE5E7EB)),

          // ── Panneau du jour sélectionné ────────────────────────────────────
          Container(
            width: double.infinity,
            color: const Color(0xFFF5F6FA),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('EEEE d MMMM', 'fr_FR').format(_selectedDay),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                    // Bouton ajouter une note
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF00B4A6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFF00B4A6)),
                        ),
                      ),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Note', style: TextStyle(fontSize: 12)),
                      onPressed: () => _showAddNoteDialog(_selectedDay),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Jour férié
                if (selectedHoliday != null)
                  _infoChip(
                    icon: Icons.celebration,
                    label: selectedHoliday,
                    color: const Color(0xFF00B4A6),
                    bgColor: const Color(0xFFE6F9F7),
                  ),
                // Notes utilisateur
                if (selectedNotes.isEmpty && selectedHoliday == null)
                  const Text(
                    'Aucun événement — appuyez sur "+ Note" pour ajouter.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                  )
                else
                  ...selectedNotes.asMap().entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Icon(Icons.sticky_note_2_outlined,
                                    size: 14, color: Color(0xFF3B82F6)),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _userNotes[selectedNd]!
                                        .removeAt(entry.key);
                                    if (_userNotes[selectedNd]!.isEmpty) {
                                      _userNotes.remove(selectedNd);
                                    }
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(Icons.close,
                                      size: 14, color: Color(0xFFEF4444)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Widgets helpers ──────────────────────────────────────────────────────────

  Widget _legendDot(Color color, String label) => Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
        ],
      );

  Widget _infoChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
  }) =>
      Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      );
}