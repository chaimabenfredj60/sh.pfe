import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'package:intl/intl.dart';

enum DocStatus { all, replied, unanswered }

class DocumentRequest {
  final String id;
  final String userName;
  final String userEmail;
  final String initials;
  final String request;
  final String? response;
  final DateTime date;

  const DocumentRequest({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.initials,
    required this.request,
    this.response,
    required this.date,
  });

  bool get isReplied => response != null && response!.isNotEmpty;
}

class MyDocumentsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MyDocumentsScreen({
    super.key,
    this.isDarkMode = false,
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

  // Données de démo vides (comme sur la capture)
  final List<DocumentRequest> _requests = [];

  List<DocumentRequest> get _filtered => _requests.where((r) {
        final matchStatus = _status == DocStatus.all ||
            (_status == DocStatus.replied && r.isReplied) ||
            (_status == DocStatus.unanswered && !r.isReplied);
        final matchYear = r.date.year == _selectedYear;
        final matchMonth =
            _selectedMonth == null || r.date.month == _selectedMonth;
        return matchStatus && matchYear && matchMonth;
      }).toList();

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header
          Row(children: [
            const Text('Document requests',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(width: 10),
            _crumb('Home'),
            const Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
            _crumb('Communication'),
            const Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
            _crumb('Requests', active: true),
            const Spacer(),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: primary,
                  side: const BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              icon: const Icon(Icons.person_add_outlined, size: 15),
              label: const Text('Coopt a Talented Employee',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              onPressed: () {},
            ),
          ]),
          const SizedBox(height: 16),

          // Table card
          Expanded(
            child: Container(
              decoration: _card(),
              child: Column(children: [
                // Filters bar inside card
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8))),
                  child: Row(children: [
                    _tab('all', 'All', DocStatus.all),
                    const SizedBox(width: 6),
                    _tab('replied', 'Replied', DocStatus.replied),
                    const SizedBox(width: 6),
                    _tab('unanswered', 'Unanswered', DocStatus.unanswered),
                    const Spacer(),

                    // Year
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

                    // Month
                    _ddWrap(DropdownButtonHideUnderline(
                        child: DropdownButton<int?>(
                      value: _selectedMonth,
                      hint: const Text('Select Month',
                          style: TextStyle(
                              fontSize: 13, color: Color(0xFF9E9E9E))),
                      items: [null, ...List.generate(12, (i) => i + 1)]
                          .map((m) => DropdownMenuItem(
                              value: m,
                              child: Text(
                                  m == null
                                      ? 'All'
                                      : DateFormat('MMMM')
                                          .format(DateTime(2026, m)),
                                  style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedMonth = v),
                      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                    ))),
                  ]),
                ),
                const Divider(height: 1, color: Color(0xFFE0E0E0)),

                // Content
                Expanded(
                  child: _filtered.isEmpty
                      ? const Center(
                          child: Text('No data to display',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF9E9E9E))))
                      : ListView.separated(
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => const Divider(
                              height: 1, color: Color(0xFFF0F0F0)),
                          itemBuilder: (ctx, i) {
                            final r = _filtered[i];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(children: [
                                CircleAvatar(
                                    radius: 16,
                                    backgroundColor: primary.withOpacity(0.15),
                                    child: Text(r.initials,
                                        style: const TextStyle(
                                            color: primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11))),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(r.userName,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1A1A2E))),
                                      Text(r.userEmail,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF9E9E9E))),
                                    ])),
                                const SizedBox(width: 16),
                                Expanded(
                                    child: Text(r.request,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF555555)))),
                                const SizedBox(width: 16),
                                Expanded(
                                    child: Text(r.response ?? '',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF555555)))),
                                IconButton(
                                  icon: const Icon(Icons.more_vert,
                                      size: 18, color: Color(0xFF9E9E9E)),
                                  onPressed: () {},
                                ),
                              ]),
                            );
                          },
                        ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _tab(String val, String label, DocStatus status) {
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

  Widget _crumb(String label, {bool active = false}) => Text(label,
      style: TextStyle(
          fontSize: 12,
          color: active ? primary : const Color(0xFF9E9E9E),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal));

  BoxDecoration _card() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ]);
}
