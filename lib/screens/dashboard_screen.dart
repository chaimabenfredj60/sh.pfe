// TODO Implement this library.
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const Color primary = Color(0xFF00B4A6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsSection(),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildCongratsBanner()),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: _buildCooptationEvolution()),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildScoringChart()),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: _buildDonutSection()),
              ],
            ),
            const SizedBox(height: 20),
            _buildEvolutionApplicationChart(),
            const SizedBox(height: 20),
            _buildJackpotReport(),
            const SizedBox(height: 20),
            _buildLeaderBoard(),
            const SizedBox(height: 40),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222)),
            ),
            Row(
              children: [
                _buildDropdown('2026'),
                const SizedBox(width: 8),
                _buildDropdown('2026-03'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildSectionLabel('CURRENT MONTH', '2026-3'),
        const SizedBox(height: 8),
        _buildStatCards([
          _StatCard('0,00 €', 'Total CA', Icons.receipt_long_outlined,
              const Color(0xFF00B4A6)),
          _StatCard('0,00 €', 'Reserve', Icons.add_circle_outline,
              const Color(0xFF00B4A6)),
          _StatCard('0,00 €', 'Usable Reserve (CA)', Icons.attach_money,
              const Color(0xFFFF9800)),
          _StatCard('0.00 Days', 'Usable Reserve (in days)', Icons.swap_vert,
              const Color(0xFF9C27B0)),
        ]),
        const SizedBox(height: 12),
        _buildSectionLabel('SINCE ENTRY', null),
        const SizedBox(height: 8),
        _buildStatCards([
          _StatCard('0,00 €', 'CA Since Entry', Icons.inventory_2_outlined,
              const Color(0xFF00B4A6)),
          _StatCard('0,00 €', 'Reserve Since Entry', Icons.inventory_outlined,
              const Color(0xFF00B4A6)),
          _StatCard('0,00 €', 'Usable Reserve Since Entry',
              Icons.inventory_2_outlined, const Color(0xFFFF9800)),
          _StatCard('0.00 Days', 'Usable Reserve Since Entry (in days)',
              Icons.inventory_outlined, const Color(0xFF9C27B0)),
        ]),
      ],
    );
  }

  Widget _buildSectionLabel(String label, String? sub) {
    return Row(
      children: [
        Container(width: 3, height: 16, color: primary),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888),
                letterSpacing: 1)),
        if (sub != null) ...[
          const SizedBox(width: 6),
          Text(sub,
              style: const TextStyle(fontSize: 11, color: Color(0xFFBBBBBB))),
        ],
      ],
    );
  }

  Widget _buildStatCards(List<_StatCard> cards) {
    return Row(
      children: cards
          .map((c) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildStatCardWidget(c),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildStatCardWidget(_StatCard card) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  card.label,
                  style:
                      const TextStyle(fontSize: 11, color: Color(0xFF888888)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: card.iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(card.icon, color: card.iconColor, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value,
              style: const TextStyle(fontSize: 13, color: Color(0xFF555555))),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFFAAAAAA)),
        ],
      ),
    );
  }

  Widget _buildCongratsBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00C9B1), Color(0xFF00B4A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Decorative bunting
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFlag(Colors.purple),
                _buildFlag(Colors.orange),
                _buildFlag(Colors.yellow),
                _buildFlag(Colors.pink),
                _buildFlag(Colors.purple),
                _buildFlag(Colors.orange),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 24),
              const Icon(Icons.emoji_events, color: Colors.white, size: 40),
              const SizedBox(height: 12),
              const Text(
                'Congratulations, BOUGUILA Wissem',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Your cooptation score is 0.00 % as your score to date — keep cooptating to improve it!',
                style: TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlag(Color color) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildCooptationEvolution() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Cooptation Evolution',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222))),
          const Text('Evolution Per Year',
              style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: CustomPaint(
                painter: _DonutPainter(
                  sections: [
                    _DonutSection(const Color(0xFF7C3AED), 1.0),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Accepted',
                        style: TextStyle(
                            color: Colors.purple.shade400,
                            fontWeight: FontWeight.w600)),
                    const Text('0.00%',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xFF888888))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildLegend([
            _LegendItem(Colors.yellow, 'Send'),
            _LegendItem(Colors.red, 'Rejected'),
            _LegendItem(Colors.purple, 'In Progress'),
            _LegendItem(primary, 'Accepted'),
          ]),
        ],
      ),
    );
  }

  Widget _buildLegend(List<_LegendItem> items) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: items.map((item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: item.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(item.label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF888888))),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildScoringChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Scoring Chart',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222))),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(width: 24, height: 10, color: Colors.purple.shade200),
              const SizedBox(width: 6),
              const Text('scoring',
                  style: TextStyle(fontSize: 11, color: Color(0xFF888888))),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: 240,
              height: 200,
              child: CustomPaint(painter: _RadarPainter()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: CustomPaint(
                painter: _DonutPainter(sections: [
                  _DonutSection(const Color(0xFF7C3AED), 1.0),
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Accepted',
                        style: TextStyle(
                            color: Colors.purple.shade400,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                    const Text('0.00%',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF888888))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text('100%',
              style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
          const SizedBox(height: 12),
          _buildLegend([
            _LegendItem(Colors.yellow, 'Send'),
            _LegendItem(Colors.red, 'Rejected'),
            _LegendItem(Colors.purple, 'In Progress'),
            _LegendItem(primary, 'Accepted'),
          ]),
        ],
      ),
    );
  }

  Widget _buildEvolutionApplicationChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Evolution Application',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222))),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _BarChartPainter(
                labels: [
                  '2026-01',
                  '2026-02',
                  '2026-03',
                  '2026-04',
                  '2025-05',
                  '2025-06',
                  '2025-07',
                  '2025-08',
                  '2025-09',
                  '2025-10',
                  '2025-11',
                  '2025-12'
                ],
                maxValue: 30,
              ),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJackpotReport() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Jackpot Report / Month',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222222))),
                  const SizedBox(width: 16),
                  Row(children: [
                    Container(width: 8, height: 8, color: primary),
                    const SizedBox(width: 4),
                    const Text('Earned',
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF888888))),
                    const SizedBox(width: 10),
                    Container(width: 8, height: 8, color: Colors.orange),
                    const SizedBox(width: 4),
                    const Text('Withdrawn',
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF888888))),
                  ]),
                ],
              ),
              _buildDropdown('Month : 2026-04'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 160,
                  child: CustomPaint(
                    painter: _LineChartPainter(
                      labels: ['2026-01', '2026-02', '2026-03', '2026-04'],
                      maxValue: 2.0,
                    ),
                    size: Size.infinite,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Text('0,00 €',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222))),
                    const Text('Withdrawn: 0',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF888888))),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CustomPaint(
                        painter: _DonutPainter(sections: [
                          _DonutSection(const Color(0xFFEEEEEE), 1.0),
                        ]),
                        child: const Center(
                          child: Text('0%',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF888888))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderBoard() {
    final leaders = [
      _Leader('RN', 'Key Account Manager', 'TOP 2', Colors.grey.shade400, 100,
          25, 0),
      _Leader(
          'NTO', 'noc octobre', 'TOP 1', Colors.yellow.shade700, 100, 25, 0),
      _Leader('LB', 'Directeur de projet INFRA', 'TOP 3', Colors.brown.shade300,
          90, 25, 0),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.format_list_bulleted, color: Color(0xFF888888)),
              SizedBox(width: 8),
              Text('Leader Board',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222))),
            ],
          ),
          const Text('Your rank is Top 248',
              style: TextStyle(fontSize: 12, color: Color(0xFFAAAAAA))),
          const SizedBox(height: 24),
          // Leaders row — center is TOP 1 and raised
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildLeaderCard(leaders[0], isTop: false),
              _buildLeaderCard(leaders[1], isTop: true),
              _buildLeaderCard(leaders[2], isTop: false),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: leaders
                .map((l) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          children: [
                            _buildLeaderStat('Efficiency', '${l.efficiency}%'),
                            _buildLeaderStat('Activity', '${l.activity}%'),
                            _buildLeaderStat('Quality', '${l.quality}%'),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderCard(_Leader leader, {required bool isTop}) {
    return Column(
      children: [
        Container(
          width: isTop ? 80 : 70,
          height: isTop ? 80 : 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: leader.ringColor, width: isTop ? 4 : 2),
            color: const Color(0xFFEEEEEE),
          ),
          child: const Icon(Icons.person, color: Color(0xFFBBBBBB), size: 36),
        ),
        const SizedBox(height: 6),
        Text(leader.initials,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF222222))),
        const Icon(Icons.military_tech_outlined,
            size: 14, color: Color(0xFFAAAAAA)),
        Text(leader.title,
            style: const TextStyle(fontSize: 10, color: Color(0xFF888888)),
            textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF00B4A6).withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(leader.rank,
              style: const TextStyle(
                  color: primary, fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildLeaderStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF888888))),
          Text(value,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('COPYRIGHT © 2026 , All rights Reserved',
            style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
        Row(
          children: [
            const Text('Hand-crafted & Made with ',
                style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
            const Icon(Icons.favorite, color: Colors.red, size: 12),
            const Text(' by R.O',
                style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
          ],
        ),
      ],
    );
  }
}

