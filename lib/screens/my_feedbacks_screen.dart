import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'package:intl/intl.dart';

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
}

class MyFeedbacksScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MyFeedbacksScreen({
    super.key,
    this.isDarkMode = false,
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

  final List<FeedbackItem> _feedbacks = [
    FeedbackItem(
        id: '1',
        userName: 'Membre',
        userEmail: 'wbouguila@gmail.com',
        initials: 'BW',
        feedback: 'TEST',
        date: DateTime(2023, 8, 11, 15, 6)),
  ];

  List<FeedbackItem> get _filtered {
    return _feedbacks.where((f) {
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
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    final dateFmt = DateFormat('MMMM dd\'th\', yyyy, hh:mm a');
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header
          Row(children: [
            const Text('List of feed Back',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(width: 10),
            _crumb('Home'),
            const Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
            _crumb('Communication'),
            const Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
            _crumb('feedback', active: true),
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

          // Filters bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: _card(),
            child: Row(children: [
              // Status tabs
              _tab('all', 'All', FeedbackStatus.all),
              const SizedBox(width: 6),
              _tab('replied', 'Replied', FeedbackStatus.replied),
              const SizedBox(width: 6),
              _tab('unanswered', 'Unanswered', FeedbackStatus.unanswered),
              const Spacer(),

              // Year
              _ddWrap(DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                value: _selectedYear,
                items: [2023, 2024, 2025, 2026]
                    .map((y) => DropdownMenuItem(
                        value: y,
                        child:
                            Text('$y', style: const TextStyle(fontSize: 13))))
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
                    style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E))),
                items: [null, ...List.generate(12, (i) => i + 1)]
                    .map((m) => DropdownMenuItem(
                        value: m,
                        child: Text(
                            m == null
                                ? 'All'
                                : DateFormat('MMMM').format(DateTime(2026, m)),
                            style: const TextStyle(fontSize: 13))))
                    .toList(),
                onChanged: (v) => setState(() => _selectedMonth = v),
                icon: const Icon(Icons.keyboard_arrow_down, size: 18),
              ))),
              const SizedBox(width: 8),

              // Search
              SizedBox(
                  width: 180,
                  height: 36,
                  child: TextField(
                    onChanged: (v) => setState(() => _searchUser = v),
                    style: const TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Search by user name',
                      hintStyle: const TextStyle(
                          fontSize: 12, color: Color(0xFFBDBDBD)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: Color(0xFFE0E0E0))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: Color(0xFFE0E0E0))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: primary, width: 1.5)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  )),
            ]),
          ),
          const SizedBox(height: 12),

          // Table
          Expanded(
            child: Container(
              decoration: _card(),
              child: Column(children: [
                // Table header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8))),
                  child: const Row(children: [
                    Expanded(flex: 2, child: _TH('USER')),
                    Expanded(flex: 2, child: _TH('FEEDBACK')),
                    Expanded(flex: 2, child: _TH('RESPONSE')),
                    Expanded(flex: 2, child: _TH('DATE')),
                    SizedBox(width: 60, child: _TH('ACTIONS')),
                  ]),
                ),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),

                _filtered.isEmpty
                    ? const Expanded(
                        child: Center(
                            child: Text('No data to display',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF9E9E9E)))))
                    : Expanded(
                        child: ListView.separated(
                        itemCount: _filtered.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: Color(0xFFF0F0F0)),
                        itemBuilder: (ctx, i) {
                          final f = _filtered[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Row(children: [
                                    CircleAvatar(
                                        radius: 16,
                                        backgroundColor: const Color(0xFFEF4444)
                                            .withOpacity(0.15),
                                        child: Text(f.initials,
                                            style: const TextStyle(
                                                color: Color(0xFFEF4444),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11))),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text(f.userName,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF1A1A2E))),
                                          Text(f.userEmail,
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xFF9E9E9E))),
                                        ])),
                                  ])),
                              Expanded(
                                  flex: 2,
                                  child: Text(f.feedback,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF555555)))),
                              Expanded(
                                  flex: 2,
                                  child: Text(f.response ?? '',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF555555)))),
                              Expanded(
                                  flex: 2,
                                  child: Text(dateFmt.format(f.date),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF9E9E9E)))),
                              SizedBox(
                                  width: 60,
                                  child: IconButton(
                                    icon: const Icon(Icons.more_vert,
                                        size: 18, color: Color(0xFF9E9E9E)),
                                    onPressed: () {},
                                  )),
                            ]),
                          );
                        },
                      )),

                // Pagination
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8)),
                      border:
                          Border(top: BorderSide(color: Color(0xFFE5E7EB)))),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _tab(String val, String label, FeedbackStatus status) {
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
