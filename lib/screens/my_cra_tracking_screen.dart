import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'package:intl/intl.dart';

enum CraStatus { validated, pending, rejected }

extension CraStatusExt on CraStatus {
  String get label {
    switch (this) {
      case CraStatus.validated:
        return 'Validé';
      case CraStatus.pending:
        return 'En attente';
      case CraStatus.rejected:
        return 'Rejeté';
    }
  }

  Color get color {
    switch (this) {
      case CraStatus.validated:
        return const Color(0xFF4CAF50);
      case CraStatus.pending:
        return const Color(0xFFFF9800);
      case CraStatus.rejected:
        return const Color(0xFFEF4444);
    }
  }
}

class CraRecord {
  final String id;
  final int year;
  final int month;
  final CraStatus status;
  final int workDays;
  final int absenceDays;
  final int travelDays;
  final DateTime submittedAt;

  const CraRecord({
    required this.id,
    required this.year,
    required this.month,
    required this.status,
    required this.workDays,
    required this.absenceDays,
    required this.travelDays,
    required this.submittedAt,
  });
}

class MyCraTrackingScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;

  const MyCraTrackingScreen({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });

  static const Color primary = Color(0xFF00B4A6);

  static final _records = [
    CraRecord(
        id: '1',
        year: 2026,
        month: 3,
        status: CraStatus.validated,
        workDays: 20,
        absenceDays: 1,
        travelDays: 2,
        submittedAt: DateTime(2026, 4, 1)),
    CraRecord(
        id: '2',
        year: 2026,
        month: 2,
        status: CraStatus.validated,
        workDays: 18,
        absenceDays: 2,
        travelDays: 0,
        submittedAt: DateTime(2026, 3, 2)),
    CraRecord(
        id: '3',
        year: 2026,
        month: 1,
        status: CraStatus.rejected,
        workDays: 15,
        absenceDays: 3,
        travelDays: 1,
        submittedAt: DateTime(2026, 2, 3)),
    CraRecord(
        id: '4',
        year: 2025,
        month: 12,
        status: CraStatus.validated,
        workDays: 21,
        absenceDays: 0,
        travelDays: 2,
        submittedAt: DateTime(2026, 1, 2)),
    CraRecord(
        id: '5',
        year: 2025,
        month: 11,
        status: CraStatus.pending,
        workDays: 19,
        absenceDays: 1,
        travelDays: 0,
        submittedAt: DateTime(2025, 12, 1)),
  ];

  @override
  Widget build(BuildContext context) {
    context.watch<AppTheme>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header
          const Text('My CRA Tracking',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E))),
          const SizedBox(height: 4),
          const Text('Historique de vos comptes rendus d\'activité',
              style: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E))),
          const SizedBox(height: 16),

          // Stats row
          Row(children: [
            _statCard(
                'Total soumis', '${_records.length}', const Color(0xFF3B82F6)),
            const SizedBox(width: 12),
            _statCard(
                'Validés',
                '${_records.where((r) => r.status == CraStatus.validated).length}',
                const Color(0xFF4CAF50)),
            const SizedBox(width: 12),
            _statCard(
                'En attente',
                '${_records.where((r) => r.status == CraStatus.pending).length}',
                const Color(0xFFFF9800)),
            const SizedBox(width: 12),
            _statCard(
                'Rejetés',
                '${_records.where((r) => r.status == CraStatus.rejected).length}',
                const Color(0xFFEF4444)),
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
                // Table header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: const Row(children: [
                    Expanded(flex: 2, child: _TH('PÉRIODE')),
                    Expanded(child: _TH('JOURS TRAVAIL')),
                    Expanded(child: _TH('ABSENCES')),
                    Expanded(child: _TH('DÉPLACEMENTS')),
                    Expanded(child: _TH('SOUMIS LE')),
                    Expanded(child: _TH('STATUT')),
                    SizedBox(width: 40),
                  ]),
                ),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),

                Expanded(
                  child: ListView.separated(
                    itemCount: _records.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: Color(0xFFF0F0F0)),
                    itemBuilder: (ctx, i) => _row(ctx, _records[i]),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
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
                    fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
          ]),
        ),
      );

  Widget _row(BuildContext ctx, CraRecord r) {
    final monthFmt = DateFormat('MMMM yyyy', 'fr_FR');
    final dateFmt = DateFormat('dd/MM/yyyy');
    final period = monthFmt.format(DateTime(r.year, r.month));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Text(period,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A2E)))),
        Expanded(child: _cell('${r.workDays} j', const Color(0xFF00B4A6))),
        Expanded(child: _cell('${r.absenceDays} j', const Color(0xFF3B82F6))),
        Expanded(child: _cell('${r.travelDays} j', const Color(0xFFFF9800))),
        Expanded(
            child: Text(dateFmt.format(r.submittedAt),
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF555555)))),
        Expanded(child: _badge(r.status)),
        SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.visibility_outlined,
                  size: 18, color: Color(0xFF9E9E9E)),
              onPressed: () => _detail(ctx, r),
            )),
      ]),
    );
  }

  Widget _cell(String label, Color color) => Text(label,
      style:
          TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600));

  Widget _badge(CraStatus status) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: status.color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 6,
              height: 6,
              decoration:
                  BoxDecoration(color: status.color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text(status.label,
              style: TextStyle(
                  fontSize: 11,
                  color: status.color,
                  fontWeight: FontWeight.w600)),
        ]),
      );

  void _detail(BuildContext ctx, CraRecord r) {
    final monthFmt = DateFormat('MMMM yyyy', 'fr_FR');
    showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text('CRA — ${monthFmt.format(DateTime(r.year, r.month))}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                _dRow('Jours travaillés', '${r.workDays} jour(s)'),
                _dRow('Absences', '${r.absenceDays} jour(s)'),
                _dRow('Déplacements', '${r.travelDays} jour(s)'),
                _dRow('Statut', r.status.label),
              ]),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Fermer'),
                ),
              ],
            ));
  }

  Widget _dRow(String label, String val) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: Color(0xFF555555))),
          Text(val,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E))),
        ]),
      );
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
