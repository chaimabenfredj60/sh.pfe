import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'package:intl/intl.dart';

enum ExpenseCategory { transport, meal, accommodation, other }

extension ExpCatExt on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.meal:
        return 'Repas';
      case ExpenseCategory.accommodation:
        return 'Hébergement';
      case ExpenseCategory.other:
        return 'Autre';
    }
  }

  Color get color {
    switch (this) {
      case ExpenseCategory.transport:
        return const Color(0xFF3B82F6);
      case ExpenseCategory.meal:
        return const Color(0xFF00B4A6);
      case ExpenseCategory.accommodation:
        return const Color(0xFFFF9800);
      case ExpenseCategory.other:
        return const Color(0xFF9E9E9E);
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseCategory.transport:
        return Icons.directions_car_outlined;
      case ExpenseCategory.meal:
        return Icons.restaurant_outlined;
      case ExpenseCategory.accommodation:
        return Icons.hotel_outlined;
      case ExpenseCategory.other:
        return Icons.receipt_outlined;
    }
  }
}

class Expense {
  final String id;
  String title;
  double amount;
  ExpenseCategory category;
  DateTime date;
  String? note;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
class MyExpensesScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MyExpensesScreen({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });
  @override
  State<MyExpensesScreen> createState() => _MyExpensesScreenState();
}

class _MyExpensesScreenState extends State<MyExpensesScreen> {
  static const Color primary = Color(0xFF00B4A6);

  final List<Expense> _expenses = [
    Expense(
        id: '1',
        title: 'Billet de train Paris-Lyon',
        amount: 89.50,
        category: ExpenseCategory.transport,
        date: DateTime(2026, 4, 10)),
    Expense(
        id: '2',
        title: 'Déjeuner client',
        amount: 45.00,
        category: ExpenseCategory.meal,
        date: DateTime(2026, 4, 12)),
    Expense(
        id: '3',
        title: 'Hôtel Ibis Lyon',
        amount: 120.00,
        category: ExpenseCategory.accommodation,
        date: DateTime(2026, 4, 11)),
    Expense(
        id: '4',
        title: 'Taxi aéroport',
        amount: 35.00,
        category: ExpenseCategory.transport,
        date: DateTime(2026, 4, 15)),
  ];

  ExpenseCategory? _filterCat;
  String _search = '';

