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
  final String language;

  const MyExpensesScreen({
    super.key,
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

  // ─── Breakpoints ────────────────────────────────────────────────────────────
  static const double _kMobile = 600;
  static const double _kTablet = 900;

  bool _isMobile(double w) => w < _kMobile;
  bool _isTablet(double w) => w >= _kMobile && w < _kTablet;

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      // FAB pour mobile
      floatingActionButton: LayoutBuilder(
        builder: (_, c) => _isMobile(c.maxWidth)
            ? FloatingActionButton.extended(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                onPressed: _addDialog,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter'),
              )
            : const SizedBox.shrink(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final mobile = _isMobile(w);
          final tablet = _isTablet(w);
          final padding = mobile ? 12.0 : 16.0;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(mobile),
                SizedBox(height: mobile ? 12 : 16),
                _buildStats(mobile, tablet),
                SizedBox(height: mobile ? 10 : 16),
                _buildFilters(mobile),
                SizedBox(height: mobile ? 10 : 16),
                Expanded(child: mobile ? _buildCards() : _buildTable()),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader(bool mobile) {
    final addBtn = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      icon: const Icon(Icons.add, size: 18),
      label: Text(
        mobile ? 'Ajouter' : 'Ajouter une dépense',
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
      onPressed: _addDialog,
    );

    return Row(
      children: [
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
          ],
        ),
        const Spacer(),
        if (!mobile) addBtn,
      ],
    );
  }

  // ─── Stats ──────────────────────────────────────────────────────────────────
  Widget _buildStats(bool mobile, bool tablet) {
    final stats = [
      _StatData('Total', '${_total.toStringAsFixed(2)} €', primary),
      _StatData('Dépenses', '${_filtered.length}', const Color(0xFF3B82F6)),
      _StatData(
          'Transport',
          '${_expenses.where((e) => e.category == ExpenseCategory.transport).fold(0.0, (s, e) => s + e.amount).toStringAsFixed(2)} €',
          const Color(0xFF3B82F6)),
      _StatData(
          'Repas',
          '${_expenses.where((e) => e.category == ExpenseCategory.meal).fold(0.0, (s, e) => s + e.amount).toStringAsFixed(2)} €',
          primary),
    ];

    if (mobile) {
      // 2×2 grid on mobile
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.4,
        children:
            stats.map((s) => _statCard(s.label, s.value, s.color)).toList(),
      );
    }

    return Row(
      children: stats
          .map((s) =>
              [_statCard(s.label, s.value, s.color), const SizedBox(width: 12)])
          .expand((x) => x)
          .toList()
        ..removeLast(),
    );
  }

  Widget _statCard(String label, String value, Color color) => Expanded(
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
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            Text(label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
          ]),
        ),
      );

  // ─── Filters ────────────────────────────────────────────────────────────────
  Widget _buildFilters(bool mobile) {
    final searchField = SizedBox(
      height: 36,
      child: TextField(
        onChanged: (v) => setState(() => _search = v),
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: 'Rechercher...',
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
          prefixIcon:
              const Icon(Icons.search, size: 16, color: Color(0xFFBDBDBD)),
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
    );

    final chips = [
      _filterBtn(null, 'Tout'),
      ...ExpenseCategory.values.map((c) => _filterBtn(c, c.label)),
    ];

    if (mobile) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        searchField,
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: chips),
        ),
      ]);
    }

    return Row(children: [
      SizedBox(width: 220, child: searchField),
      const SizedBox(width: 10),
      ...chips,
    ]);
  }

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

  // ─── Mobile: card list ───────────────────────────────────────────────────────
  Widget _buildCards() {
    final dateFmt = DateFormat('dd/MM/yyyy');
    if (_filtered.isEmpty) {
      return const Center(
          child: Text('Aucune dépense trouvée.',
              style: TextStyle(color: Color(0xFF9E9E9E))));
    }
    return ListView.separated(
      itemCount: _filtered.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) {
        if (i == _filtered.length) {
          // Total footer
          return Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 80),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('${_total.toStringAsFixed(2)} €',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: primary)),
                ]),
          );
        }
        final e = _filtered[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2))
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: e.category.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(e.category.icon, size: 20, color: e.category.color),
            ),
            title: Text(e.title,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E))),
            subtitle: Row(children: [
              _catBadge(e.category),
              const SizedBox(width: 8),
              Text(dateFmt.format(e.date),
                  style:
                      const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            ]),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${e.amount.toStringAsFixed(2)} €',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF1A1A2E))),
                const SizedBox(height: 4),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    onTap: () => _editDialog(e),
                    child: const Icon(Icons.edit_outlined,
                        size: 18, color: Color(0xFF9E9E9E)),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => setState(
                        () => _expenses.removeWhere((x) => x.id == e.id)),
                    child: const Icon(Icons.delete_outline,
                        size: 18, color: Color(0xFFEF4444)),
                  ),
                ]),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Desktop/Tablet: table ───────────────────────────────────────────────────
  Widget _buildTable() {
    final dateFmt = DateFormat('dd/MM/yyyy');
    return Container(
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
        // Table header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF9FAFB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, color: Color(0xFFF0F0F0)),
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
                                    color: e.category.color.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6)),
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
                                    fontSize: 12, color: Color(0xFF555555)))),
                        Expanded(
                            child: Text('${e.amount.toStringAsFixed(2)} €',
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
                                    _expenses.removeWhere((x) => x.id == e.id)),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF9FAFB),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text('Total : ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1A2E))),
            Text('${_total.toStringAsFixed(2)} €',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: primary)),
          ]),
        ),
      ]),
    );
  }

  // ─── Category badge ──────────────────────────────────────────────────────────
  Widget _catBadge(ExpenseCategory cat) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: cat.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
        child: Text(cat.label,
            style: TextStyle(
                fontSize: 11, color: cat.color, fontWeight: FontWeight.w600)),
      );

  // ─── Dialogs ─────────────────────────────────────────────────────────────────
  void _addDialog() => _expenseDialog(null);
  void _editDialog(Expense e) => _expenseDialog(e);

  void _expenseDialog(Expense? existing) {
    final titleCtrl = TextEditingController(text: existing?.title ?? '');
    final amountCtrl = TextEditingController(
        text: existing != null ? existing.amount.toString() : '');
    final noteCtrl = TextEditingController(text: existing?.note ?? '');
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre
                        _dialogLabel('Titre *'),
                        TextField(
                            controller: titleCtrl,
                            autofocus: true,
                            style: const TextStyle(fontSize: 13),
                            decoration: _dlgDeco('Ex: Billet de train...')),
                        const SizedBox(height: 10),

                        // Montant
                        _dialogLabel('Montant (€) *'),
                        TextField(
                            controller: amountCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: const TextStyle(fontSize: 13),
                            decoration: _dlgDeco('0.00')),
                        const SizedBox(height: 10),

                        // Catégorie
                        _dialogLabel('Catégorie'),
                        const SizedBox(height: 6),
                        Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: ExpenseCategory.values.map((c) {
                              final sel = cat == c;
                              return GestureDetector(
                                onTap: () => setD(() => cat = c),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: sel
                                        ? c.color
                                        : c.color.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: c.color.withOpacity(0.4)),
                                  ),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(c.icon,
                                            size: 14,
                                            color:
                                                sel ? Colors.white : c.color),
                                        const SizedBox(width: 4),
                                        Text(c.label,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: sel
                                                    ? Colors.white
                                                    : c.color,
                                                fontWeight: FontWeight.w600)),
                                      ]),
                                ),
                              );
                            }).toList()),
                        const SizedBox(height: 10),

                        // Date
                        _dialogLabel('Date'),
                        const SizedBox(height: 6),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
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
                        const SizedBox(height: 10),

                        // Note (optionnel)
                        _dialogLabel('Note (optionnel)'),
                        TextField(
                            controller: noteCtrl,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 13),
                            decoration: _dlgDeco('Remarques...')),
                      ],
                    ),
                  ),
                ),
                actions: [
                  if (existing != null)
                    TextButton(
                        onPressed: () {
                          setState(() => _expenses
                              .removeWhere((x) => x.id == existing.id));
                          Navigator.pop(ctx);
                        },
                        child: const Text('Supprimer',
                            style: TextStyle(color: Color(0xFFEF4444)))),
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
                              date: date,
                              note: noteCtrl.text.trim().isEmpty
                                  ? null
                                  : noteCtrl.text.trim()));
                        } else {
                          existing.title = title;
                          existing.amount = amount;
                          existing.category = cat;
                          existing.date = date;
                          existing.note = noteCtrl.text.trim().isEmpty
                              ? null
                              : noteCtrl.text.trim();
                        }
                      });
                      Navigator.pop(ctx);
                    },
                    child: Text(existing == null ? 'Ajouter' : 'Enregistrer'),
                  ),
                ],
              ),
            ));
  }

  Widget _dialogLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(text,
            style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
      );

  InputDecoration _dlgDeco(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: primary, width: 1.5)),
        filled: true,
        fillColor: Colors.white,
      );
}

// ─── Helpers ──────────────────────────────────────────────────────────────────
class _StatData {
  final String label;
  final String value;
  final Color color;
  const _StatData(this.label, this.value, this.color);
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