// ─── Data classes ────────────────────────────────────────────────────────────

class _StatCard {
  final String value, label;
  final IconData icon;
  final Color iconColor;
  _StatCard(this.value, this.label, this.icon, this.iconColor);
}

class _DonutSection {
  final Color color;
  final double fraction;
  _DonutSection(this.color, this.fraction);
}

class _LegendItem {
  final Color color;
  final String label;
  _LegendItem(this.color, this.label);
}

class _Leader {
  final String initials, title, rank;
  final Color ringColor;
  final int efficiency, activity, quality;
  _Leader(this.initials, this.title, this.rank, this.ringColor, this.efficiency,
      this.activity, this.quality);
}

// ─── Custom Painters ─────────────────────────────────────────────────────────

class _DonutPainter extends CustomPainter {
  final List<_DonutSection> sections;
  _DonutPainter({required this.sections});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const strokeWidth = 22.0;
    double start = -math.pi / 2;
    for (final s in sections) {
      final sweep = s.fraction * 2 * math.pi;
      final paint = Paint()
        ..color = s.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        start,
        sweep,
        false,
        paint,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _RadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;
    final axes = 4;
    final paint = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw grid rings
    for (int ring = 1; ring <= 4; ring++) {
      final r = radius * ring / 4;
      final path = Path();
      for (int i = 0; i < axes; i++) {
        final angle = i * 2 * math.pi / axes - math.pi / 2;
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0)
          path.moveTo(x, y);
        else
          path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, paint);
    }

