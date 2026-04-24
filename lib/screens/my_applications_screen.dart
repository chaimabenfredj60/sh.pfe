import 'package:flutter/material.dart';

// ─── MODEL ──────────────────────────────────────────────────────────────────

class Application {
  final String candidateName;
  final String candidateEmail;
  final String offer;
  final String date;
  final String status;
  final int pipelineStep; // 0=Received 1=UnderReview 2=Interview 3=Hired

  const Application({
    required this.candidateName,
    required this.candidateEmail,
    required this.offer,
    required this.date,
    required this.status,
    required this.pipelineStep,
  });
}

final List<Application> _mockApplications = [
  const Application(
    candidateName: 'BOUGUILA Wissem',
    candidateEmail: 'wbouguila@gmail.com',
    offer: 'Ingénieur DevOps AWS / Kubernetes / Terraform',
    date: '20/04/2026',
    status: 'init',
    pipelineStep: 0,
  ),
];

// ─── SCREEN ─────────────────────────────────────────────────────────────────

class MyApplicationsScreen extends StatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  static const Color primary = Color(0xFF00B4A6);

  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Application> get _filtered {
    if (_query.isEmpty) return _mockApplications;
    final q = _query.toLowerCase();
    return _mockApplications.where((a) =>
        a.candidateName.toLowerCase().contains(q) ||
        a.candidateEmail.toLowerCase().contains(q) ||
        a.offer.toLowerCase().contains(q) ||
        a.status.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F6F9),
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildStatCards(),
                  const SizedBox(height: 24),
                  _buildTable(),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  // ── TOP BAR ────────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          _outlinedBtn(Icons.description_outlined, 'Request a document or information'),
          const SizedBox(width: 10),
          _outlinedBtn(Icons.folder_outlined, 'My documents / responses'),
          const Spacer(),
          const Text('🇺🇸 English',
              style: TextStyle(fontSize: 13, color: Color(0xFF4A5568))),
          const SizedBox(width: 16),
          const Icon(Icons.dark_mode_outlined, size: 20, color: Color(0xFF8A9BB0)),
          const SizedBox(width: 12),
          const Icon(Icons.search, size: 20, color: Color(0xFF8A9BB0)),
          const SizedBox(width: 12),
          Stack(children: [
            const Icon(Icons.notifications_outlined, size: 20, color: Color(0xFF8A9BB0)),
            Positioned(
              right: 0, top: 0,
              child: Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                    color: Color(0xFFFF5252), shape: BoxShape.circle),
              ),
            ),
          ]),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('BOUGUILA Wissem',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E))),
              Text('member',
                  style: TextStyle(fontSize: 10, color: Color(0xFF8A9BB0))),
            ],
          ),
          const SizedBox(width: 10),
          Stack(
            alignment: Alignment.topRight,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(Icons.person, color: Colors.white),
              ),
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                alignment: Alignment.center,
                child: const Text('56%',
                    style: TextStyle(
                        fontSize: 6,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _outlinedBtn(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 15),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: Color(0xFF00B4A6)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // ── HEADER ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Applications',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 4),
            Row(children: [
              _crumb('Home', link: true),
              const Icon(Icons.chevron_right, size: 14, color: Color(0xFF8A9BB0)),
              _crumb('Pages', link: true),
              const Icon(Icons.chevron_right, size: 14, color: Color(0xFF8A9BB0)),
              _crumb('My Applications'),
            ]),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send, size: 16),
          label: const Text('Coopt a Talented Employee'),
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _crumb(String label, {bool link = false}) {
    return Text(label,
        style: TextStyle(
            fontSize: 12,
            color: link ? primary : const Color(0xFF4A5568),
            fontWeight: link ? FontWeight.w500 : FontWeight.normal));
  }

  // ── STAT CARDS ─────────────────────────────────────────────────────────────

  Widget _buildStatCards() {
    return Row(children: [
      _statCard(Icons.work_outline,        const Color(0xFF42A5F5), const Color(0xFFE3F2FD), '1', 'Total'),
      const SizedBox(width: 16),
      _statCard(Icons.access_time,         const Color(0xFFFFA726), const Color(0xFFFFF3E0), '1', 'Init'),
      const SizedBox(width: 16),
      _statCard(Icons.layers_outlined,     const Color(0xFF26C6DA), const Color(0xFFE0F7FA), '0', 'In Progress'),
      const SizedBox(width: 16),
      _statCard(Icons.check_circle_outline,const Color(0xFF66BB6A), const Color(0xFFE8F5E9), '0', 'Accepted'),
    ]);
  }

  Widget _statCard(IconData icon, Color iconColor, Color iconBg,
      String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            Text(label,
                style: const TextStyle(fontSize: 13, color: Color(0xFF8A9BB0))),
          ]),
        ]),
      ),
    );
  }

  // ── TABLE ──────────────────────────────────────────────────────────────────

  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(children: [
        // Search + Show
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Search',
                      style: TextStyle(fontSize: 12, color: Color(0xFF8A9BB0))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _searchCtrl,
                    onChanged: (v) => setState(() => _query = v),
                    decoration: InputDecoration(
                      hintText: 'Name, email, offer, status...',
                      hintStyle: const TextStyle(
                          fontSize: 13, color: Color(0xFFB0BEC5)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: primary)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Show',
                    style: TextStyle(fontSize: 12, color: Color(0xFF8A9BB0))),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    const Text('7', style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 6),
                    Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
                  ]),
                ),
              ],
            ),
          ]),
        ),

        // Table header
        Container(
          color: const Color(0xFFF8FAFC),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(children: [
            Expanded(flex: 3, child: _TH('CANDIDATE')),
            Expanded(flex: 3, child: _TH('OFFER')),
            Expanded(flex: 2, child: _TH('DATE')),
            Expanded(flex: 2, child: _TH('CV')),
            Expanded(flex: 4, child: _TH('PIPELINE')),
            Expanded(flex: 2, child: _TH('STATUS')),
          ]),
        ),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),

        // Rows
        ..._filtered.map((app) => _AppRow(app: app)),

        // Pagination
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _pageBtn(Icons.chevron_left),
              const SizedBox(width: 6),
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(6)),
                alignment: Alignment.center,
                child: const Text('1',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
              const SizedBox(width: 6),
              _pageBtn(Icons.chevron_right),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _pageBtn(IconData icon) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(6)),
      child: Icon(icon, size: 18, color: const Color(0xFF8A9BB0)),
    );
  }

  // ── FOOTER ─────────────────────────────────────────────────────────────────

  Widget _buildFooter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('COPYRIGHT © 2026 , All rights Reserved',
              style: TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
          const Row(children: [
            Text('Hand-crafted & Made with ',
                style: TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
            Icon(Icons.favorite, size: 12, color: Colors.red),
            Text(' by R.O',
                style: TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
          ]),
        ],
      ),
    );
  }
}

