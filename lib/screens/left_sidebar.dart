import 'package:flutter/material.dart';

class SidebarNavItem {
  final IconData icon;
  final String label;
  final bool hasChildren;
  final bool isActive;

  const SidebarNavItem({
    required this.icon,
    required this.label,
    this.hasChildren = false,
    this.isActive = false,
  });
}

class LeftSidebar extends StatefulWidget {
  final String activeRoute;
  final ValueChanged<String> onRouteChanged;

  const LeftSidebar({
    super.key,
    required this.activeRoute,
    required this.onRouteChanged,
  });

  @override
  State<LeftSidebar> createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {
  bool _personalExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Logo ────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00B4A6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.people_alt, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Cooptalite',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Icon(Icons.add_circle_outline,
                    color: const Color(0xFF00B4A6), size: 18),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 8),

          // ── Nav items ───────────────────────────────────────────────────
          _navItem(
            icon: Icons.bar_chart_rounded,
            label: 'Analytics',
            route: 'analytics',
          ),
          _navItem(
            icon: Icons.local_offer_outlined,
            label: 'Offer',
            route: 'offer',
            hasArrow: true,
          ),
          _navItem(
            icon: Icons.people_outline,
            label: 'My Cooptation Tr...',
            route: 'cooptation',
          ),
          _navItem(
            icon: Icons.emoji_events_outlined,
            label: 'My Challenge',
            route: 'challenge',
          ),
          _navItem(
            icon: Icons.folder_outlined,
            label: 'RH',
            route: 'rh',
            hasArrow: true,
          ),

          const SizedBox(height: 4),

          // ── Personal section ─────────────────────────────────────────────
          _sectionHeader(
            icon: Icons.edit_outlined,
            label: 'Personal',
            expanded: _personalExpanded,
            onTap: () => setState(() => _personalExpanded = !_personalExpanded),
          ),

          if (_personalExpanded) ...[
            _subNavItem(
              icon: Icons.calendar_today_outlined,
              label: 'Personal Calendar',
              route: 'calendar',
            ),
            _subNavItem(
              icon: Icons.check_box_outlined,
              label: 'My Tasks',
              route: 'tasks',
            ),
            _subNavItem(
              icon: Icons.leaderboard_outlined,
              label: 'My Results Acco...',
              route: 'results',
            ),
            _subNavItem(
              icon: Icons.rss_feed_outlined,
              label: 'News & Events',
              route: 'news',
              hasArrow: true,
            ),
            _subNavItem(
              icon: Icons.chat_bubble_outline,
              label: 'Communication',
              route: 'communication',
              hasArrow: true,
            ),
            _subNavItem(
              icon: Icons.card_giftcard_outlined,
              label: 'My Jackpot',
              route: 'jackpot',
            ),
            _subNavItem(
              icon: Icons.assignment_outlined,
              label: 'My applications',
              route: 'applications',
            ),
          ],

          const Spacer(),

          // ── Bottom logo ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B4A6), Color(0xFF80CBC4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.bolt, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required String route,
    bool hasArrow = false,
  }) {
    final isActive = widget.activeRoute == route;
    return InkWell(
      onTap: () => widget.onRouteChanged(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE6F9F7) : Colors.transparent,
          border: isActive
              ? const Border(
                  left: BorderSide(color: Color(0xFF00B4A6), width: 3))
              : null,
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 18,
                color: isActive
                    ? const Color(0xFF00B4A6)
                    : const Color(0xFF9E9E9E)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive
                      ? const Color(0xFF00B4A6)
                      : const Color(0xFF555555),
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (hasArrow)
              Icon(Icons.chevron_right,
                  size: 16, color: const Color(0xFFBDBDBD)),
          ],
        ),
      ),
    );
  }

  Widget _subNavItem({
    required IconData icon,
    required String label,
    required String route,
    bool hasArrow = false,
  }) {
    final isActive = widget.activeRoute == route;
    return InkWell(
      onTap: () => widget.onRouteChanged(route),
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 9, 16, 9),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF00B4A6) : Colors.transparent,
          borderRadius: isActive ? BorderRadius.circular(6) : null,
        ),
        margin: isActive
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 1)
            : EdgeInsets.zero,
        child: Row(
          children: [
            Icon(icon,
                size: 16,
                color: isActive ? Colors.white : const Color(0xFF9E9E9E)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive ? Colors.white : const Color(0xFF555555),
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (hasArrow)
              Icon(Icons.chevron_right,
                  size: 16,
                  color:
                      isActive ? Colors.white70 : const Color(0xFFBDBDBD)),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader({
    required IconData icon,
    required String label,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF9E9E9E)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF555555),
                ),
              ),
            ),
            Icon(
              expanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
              size: 16,
              color: const Color(0xFFBDBDBD),
            ),
          ],
        ),
      ),
    );
  }
}