  List<Expense> get _filtered {
    return _expenses.where((e) {
      final matchCat = _filterCat == null || e.category == _filterCat;
      final matchSearch = _search.isEmpty ||
          e.title.toLowerCase().contains(_search.toLowerCase());
      return matchCat && matchSearch;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  double get _total => _filtered.fold(0, (s, e) => s + e.amount);

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    final dateFmt = DateFormat('dd/MM/yyyy');
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header
          Row(children: [
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Expenses',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E))),
                  SizedBox(height: 2),
                  Text('Gestion de vos notes de frais',
                      style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E))),
                ]),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Ajouter une dépense',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onPressed: _addDialog,
            ),
          ]),
          const SizedBox(height: 16),

          // Stats
          Row(children: [
            _stat('Total', '${_total.toStringAsFixed(2)} €', primary),
            const SizedBox(width: 12),
            _stat('Dépenses', '${_filtered.length}', const Color(0xFF3B82F6)),
            const SizedBox(width: 12),
            _stat(
                'Transport',
                '${_expenses.where((e) => e.category == ExpenseCategory.transport).fold(0.0, (s, e) => s + e.amount).toStringAsFixed(2)} €',
                const Color(0xFF3B82F6)),
            const SizedBox(width: 12),
            _stat(
                'Repas',
                '${_expenses.where((e) => e.category == ExpenseCategory.meal).fold(0.0, (s, e) => s + e.amount).toStringAsFixed(2)} €',
                primary),
          ]),
          const SizedBox(height: 16),

          // Filters + search
          Row(children: [
            SizedBox(
              width: 220,
              height: 36,
              child: TextField(
                onChanged: (v) => setState(() => _search = v),
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  hintStyle:
                      const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
                  prefixIcon: const Icon(Icons.search,
                      size: 16, color: Color(0xFFBDBDBD)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                ),
              ),
            ),
            const SizedBox(width: 10),
            _filterBtn(null, 'Tout'),
            ...ExpenseCategory.values.map((c) => _filterBtn(c, c.label)),
          ]),
          const SizedBox(height: 16),

          // Table
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Column(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: const Row(children: [
                    Expanded(flex: 3, child: _TH('TITRE')),
                    Expanded(child: _TH('CATÉGORIE')),
                    Expanded(child: _TH('DATE')),
                    Expanded(child: _TH('MONTANT')),
                    SizedBox(width: 80, child: _TH('ACTIONS')),
                  ]),
                ),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                _filtered.isEmpty
                    ? const Expanded(
                        child: Center(
                            child: Text('Aucune dépense trouvée.',
                                style: TextStyle(color: Color(0xFF9E9E9E)))))
                    : Expanded(
                        child: ListView.separated(
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => const Divider(
                              height: 1, color: Color(0xFFF0F0F0)),
                          itemBuilder: (ctx, i) {
                            final e = _filtered[i];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(children: [
                                Expanded(
                                    flex: 3,
                                    child: Row(children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: e.category.color
                                                .withOpacity(0.12),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Icon(e.category.icon,
                                            size: 16, color: e.category.color),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(e.title,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF1A1A2E)))),
                                    ])),
                                Expanded(child: _catBadge(e.category)),
                                Expanded(
                                    child: Text(dateFmt.format(e.date),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF555555)))),
                                Expanded(
                                    child: Text(
                                        '${e.amount.toStringAsFixed(2)} €',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1A1A2E)))),
                                SizedBox(
                                    width: 80,
                                    child: Row(children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit_outlined,
                                            size: 16, color: Color(0xFF9E9E9E)),
                                        onPressed: () => _editDialog(e),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(
                                            minWidth: 32, minHeight: 32),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline,
                                            size: 16, color: Color(0xFFEF4444)),
                                        onPressed: () => setState(() =>
                                            _expenses.removeWhere(
                                                (x) => x.id == e.id)),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(
                                            minWidth: 32, minHeight: 32),
                                      ),
                                    ])),
                              ]),
                            );
                          },
                        ),
                      ),

                // Footer total
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8)),
                    border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                  ),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    const Text('Total : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1A1A2E))),
                    Text('${_total.toStringAsFixed(2)} €',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primary)),
                  ]),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _stat(String label, String value, Color color) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
          ]),
        ),
      );

  Widget _filterBtn(ExpenseCategory? cat, String label) {
    final sel = _filterCat == cat;
    final color = cat?.color ?? const Color(0xFF6B7280);
    return GestureDetector(
      onTap: () => setState(() => _filterCat = cat),
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: sel ? color : const Color(0xFFE0E0E0)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                color: sel ? color : const Color(0xFF555555),
                fontWeight: sel ? FontWeight.w600 : FontWeight.normal)),
      ),
    );
  }

  Widget _catBadge(ExpenseCategory cat) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: cat.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
        child: Text(cat.label,
            style: TextStyle(
                fontSize: 11, color: cat.color, fontWeight: FontWeight.w600)),
      );

  void _addDialog() => _expenseDialog(null);
  void _editDialog(Expense e) => _expenseDialog(e);

  void _expenseDialog(Expense? existing) {
    final titleCtrl = TextEditingController(text: existing?.title ?? '');
    final amountCtrl = TextEditingController(
        text: existing != null ? existing.amount.toString() : '');
    var cat = existing?.category ?? ExpenseCategory.transport;
    var date = existing?.date ?? DateTime.now();

    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (ctx, setD) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                    existing == null
                        ? 'Ajouter une dépense'
                        : 'Modifier la dépense',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                content: SizedBox(
                    width: 360,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      TextField(
                          controller: titleCtrl,
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Titre *',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: primary, width: 2)))),
                      const SizedBox(height: 10),
                      TextField(
                          controller: amountCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Montant (€) *',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: primary, width: 2)))),
                      const SizedBox(height: 10),
                      Wrap(
                          spacing: 6,
                          children: ExpenseCategory.values.map((c) {
                            final sel = cat == c;
                            return ChoiceChip(
                              label: Text(c.label,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: sel ? Colors.white : c.color)),
                              selected: sel,
                              selectedColor: c.color,
                              backgroundColor: c.color.withOpacity(0.1),
                              side: BorderSide(color: c.color.withOpacity(0.4)),
                              onSelected: (_) => setD(() => cat = c),
                            );
                          }).toList()),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                              context: ctx,
                              initialDate: date,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030));
                          if (picked != null) setD(() => date = picked);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFFE0E0E0)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(children: [
                            const Icon(Icons.calendar_today_outlined,
                                size: 16, color: Color(0xFF9E9E9E)),
                            const SizedBox(width: 8),
                            Text(DateFormat('dd/MM/yyyy').format(date),
                                style: const TextStyle(
                                    fontSize: 13, color: Color(0xFF555555))),
                          ]),
                        ),
                      ),
                    ])),
                actions: [
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
                      final title = titleCtrl.text.trim();
                      final amount =
                          double.tryParse(amountCtrl.text.trim()) ?? 0;
                      if (title.isEmpty || amount <= 0) return;
                      setState(() {
                        if (existing == null) {
                          _expenses.add(Expense(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              title: title,
                              amount: amount,
                              category: cat,
                              date: date));
                        } else {
                          existing.title = title;
                          existing.amount = amount;
                          existing.category = cat;
                          existing.date = date;
                        }
                      });
                      Navigator.pop(ctx);
                    },
                    child: Text(existing == null ? 'Ajouter' : 'Modifier'),
                  ),
                ],
              ),
            ));
  }
}

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