// ─── TABLE HEADER CELL ──────────────────────────────────────────────────────

class _TH extends StatelessWidget {
  final String label;
  const _TH(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF8A9BB0),
            letterSpacing: 0.8));
  }
}

// ─── TABLE ROW ──────────────────────────────────────────────────────────────

class _AppRow extends StatelessWidget {
  final Application app;
  const _AppRow({required this.app});

  static const _steps = ['Received', 'Under\nreview', 'Interview', 'Hired'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF5F5F5)))),
      child: Row(children: [
        // Candidate
        Expanded(
          flex: 3,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(app.candidateName,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E))),
            Text(app.candidateEmail,
                style: const TextStyle(fontSize: 11, color: Color(0xFF8A9BB0))),
          ]),
        ),
        // Offer
        Expanded(
          flex: 3,
          child: Text(app.offer,
              style: const TextStyle(fontSize: 12, color: Color(0xFF4A5568)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ),
        // Date
        Expanded(
          flex: 2,
          child: Text(app.date,
              style: const TextStyle(fontSize: 12, color: Color(0xFF4A5568))),
        ),
        // CV
        Expanded(
          flex: 2,
          child: Text('—', style: TextStyle(color: Colors.grey[400])),
        ),
        // Pipeline
        Expanded(
          flex: 4,
          child: Row(
            children: List.generate(_steps.length, (i) {
              final active = i <= app.pipelineStep;
              return Row(children: [
                if (i > 0)
                  Container(
                      width: 14, height: 1,
                      color: active
                          ? const Color(0xFF00B4A6)
                          : const Color(0xFFE0E0E0)),
                Column(children: [
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: active
                            ? const Color(0xFF00B4A6)
                            : const Color(0xFFE0E0E0)),
                  ),
                  const SizedBox(height: 4),
                  Text(_steps[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 7,
                          color: active
                              ? const Color(0xFF00B4A6)
                              : const Color(0xFFB0BEC5))),
                ]),
              ]);
            }),
          ),
        ),
        // Status
        Expanded(
          flex: 2,
          child: Text(app.status,
              style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF00B4A6),
                  fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }
}