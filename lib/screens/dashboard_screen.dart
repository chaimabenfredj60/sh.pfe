import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_theme.dart';
import 'dart:math' as math;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ─── Selected date filters ────────────────────────────────────────────────
  String _selectedYear = '2026';
  String _selectedMonth = '2026-01';

  // ─── Mock data per month ─────────────────────────────────────────────────
  final Map<String, Map<String, dynamic>> _mockData = {
    '2026-01': {
      'total_ca': '11.300,00 €',
      'reserve': '1.358,07 €',
      'usable_reserve_ca': '1.188,30 €',
      'usable_reserve_days': '2.10',
      'ca_since_entry': '406.620,00 €',
      'reserve_since_entry': '40.582,93 €',
      'usable_reserve_since_entry': '33.479,24 €',
      'usable_reserve_since_entry_days': '59.26',
    },
    '2026-02': {
      'total_ca': '9.750,00 €',
      'reserve': '1.170,00 €',
      'usable_reserve_ca': '1.023,75 €',
      'usable_reserve_days': '1.85',
      'ca_since_entry': '417.920,00 €',
      'reserve_since_entry': '41.753,00 €',
      'usable_reserve_since_entry': '34.503,00 €',
      'usable_reserve_since_entry_days': '61.11',
    },
    '2026-03': {
      'total_ca': '12.450,00 €',
      'reserve': '1.494,00 €',
      'usable_reserve_ca': '1.307,25 €',
      'usable_reserve_days': '2.36',
      'ca_since_entry': '430.370,00 €',
      'reserve_since_entry': '43.247,00 €',
      'usable_reserve_since_entry': '35.810,25 €',
      'usable_reserve_since_entry_days': '63.47',
    },
    '2026-04': {
      'total_ca': '0,00 €',
      'reserve': '0,00 €',
      'usable_reserve_ca': '0,00 €',
      'usable_reserve_days': '0.00',
      'ca_since_entry': '430.370,00 €',
      'reserve_since_entry': '43.247,00 €',
      'usable_reserve_since_entry': '35.810,25 €',
      'usable_reserve_since_entry_days': '63.47',
    },
    '2025-01': {
      'total_ca': '5.800,00 €',
      'reserve': '696,00 €',
      'usable_reserve_ca': '609,00 €',
      'usable_reserve_days': '1.10',
      'ca_since_entry': '5.800,00 €',
      'reserve_since_entry': '696,00 €',
      'usable_reserve_since_entry': '609,00 €',
      'usable_reserve_since_entry_days': '1.10',
    },
    '2025-02': {
      'total_ca': '6.450,00 €',
      'reserve': '774,00 €',
      'usable_reserve_ca': '677,25 €',
      'usable_reserve_days': '1.22',
      'ca_since_entry': '12.250,00 €',
      'reserve_since_entry': '1.470,00 €',
      'usable_reserve_since_entry': '1.286,25 €',
      'usable_reserve_since_entry_days': '2.32',
    },
    '2025-03': {
      'total_ca': '7.200,00 €',
      'reserve': '864,00 €',
      'usable_reserve_ca': '756,00 €',
      'usable_reserve_days': '1.36',
      'ca_since_entry': '19.450,00 €',
      'reserve_since_entry': '2.334,00 €',
      'usable_reserve_since_entry': '2.042,25 €',
      'usable_reserve_since_entry_days': '3.68',
    },
    '2025-04': {
      'total_ca': '6.900,00 €',
      'reserve': '828,00 €',
      'usable_reserve_ca': '724,50 €',
      'usable_reserve_days': '1.31',
      'ca_since_entry': '26.350,00 €',
      'reserve_since_entry': '3.162,00 €',
      'usable_reserve_since_entry': '2.766,75 €',
      'usable_reserve_since_entry_days': '4.99',
    },
    '2025-05': {
      'total_ca': '8.100,00 €',
      'reserve': '972,00 €',
      'usable_reserve_ca': '850,50 €',
      'usable_reserve_days': '1.53',
      'ca_since_entry': '34.450,00 €',
      'reserve_since_entry': '4.134,00 €',
      'usable_reserve_since_entry': '3.617,25 €',
      'usable_reserve_since_entry_days': '6.52',
    },
    '2025-06': {
      'total_ca': '7.600,00 €',
      'reserve': '912,00 €',
      'usable_reserve_ca': '798,00 €',
      'usable_reserve_days': '1.44',
      'ca_since_entry': '42.050,00 €',
      'reserve_since_entry': '5.046,00 €',
      'usable_reserve_since_entry': '4.415,25 €',
      'usable_reserve_since_entry_days': '7.96',
    },
    '2025-07': {
      'total_ca': '9.300,00 €',
      'reserve': '1.116,00 €',
      'usable_reserve_ca': '976,50 €',
      'usable_reserve_days': '1.76',
      'ca_since_entry': '51.350,00 €',
      'reserve_since_entry': '6.162,00 €',
      'usable_reserve_since_entry': '5.391,75 €',
      'usable_reserve_since_entry_days': '9.72',
    },
    '2025-08': {
      'total_ca': '8.750,00 €',
      'reserve': '1.050,00 €',
      'usable_reserve_ca': '918,75 €',
      'usable_reserve_days': '1.66',
      'ca_since_entry': '60.100,00 €',
      'reserve_since_entry': '7.212,00 €',
      'usable_reserve_since_entry': '6.310,50 €',
      'usable_reserve_since_entry_days': '11.38',
    },
    '2025-09': {
      'total_ca': '9.550,00 €',
      'reserve': '1.146,00 €',
      'usable_reserve_ca': '1.002,75 €',
      'usable_reserve_days': '1.81',
      'ca_since_entry': '69.650,00 €',
      'reserve_since_entry': '8.358,00 €',
      'usable_reserve_since_entry': '7.313,25 €',
      'usable_reserve_since_entry_days': '13.19',
    },
    '2025-10': {
      'total_ca': '8.200,00 €',
      'reserve': '984,00 €',
      'usable_reserve_ca': '861,00 €',
      'usable_reserve_days': '1.55',
      'ca_since_entry': '77.850,00 €',
      'reserve_since_entry': '9.342,00 €',
      'usable_reserve_since_entry': '8.174,25 €',
      'usable_reserve_since_entry_days': '14.74',
    },
    '2025-11': {
      'total_ca': '10.600,00 €',
      'reserve': '1.272,00 €',
      'usable_reserve_ca': '1.113,00 €',
      'usable_reserve_days': '2.01',
      'ca_since_entry': '88.450,00 €',
      'reserve_since_entry': '10.614,00 €',
      'usable_reserve_since_entry': '9.287,25 €',
      'usable_reserve_since_entry_days': '16.75',
    },
    '2025-12': {
      'total_ca': '14.200,00 €',
      'reserve': '1.704,00 €',
      'usable_reserve_ca': '1.491,00 €',
      'usable_reserve_days': '2.69',
      'ca_since_entry': '102.650,00 €',
      'reserve_since_entry': '12.318,00 €',
      'usable_reserve_since_entry': '10.778,25 €',
      'usable_reserve_since_entry_days': '19.44',
    },
  };

  final List<String> _years = ['2025', '2026'];
  final Map<String, List<String>> _monthsByYear = {
    '2025': [
      '2025-01',
      '2025-02',
      '2025-03',
      '2025-04',
      '2025-05',
      '2025-06',
      '2025-07',
      '2025-08',
      '2025-09',
      '2025-10',
      '2025-11',
      '2025-12'
    ],
    '2026': [
      '2026-01',
      '2026-02',
      '2026-03',
      '2026-04',
      '2026-05',
      '2026-06',
      '2026-07',
      '2026-08',
      '2026-09',
      '2026-10',
      '2026-11',
      '2026-12'
    ],
  };

  Map<String, dynamic> get _currentData =>
      _mockData[_selectedMonth] ?? _mockData['2026-01']!;

  void _onYearChanged(String? year) {
    if (year == null) return;
    setState(() {
      _selectedYear = year;
      final months = _monthsByYear[year] ?? [];
      if (months.isNotEmpty) _selectedMonth = months.first;
    });
  }

  void _onMonthChanged(String? month) {
    if (month == null) return;
    setState(() => _selectedMonth = month);
  }

  // ─── Responsive helpers ───────────────────────────────────────────────────
  bool _isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= 700;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatsSection(context, appTheme),
              const SizedBox(height: 20),
              _buildCongratsAndCooptation(context, appTheme),
              const SizedBox(height: 20),
              _buildScoringAndDonut(context, appTheme),
              const SizedBox(height: 20),
              _buildEvolutionApplicationChart(appTheme),
              const SizedBox(height: 20),
              _buildJackpotReport(context, appTheme),
              const SizedBox(height: 20),
              _buildLeaderBoard(context, appTheme),
              const SizedBox(height: 40),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Stats Section ────────────────────────────────────────────────────────
  Widget _buildStatsSection(BuildContext context, AppTheme appTheme) {
    final data = _currentData;
    final isWide = _isWide(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appTheme.translate('statistics'),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222)),
            ),
            Row(children: [
              _buildYearDropdown(),
              const SizedBox(width: 8),
              _buildMonthDropdown(),
            ]),
          ],
        ),
        const SizedBox(height: 12),
        _buildSectionLabel(appTheme.translate('current_month'), _selectedMonth),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
                      .animate(animation),
              child: child,
            ),
          ),
          child: _buildStatCardsResponsive(
            context: context,
            key: ValueKey(_selectedMonth + '_current'),
            cards: [
              _StatCard(data['total_ca']!, appTheme.translate('total_ca'),
                  Icons.receipt_long_outlined, const Color(0xFF00B4A6)),
              _StatCard(data['reserve']!, appTheme.translate('reserve'),
                  Icons.add_circle_outline, const Color(0xFF00B4A6)),
              _StatCard(
                  data['usable_reserve_ca']!,
                  appTheme.translate('usable_reserve_ca'),
                  Icons.attach_money,
                  const Color(0xFFFF9800)),
              _StatCard(
                  '${data['usable_reserve_days']!} ${appTheme.translate('days')}',
                  appTheme.translate('usable_reserve_days'),
                  Icons.swap_vert,
                  const Color(0xFF9C27B0)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildSectionLabel(appTheme.translate('since_entry'), null),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
                      .animate(animation),
              child: child,
            ),
          ),
          child: _buildStatCardsResponsive(
            context: context,
            key: ValueKey(_selectedMonth + '_since'),
            cards: [
              _StatCard(
                  data['ca_since_entry']!,
                  appTheme.translate('ca_since_entry'),
                  Icons.inventory_2_outlined,
                  const Color(0xFF00B4A6)),
              _StatCard(
                  data['reserve_since_entry']!,
                  appTheme.translate('reserve_since_entry'),
                  Icons.inventory_outlined,
                  const Color(0xFF00B4A6)),
              _StatCard(
                  data['usable_reserve_since_entry']!,
                  appTheme.translate('usable_reserve_since_entry'),
                  Icons.inventory_2_outlined,
                  const Color(0xFFFF9800)),
              _StatCard(
                  '${data['usable_reserve_since_entry_days']!} ${appTheme.translate('days')}',
                  appTheme.translate('usable_reserve_since_entry_days'),
                  Icons.inventory_outlined,
                  const Color(0xFF9C27B0)),
            ],
          ),
        ),
      ],
    );
  }

  /// Renders stat cards in a 2x2 grid on mobile, 4-in-a-row on desktop
  Widget _buildStatCardsResponsive(
      {Key? key,
      required BuildContext context,
      required List<_StatCard> cards}) {
    final isWide = _isWide(context);
    if (isWide) {
      return Row(
        key: key,
        children: cards
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildStatCardWidget(c),
                  ),
                ))
            .toList(),
      );
    } else {
      // 2x2 grid on mobile
      return Column(
        key: key,
        children: [
          Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 6, bottom: 8),
                    child: _buildStatCardWidget(cards[0]))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 2, bottom: 8),
                    child: _buildStatCardWidget(cards[1]))),
          ]),
          Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: _buildStatCardWidget(cards[2]))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: _buildStatCardWidget(cards[3]))),
          ]),
        ],
      );
    }
  }

  // ─── Congrats + Cooptation Evolution ─────────────────────────────────────
  Widget _buildCongratsAndCooptation(BuildContext context, AppTheme appTheme) {
    final isWide = _isWide(context);
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildCongratsBanner(appTheme)),
          const SizedBox(width: 16),
          Expanded(flex: 2, child: _buildCooptationEvolution(appTheme)),
        ],
      );
    }
    return Column(children: [
      _buildCongratsBanner(appTheme),
      const SizedBox(height: 16),
      _buildCooptationEvolution(appTheme),
    ]);
  }

  // ─── Scoring + Donut ──────────────────────────────────────────────────────
  Widget _buildScoringAndDonut(BuildContext context, AppTheme appTheme) {
    final isWide = _isWide(context);
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildScoringChart(appTheme)),
          const SizedBox(width: 16),
          Expanded(flex: 2, child: _buildDonutSection(appTheme)),
        ],
      );
    }
    return Column(children: [
      _buildScoringChart(appTheme),
      const SizedBox(height: 16),
      _buildDonutSection(appTheme),
    ]);
  }

  // ─── Year Dropdown ────────────────────────────────────────────────────────
  Widget _buildYearDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedYear,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFFAAAAAA)),
          style: const TextStyle(fontSize: 13, color: Color(0xFF555555)),
          items: _years
              .map((y) => DropdownMenuItem(value: y, child: Text(y)))
              .toList(),
          onChanged: _onYearChanged,
        ),
      ),
    );
  }

  // ─── Month Dropdown ───────────────────────────────────────────────────────
  Widget _buildMonthDropdown() {
    final months = _monthsByYear[_selectedYear] ?? [];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF00B4A6)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedMonth,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFF00B4A6)),
          style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF00B4A6),
              fontWeight: FontWeight.w600),
          items: months
              .map((m) => DropdownMenuItem(value: m, child: Text(m)))
              .toList(),
          onChanged: _onMonthChanged,
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, String? sub) {
    return Row(
      children: [
        Container(width: 3, height: 16, color: const Color(0xFF00B4A6)),
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

  Widget _buildStatCardWidget(_StatCard card) {
    return Container(
      padding: const EdgeInsets.all(14),
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  card.label,
                  style:
                      const TextStyle(fontSize: 10, color: Color(0xFF888888)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: card.iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(card.icon, color: card.iconColor, size: 17),
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

  Widget _buildCongratsBanner(AppTheme appTheme) {
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
              Text(
                '${appTheme.translate('congratulations')}, BOUGUILA Wissem',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${appTheme.translate('your_rank')} 0.00 %',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
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

  Widget _buildCooptationEvolution(AppTheme appTheme) {
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
          Text(appTheme.translate('my_cooptation_evolution'),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222))),
          Text(appTheme.translate('evolution_per_year'),
              style: const TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: CustomPaint(
                painter: _DonutPainter(
                    sections: [_DonutSection(const Color(0xFF7C3AED), 1.0)]),
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
            _LegendItem(const Color(0xFF00B4A6), 'Accepted'),
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
              decoration:
                  BoxDecoration(color: item.color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text(item.label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF888888))),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildScoringChart(AppTheme appTheme) {
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
          Text(appTheme.translate('scoring_chart'),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222))),
          const SizedBox(height: 8),
          Row(children: [
            Container(width: 24, height: 10, color: Colors.purple.shade200),
            const SizedBox(width: 6),
            const Text('scoring',
                style: TextStyle(fontSize: 11, color: Color(0xFF888888))),
          ]),
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

  Widget _buildDonutSection(AppTheme appTheme) {
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
            _LegendItem(const Color(0xFF00B4A6), 'Accepted'),
          ]),
        ],
      ),
    );
  }

  Widget _buildEvolutionApplicationChart(AppTheme appTheme) {
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
          Text(appTheme.translate('evolution_application'),
              style: const TextStyle(
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

  // ─── Jackpot Report ───────────────────────────────────────────────────────
  Widget _buildJackpotReport(BuildContext context, AppTheme appTheme) {
    final isWide = _isWide(context);
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
          // Header row — wraps on mobile
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(appTheme.translate('jackpot_report'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222))),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 8, height: 8, color: const Color(0xFF00B4A6)),
                const SizedBox(width: 4),
                Text(appTheme.translate('earned'),
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF888888))),
                const SizedBox(width: 10),
                Container(width: 8, height: 8, color: Colors.orange),
                const SizedBox(width: 4),
                Text(appTheme.translate('withdrawn'),
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF888888))),
              ]),
              _buildDropdown('Month : 2026-04'),
            ],
          ),
          const SizedBox(height: 16),
          if (isWide)
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
                _buildJackpotSummary(),
              ],
            )
          else
            Column(
              children: [
                SizedBox(
                  height: 160,
                  child: CustomPaint(
                    painter: _LineChartPainter(
                      labels: ['2026-01', '2026-02', '2026-03', '2026-04'],
                      maxValue: 2.0,
                    ),
                    size: Size.infinite,
                  ),
                ),
                const SizedBox(height: 16),
                _buildJackpotSummary(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildJackpotSummary() {
    return Column(
      children: [
        const Text('0,00 €',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222))),
        const Text('Withdrawn: 0',
            style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
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
    );
  }

  // ─── Leader Board ─────────────────────────────────────────────────────────
  Widget _buildLeaderBoard(BuildContext context, AppTheme appTheme) {
    final isWide = _isWide(context);
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
          if (isWide) ...[
            // Desktop: side-by-side podium
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
            Row(
              children: leaders
                  .map((l) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(children: [
                            _buildLeaderStat('Efficiency', '${l.efficiency}%'),
                            _buildLeaderStat('Activity', '${l.activity}%'),
                            _buildLeaderStat('Quality', '${l.quality}%'),
                          ]),
                        ),
                      ))
                  .toList(),
            ),
          ] else ...[
            // Mobile: stacked cards (TOP 1 first, then 2, then 3)
            _buildMobileLeaderCard(leaders[1]),
            const Divider(height: 24),
            _buildMobileLeaderCard(leaders[0]),
            const Divider(height: 24),
            _buildMobileLeaderCard(leaders[2]),
          ],
        ],
      ),
    );
  }

  /// Mobile-friendly leader card (avatar + info + stats stacked vertically)
  Widget _buildMobileLeaderCard(_Leader leader) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: leader.ringColor, width: 3),
            color: const Color(0xFFEEEEEE),
          ),
          child: const Icon(Icons.person, color: Color(0xFFBBBBBB), size: 36),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(leader.initials,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                    fontSize: 15)),
            const SizedBox(width: 4),
            const Icon(Icons.military_tech_outlined,
                size: 14, color: Color(0xFFAAAAAA)),
          ],
        ),
        Text(leader.title,
            style: const TextStyle(fontSize: 11, color: Color(0xFF888888)),
            textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF00B4A6).withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(leader.rank,
              style: const TextStyle(
                  color: Color(0xFF00B4A6),
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMobileStat('Efficiency', '${leader.efficiency}%'),
            _buildMobileStat('Activity', '${leader.activity}%'),
            _buildMobileStat('Quality', '${leader.quality}%'),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileStat(String label, String value) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF888888))),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
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
                  color: Color(0xFF00B4A6),
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
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

  Widget _buildFooter(BuildContext context) {
    final isWide = _isWide(context);
    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('COPYRIGHT © 2026 , All rights Reserved',
              style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
          Row(children: const [
            Text('Hand-crafted & Made with ',
                style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
            Icon(Icons.favorite, color: Colors.red, size: 12),
            Text(' by R.O',
                style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
          ]),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('COPYRIGHT © 2026 , All rights Reserved',
            style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA)),
            textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text('Hand-crafted & Made with ',
              style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
          Icon(Icons.favorite, color: Colors.red, size: 12),
          Text(' by R.O',
              style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
        ]),
      ],
    );
  }
}

// ─── Data classes ─────────────────────────────────────────────────────────────

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

// ─── Custom Painters ──────────────────────────────────────────────────────────

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
    const axes = 4;
    final paint = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

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

    for (int i = 0; i < axes; i++) {
      final angle = i * 2 * math.pi / axes - math.pi / 2;
      canvas.drawLine(
        center,
        Offset(center.dx + radius * math.cos(angle),
            center.dy + radius * math.sin(angle)),
        paint,
      );
    }

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

    const gridRows = 6;
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
