import 'package:flutter/material.dart';

// ── Modèle ────────────────────────────────────────────────────────────────────
enum AppStatus { init, inProgress, accepted, rejected }

extension AppStatusExt on AppStatus {
  String get label {
    switch (this) {
      case AppStatus.init:
        return 'Init';
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
        return 'Review';
      case PipelineStep.interview:
        return 'Interview';
      case PipelineStep.hired:
        return 'Hired';
    }
  }

  IconData get icon {
    switch (this) {
      case PipelineStep.received:
        return Icons.inbox_outlined;
      case PipelineStep.underReview:
        return Icons.find_in_page_outlined;
      case PipelineStep.interview:
        return Icons.groups_outlined;
      case PipelineStep.hired:
        return Icons.check_circle_outline;
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
  const Application(
    id: '2',
    candidateName: 'Alice Martin',
    candidateEmail: 'alice.martin@email.com',
    offer: 'Développeur Flutter Senior',
    date: '18/04/2026',
    cvUrl: 'https://example.com/cv',
    currentStep: PipelineStep.interview,
    status: AppStatus.inProgress,
  ),
  const Application(
    id: '3',
    candidateName: 'Jean Dupont',
    candidateEmail: 'jean.dupont@email.com',
    offer: 'Product Manager',
    date: '15/04/2026',
    currentStep: PipelineStep.hired,
    status: AppStatus.accepted,
  ),
];

// ═══════════════════════════════════════════════════════════════════════════════
class MyApplicationsScreen extends StatefulWidget {
  final String language;

  const MyApplicationsScreen({
    super.key,
    this.language = 'en',
  });

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  static const Color primary = Color(0xFF00B4A6);
  static const double _kMobile = 600;
  static const double _kTablet = 900;

  final _searchCtrl = TextEditingController();
  String _search = '';
  int _showCount = 7;
  int _page = 1;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

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

  bool _isMobile(double w) => w < _kMobile;
  bool _isTablet(double w) => w >= _kMobile && w < _kTablet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final mobile = _isMobile(w);
          final tablet = _isTablet(w);
          final padding = mobile ? 12.0 : 16.0;

          final paged = _filtered
              .skip((_page - 1) * _showCount)
              .take(_showCount)
              .toList();
          final totalPages =
              (_filtered.length / _showCount).ceil().clamp(1, 999);

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(mobile),
                SizedBox(height: mobile ? 12 : 16),
                _buildStats(mobile, tablet),
                SizedBox(height: mobile ? 10 : 16),
                Expanded(
                  child: Container(
                    decoration: _cardDeco(),
                    child: Column(children: [
                      _buildSearchBar(mobile),
                      if (!mobile) _buildTableHeader(),
                      Expanded(
                        child: paged.isEmpty
                            ? const Center(
                                child: Text('No data to display',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF9E9E9E))))
                            : mobile
                                ? _buildCardList(paged)
                                : _buildTableRows(paged),
                      ),
                      _buildPagination(totalPages),
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader(bool mobile) {
    return mobile
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('My Applications',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 8),
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
          ])
        : Row(children: [
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
          ]);
  }

  // ── Stats ──────────────────────────────────────────────────────────────────
  Widget _buildStats(bool mobile, bool tablet) {
    final cards = [
      _statCard(
          Icons.work_outline, const Color(0xFF3B82F6), '$_total', 'Total'),
      _statCard(Icons.access_time_outlined, const Color(0xFFFF9800),
          '$_initCount', 'Init'),
      _statCard(Icons.layers_outlined, const Color(0xFF00B4A6), '$_inProgress',
          'In Progress'),
      _statCard(Icons.check_circle_outline, const Color(0xFF4CAF50),
          '$_accepted', 'Accepted'),
    ];

    if (mobile) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.2,
        children: cards,
      );
    }

    return Row(
      children: cards
          .map((c) => [c, const SizedBox(width: 12)])
          .expand((x) => x)
          .toList()
        ..removeLast(),
    );
  }