    // Axes
    for (int i = 0; i < axes; i++) {
      final angle = i * 2 * math.pi / axes - math.pi / 2;
      canvas.drawLine(
        center,
        Offset(center.dx + radius * math.cos(angle),
            center.dy + radius * math.sin(angle)),
        paint,
      );
    }

    // Labels
    final labels = ['Quality', 'Reactivity', 'Activity', 'Efficiency'];
    final tp = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < axes; i++) {
      final angle = i * 2 * math.pi / axes - math.pi / 2;
      final x = center.dx + (radius + 14) * math.cos(angle);
      final y = center.dy + (radius + 14) * math.sin(angle);
      tp.text = TextSpan(
        text: labels[i],
        style: const TextStyle(fontSize: 10, color: Color(0xFF888888)),
      );
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }

    // Plot point (center-ish)
    final dotPaint = Paint()..color = Colors.red;
    canvas.drawCircle(
        Offset(center.dx, center.dy + radius * 0.15), 5, dotPaint);
    canvas.drawCircle(
        Offset(center.dx, center.dy + radius * 0.35), 5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _BarChartPainter extends CustomPainter {
  final List<String> labels;
  final double maxValue;
  _BarChartPainter({required this.labels, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..strokeWidth = 1;

    final gridRows = 6;
    for (int i = 0; i <= gridRows; i++) {
      final y = size.height * (1 - i / gridRows) * 0.9;
      canvas.drawLine(Offset(40, y), Offset(size.width, y), gridPaint);
    }

    final tp = TextPainter(textDirection: TextDirection.ltr);
    final colW = (size.width - 40) / labels.length;
    for (int i = 0; i < labels.length; i++) {
      tp.text = TextSpan(
        text: labels[i],
        style: const TextStyle(fontSize: 8, color: Color(0xFFAAAAAA)),
      );
      tp.layout();
      tp.paint(canvas,
          Offset(40 + i * colW + colW / 2 - tp.width / 2, size.height - 14));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _LineChartPainter extends CustomPainter {
  final List<String> labels;
  final double maxValue;
  _LineChartPainter({required this.labels, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..strokeWidth = 1;

    for (int i = 0; i <= 5; i++) {
      final y = size.height * (1 - i / 5) * 0.85;
      canvas.drawLine(Offset(30, y), Offset(size.width, y), gridPaint);

      final val = maxValue * i / 5;
      final tp = TextPainter(
        text: TextSpan(
          text: val.toStringAsFixed(1),
          style: const TextStyle(fontSize: 9, color: Color(0xFFAAAAAA)),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    final tp2 = TextPainter(textDirection: TextDirection.ltr);
    final colW = (size.width - 30) / labels.length;
    for (int i = 0; i < labels.length; i++) {
      tp2.text = TextSpan(
        text: labels[i],
        style: const TextStyle(fontSize: 8, color: Color(0xFFAAAAAA)),
      );
      tp2.layout();
      tp2.paint(
          canvas,
          Offset(
            30 + i * colW + colW / 2 - tp2.width / 2,
            size.height - 14,
          ));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
