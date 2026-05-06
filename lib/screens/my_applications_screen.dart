import 'package:flutter/material.dart';

// ── Modèle ────────────────────────────────────────────────────────────────────
enum AppStatus { init, inProgress, accepted, rejected }

extension AppStatusExt on AppStatus {
  String get label {
    switch (this) {
      case AppStatus.init:
        return 'init';
      case AppStatus.inProgress:
        return 'In Progress';
      case AppStatus.accepted:
        return 'Accepted';
      case AppStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case AppStatus.init:
        return const Color(0xFF00B4A6);
      case AppStatus.inProgress:
        return const Color(0xFFFF9800);
      case AppStatus.accepted:
        return const Color(0xFF4CAF50);
      case AppStatus.rejected:
        return const Color(0xFFEF4444);
    }
  }
}

enum PipelineStep { received, underReview, interview, hired }

extension PipelineStepExt on PipelineStep {
  String get label {
    switch (this) {
      case PipelineStep.received:
        return 'Received';
      case PipelineStep.underReview:
        return 'Under\nreview';
      case PipelineStep.interview:
        return 'Intervie\nw';
      case PipelineStep.hired:
        return 'Hired';
    }
  }
}

class Application {
  final String id;
  final String candidateName;
  final String candidateEmail;
  final String offer;
  final String date;
  final String? cvUrl;
  final PipelineStep currentStep;
  final AppStatus status;

  const Application({
    required this.id,
    required this.candidateName,
    required this.candidateEmail,
    required this.offer,
    required this.date,
    this.cvUrl,
    required this.currentStep,
    required this.status,
  });
}

// ── Données démo ──────────────────────────────────────────────────────────────
final _demoApps = [
  const Application(
    id: '1',
    candidateName: 'Membre',
    candidateEmail: 'wbouguila@gmail.com',
    offer: 'Ingénieur DevOps AWS / Kubernetes / Terraform',
    date: '20/04/2026',
    currentStep: PipelineStep.received,
    status: AppStatus.init,
  ),
];