  Widget _statCard(IconData icon, Color color, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _cardDeco(),
        child: Row(children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
          ]),
        ]),
      ),
    );
  }

  // ── Search bar ─────────────────────────────────────────────────────────────
  Widget _buildSearchBar(bool mobile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: mobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _searchField(fullWidth: true),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Afficher :',
                    style: TextStyle(fontSize: 12, color: Color(0xFF555555))),
                _showDropdown(),
              ]),
            ])
          : Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Search',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF555555))),
                const SizedBox(height: 6),
                _searchField(),
              ]),
              const Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Show',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF555555))),
                const SizedBox(height: 6),
                _showDropdown(),
              ]),
            ]),
    );
  }

  Widget _searchField({bool fullWidth = false}) {
    return SizedBox(
      width: fullWidth ? double.infinity : 320,
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
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFBDBDBD)),
          prefixIcon:
              const Icon(Icons.search, size: 16, color: Color(0xFFBDBDBD)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
  }

  Widget _showDropdown() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(6)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _showCount,
          items: [5, 7, 10, 20]
              .map((n) => DropdownMenuItem(
                  value: n,
                  child: Text('$n', style: const TextStyle(fontSize: 13))))
              .toList(),
          onChanged: (v) => setState(() {
            _showCount = v!;
            _page = 1;
          }),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        ),
      ),
    );
  }

  // ── Table header ───────────────────────────────────────────────────────────
  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border(
          top: BorderSide(color: Color(0xFFE5E7EB)),
          bottom: BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),
      child: const Row(children: [
        Expanded(flex: 2, child: _TH('CANDIDAT')),
        Expanded(flex: 3, child: _TH('OFFRE')),
        Expanded(child: _TH('DATE')),
        SizedBox(width: 60, child: _TH('CV')),
        Expanded(flex: 2, child: _TH('PIPELINE')),
        Expanded(child: _TH('STATUT')),
      ]),
    );
  }

  // ── Table rows ─────────────────────────────────────────────────────────────
  Widget _buildTableRows(List<Application> paged) {
    return ListView.separated(
      itemCount: paged.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
      itemBuilder: (ctx, i) => _tableRow(paged[i]),
    );
  }

  Widget _tableRow(Application a) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        // Candidat
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

        // Offre
        Expanded(
            flex: 3,
            child: Text(a.offer,
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF374151)))),

        // Date
        Expanded(
            child: Text(a.date,
                style:
                    const TextStyle(fontSize: 12, color: Color(0xFF555555)))),

        // CV
        SizedBox(
            width: 60,
            child: a.cvUrl != null
                ? TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0)),
                    onPressed: () {},
                    child: const Text('Voir CV',
                        style: TextStyle(color: primary, fontSize: 12)))
                : const Text('—',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)))),

        // Pipeline
        Expanded(flex: 2, child: _pipeline(a.currentStep)),

        // Statut
        Expanded(child: _statusBadge(a.status)),
      ]),
    );
  }

  // ── Mobile card list ───────────────────────────────────────────────────────
  Widget _buildCardList(List<Application> paged) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: paged.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) => _mobileCard(paged[i]),
    );
  }

  Widget _mobileCard(Application a) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Top row: name + status
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a.candidateName,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E))),
              const SizedBox(height: 2),
              Text(a.candidateEmail,
                  style:
                      const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
            ]),
          ),
          _statusBadge(a.status),
        ]),
        const SizedBox(height: 8),
        // Offer
        Text(a.offer,
            style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        // Date + CV
        Row(children: [
          const Icon(Icons.calendar_today_outlined,
              size: 13, color: Color(0xFF9E9E9E)),
          const SizedBox(width: 4),
          Text(a.date,
              style: const TextStyle(fontSize: 12, color: Color(0xFF555555))),
          const Spacer(),
          if (a.cvUrl != null)
            TextButton.icon(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
              onPressed: () {},
              icon: const Icon(Icons.insert_drive_file_outlined,
                  size: 14, color: primary),
              label: const Text('Voir CV',
                  style: TextStyle(color: primary, fontSize: 12)),
            ),
        ]),
        const SizedBox(height: 10),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),
        const SizedBox(height: 10),
        // Pipeline
        _pipelineMobile(a.currentStep),
      ]),
    );
  }

  // ── Pipeline (desktop) ─────────────────────────────────────────────────────
  Widget _pipeline(PipelineStep current) {
    final steps = PipelineStep.values;
    final currentIdx = steps.indexOf(current);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(steps.length, (i) {
        final isDone = i <= currentIdx;
        final isFirst = i == 0;
        return Row(mainAxisSize: MainAxisSize.min, children: [
          if (!isFirst)
            Container(
                width: 12,
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
            Text(steps[i].label,
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

  // ── Pipeline (mobile, horizontal avec icônes) ──────────────────────────────
  Widget _pipelineMobile(PipelineStep current) {
    final steps = PipelineStep.values;
    final currentIdx = steps.indexOf(current);
    return Row(
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          final isDone = (i ~/ 2) < currentIdx;
          return Expanded(
            child: Container(
              height: 2,
              color: isDone ? primary : const Color(0xFFE0E0E0),
            ),
          );
        }
        final idx = i ~/ 2;
        final isDone = idx <= currentIdx;
        final step = steps[idx];
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isDone ? primary : const Color(0xFFEEEEEE),
              shape: BoxShape.circle,
            ),
            child: Icon(step.icon,
                size: 14,
                color: isDone ? Colors.white : const Color(0xFF9E9E9E)),
          ),
          const SizedBox(height: 4),
          Text(step.label,
              style: TextStyle(
                  fontSize: 9,
                  color: isDone ? primary : const Color(0xFF9E9E9E),
                  fontWeight: isDone ? FontWeight.w600 : FontWeight.normal)),
        ]);
      }),
    );
  }

  // ── Status badge ───────────────────────────────────────────────────────────
  Widget _statusBadge(AppStatus status) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: status.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(status.label,
            style: TextStyle(
                fontSize: 11,
                color: status.color,
                fontWeight: FontWeight.w600)),
      );

  // ── Pagination ─────────────────────────────────────────────────────────────
  Widget _buildPagination(int totalPages) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text('${_filtered.length} résultat(s)',
            style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
        const Spacer(),
        _pgBtn('<', _page > 1 ? () => setState(() => _page--) : null),
        Container(
          width: 28,
          height: 28,
          decoration:
              const BoxDecoration(color: primary, shape: BoxShape.circle),
          child: Center(
              child: Text('$_page',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold))),
        ),
        _pgBtn('>', _page < totalPages ? () => setState(() => _page++) : null),
      ]),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
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

// ── _TH ───────────────────────────────────────────────────────────────────────
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