// ═══════════════════════════════════════════════════════════════════════════════
class MyApplicationsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MyApplicationsScreen({
    super.key,
    this.isDarkMode = false,
    this.language = 'en',
  });
  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  static const Color primary = Color(0xFF00B4A6);

  final _searchCtrl = TextEditingController();
  String _search = '';
  int _showCount = 7;
  int _page = 1;

  List<Application> get _filtered => _demoApps.where((a) {
        final q = _search.toLowerCase();
        return q.isEmpty ||
            a.candidateName.toLowerCase().contains(q) ||
            a.candidateEmail.toLowerCase().contains(q) ||
            a.offer.toLowerCase().contains(q) ||
            a.status.label.toLowerCase().contains(q);
      }).toList();

  int get _total => _demoApps.length;
  int get _initCount =>
      _demoApps.where((a) => a.status == AppStatus.init).length;
  int get _inProgress =>
      _demoApps.where((a) => a.status == AppStatus.inProgress).length;
  int get _accepted =>
      _demoApps.where((a) => a.status == AppStatus.accepted).length;

  @override
  Widget build(BuildContext context) {
    final paged =
        _filtered.skip((_page - 1) * _showCount).take(_showCount).toList();
    final totalPages = (_filtered.length / _showCount).ceil().clamp(1, 999);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Header ──────────────────────────────────────────────────────
          Row(children: [
            const Text('My Applications',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(width: 10),
            _crumb('Home'),
            const Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
            _crumb('Pages'),
            const Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
            _crumb('My Applications', active: true),
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
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              onPressed: () {},
            ),
          ]),
          const SizedBox(height: 16),

          // ── Stats cards ──────────────────────────────────────────────────
          Row(children: [
            _statCard(Icons.work_outline, const Color(0xFF3B82F6), '$_total',
                'Total'),
            const SizedBox(width: 12),
            _statCard(Icons.access_time_outlined, const Color(0xFFFF9800),
                '$_initCount', 'Init'),
            const SizedBox(width: 12),
            _statCard(Icons.layers_outlined, const Color(0xFF00B4A6),
                '$_inProgress', 'In Progress'),
            const SizedBox(width: 12),
            _statCard(Icons.check_circle_outline, const Color(0xFF4CAF50),
                '$_accepted', 'Accepted'),
          ]),
          const SizedBox(height: 16),

          // ── Table card ───────────────────────────────────────────────────
          Expanded(
            child: Container(
              decoration: _cardDeco(),
              child: Column(children: [
                // Search + show
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Search',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF555555))),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 340,
                            height: 36,
                            child: TextField(
                              controller: _searchCtrl,
                              onChanged: (v) => setState(() {
                                _search = v;
                                _page = 1;
                              }),
                              style: const TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                hintText: 'Name, email, offer, status...',
                                hintStyle: const TextStyle(
                                    fontSize: 12, color: Color(0xFFBDBDBD)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE0E0E0))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE0E0E0))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: primary, width: 1.5)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                    const Spacer(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Show',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF555555))),
                          const SizedBox(height: 6),
                          Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: const Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.circular(6)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _showCount,
                                items: [5, 7, 10, 20]
                                    .map((n) => DropdownMenuItem(
                                        value: n,
                                        child: Text('$n',
                                            style:
                                                const TextStyle(fontSize: 13))))
                                    .toList(),
                                onChanged: (v) => setState(() {
                                  _showCount = v!;
                                  _page = 1;
                                }),
                                icon: const Icon(Icons.keyboard_arrow_down,
                                    size: 18),
                              ),
                            ),
                          ),
                        ]),
                  ]),
                ),

                // Table header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    border: Border(
                      top: BorderSide(color: Color(0xFFE5E7EB)),
                      bottom: BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                  child: const Row(children: [
                    Expanded(flex: 2, child: _TH('CANDIDATE')),
                    Expanded(flex: 2, child: _TH('OFFER')),
                    Expanded(flex: 2, child: _TH('DATE')),
                    Expanded(child: _TH('CV')),
                    Expanded(flex: 2, child: _TH('PIPELINE')),
                    Expanded(child: _TH('STATUS')),
                  ]),
                ),

                // Rows
                Expanded(
                  child: paged.isEmpty
                      ? const Center(
                          child: Text('No data to display',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF9E9E9E))))
                      : ListView.separated(
                          itemCount: paged.length,
                          separatorBuilder: (_, __) => const Divider(
                              height: 1, color: Color(0xFFF0F0F0)),
                          itemBuilder: (ctx, i) => _appRow(paged[i]),
                        ),
                ),

                // Pagination
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8)),
                    border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                  ),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    _pgBtn(
                        '<', _page > 1 ? () => setState(() => _page--) : null),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                          color: primary, shape: BoxShape.circle),
                      child: Center(
                          child: Text('$_page',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))),
                    ),
                    _pgBtn(
                        '>',
                        _page < totalPages
                            ? () => setState(() => _page++)
                            : null),
                  ]),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  // ── Row ───────────────────────────────────────────────────────────────────
  Widget _appRow(Application a) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        // Candidate
        Expanded(
            flex: 2,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a.candidateName,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E))),
              Text(a.candidateEmail,
                  style:
                      const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            ])),

        // Offer
        Expanded(
            flex: 2,
            child: Text(a.offer,
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF374151)))),

        // Date
        Expanded(
            flex: 2,
            child: Text(a.date,
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF555555)))),

        // CV
        Expanded(
            child: a.cvUrl != null
                ? TextButton(
                    onPressed: () {},
                    child: const Text('Voir CV',
                        style: TextStyle(color: primary, fontSize: 12)))
                : const Text('—',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)))),

        // Pipeline
        Expanded(flex: 2, child: _pipeline(a.currentStep)),

        // Status
        Expanded(child: _statusBadge(a.status)),
      ]),
    );
  }

  // ── Pipeline steps ────────────────────────────────────────────────────────
  Widget _pipeline(PipelineStep current) {
    final steps = PipelineStep.values;
    final currentIdx = steps.indexOf(current);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(steps.length, (i) {
        final step = steps[i];
        final isDone = i <= currentIdx;
        final isFirst = i == 0;
        return Row(mainAxisSize: MainAxisSize.min, children: [
          if (!isFirst)
            Container(
                width: 10,
                height: 1,
                color: isDone ? primary : const Color(0xFFE0E0E0)),
          Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isDone ? primary : const Color(0xFFE0E0E0),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 2),
            Text(step.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 7,
                    color: isDone ? primary : const Color(0xFF9E9E9E),
                    fontWeight: isDone ? FontWeight.w600 : FontWeight.normal)),
          ]),
        ]);
      }),
    );
  }

  // ── Status badge ──────────────────────────────────────────────────────────
  Widget _statusBadge(AppStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status.label,
          style: TextStyle(
              fontSize: 12, color: status.color, fontWeight: FontWeight.w600)),
    );
  }

  // ── Stat card ─────────────────────────────────────────────────────────────
  Widget _statCard(IconData icon, Color color, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDeco(),
        child: Row(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            Text(label,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
          ]),
        ]),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  Widget _crumb(String label, {bool active = false}) => Text(label,
      style: TextStyle(
          fontSize: 12,
          color: active ? primary : const Color(0xFF9E9E9E),
          fontWeight: active ? FontWeight.w600 : FontWeight.normal));

  Widget _pgBtn(String label, VoidCallback? onTap) => InkWell(
        onTap: onTap,
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
                  style: TextStyle(
                      fontSize: 13,
                      color: onTap != null
                          ? const Color(0xFF555555)
                          : const Color(0xFFBDBDBD)))),
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
