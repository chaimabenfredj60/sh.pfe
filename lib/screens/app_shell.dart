import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'offer_list_screen.dart';
import 'personalcalendar_screen.dart';
import 'my_tasks_screen.dart';
import 'news_screen.dart';
import 'events_screen.dart';
import 'my_jackpot_screen.dart';
import 'my_applications_screen.dart';
import 'postes_screen.dart'; // ← AJOUT

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const Color primary = Color(0xFF00B4A6);

  int _page = 0;
  String _activeSubItem = 'Offer List';

  bool _offerExpanded         = false;
  bool _rhExpanded            = false;
  bool _personalExpanded      = false;
  bool _newsExpanded          = false;
  bool _communicationExpanded = false; // ← AJOUT

  void _navigate(int page, {String subItem = ''}) {
    setState(() {
      _page = page;
      if (subItem.isNotEmpty) _activeSubItem = subItem;
      if (page == 1) _offerExpanded = true;
      if ([9, 10, 11, 12].contains(page)) _communicationExpanded = true;
    });
  }

  Widget _buildBody() {
    switch (_page) {
      case 0:  return const DashboardScreen();
      case 1:  return OfferListScreen(activeSubItem: _activeSubItem, onOfferTap: (_) {});
      case 3:  return const PersonalCalendarScreen();
      case 4:  return const MyTasksScreen();
      case 5:  return const NewsScreen();
      case 6:  return const EventsScreen();
      case 7:  return const MyJackpotScreen();
      case 8:  return const MyApplicationsScreen();
      case 9:  return const PostesScreen();   // ← Communication > Postes
      case 10: return const Center(child: Text('Chat'));
      case 11: return const Center(child: Text('My feedbacks'));
      case 12: return const Center(child: Text('My documents / responses'));
      default: return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            _tile(icon: Icons.dashboard, label: 'Dashboard',
                selected: _page == 0, onTap: () => _navigate(0)),

            _tile(icon: Icons.local_offer, label: 'Offer',
                selected: _page == 1, hasArrow: true, arrowDown: _offerExpanded,
                onTap: () => setState(() => _offerExpanded = !_offerExpanded)),
            if (_offerExpanded) ...[
              _subTile('Offer List',
                  selected: _page == 1 && _activeSubItem == 'Offer List',
                  onTap: () => _navigate(1, subItem: 'Offer List')),
              _subTile('My Offers',
                  selected: _page == 1 && _activeSubItem == 'My Offers',
                  onTap: () => _navigate(1, subItem: 'My Offers')),
            ],

            _tile(icon: Icons.people_outline, label: 'RH',
                hasArrow: true, arrowDown: _rhExpanded,
                onTap: () => setState(() => _rhExpanded = !_rhExpanded)),

            _tile(icon: Icons.bookmark_outline, label: 'Personal',
                hasArrow: true, arrowDown: _personalExpanded,
                onTap: () => setState(() => _personalExpanded = !_personalExpanded)),
            if (_personalExpanded) ...[
              _subTile('Personal Calendar', selected: _page == 3,
                  onTap: () => _navigate(3, subItem: 'Personal Calendar')),
              _subTile('My Tasks', selected: _page == 4,
                  onTap: () => _navigate(4, subItem: 'My Tasks')),
            ],

            _tile(icon: Icons.campaign_outlined, label: 'News & Events',
                hasArrow: true, arrowDown: _newsExpanded,
                selected: _page == 5 || _page == 6,
                onTap: () => setState(() => _newsExpanded = !_newsExpanded)),
            if (_newsExpanded) ...[
              _subTile('News', selected: _page == 5,
                  onTap: () => _navigate(5, subItem: 'News')),
              _subTile('Events', selected: _page == 6,
                  onTap: () => _navigate(6, subItem: 'Events')),
            ],

            // COMMUNICATION ← modifié avec sous-items
            _tile(icon: Icons.chat_bubble_outline, label: 'Communication',
                hasArrow: true, arrowDown: _communicationExpanded,
                selected: [9, 10, 11, 12].contains(_page),
                onTap: () => setState(() => _communicationExpanded = !_communicationExpanded)),
            if (_communicationExpanded) ...[
              _subTile('Postes', selected: _page == 9,
                  onTap: () => _navigate(9, subItem: 'Postes')),
              _subTile('Chat', selected: _page == 10,
                  onTap: () => _navigate(10, subItem: 'Chat')),
              _subTile('My feedbacks', selected: _page == 11,
                  onTap: () => _navigate(11, subItem: 'My feedbacks')),
              _subTile('My documents / re...', selected: _page == 12,
                  onTap: () => _navigate(12, subItem: 'My documents')),
            ],

            _tile(icon: Icons.casino_outlined, label: 'My Jackpot',
                selected: _page == 7, onTap: () => _navigate(7)),

            _tile(icon: Icons.edit_note_outlined, label: 'My applications',
                selected: _page == 8, onTap: () => _navigate(8)),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  Widget _tile({
    required IconData icon,
    required String label,
    bool selected  = false,
    bool hasArrow  = false,
    bool arrowDown = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? primary : Colors.transparent,
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Icon(icon, color: selected ? Colors.white : Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontSize: 13)),
          ),
          if (hasArrow)
            Icon(
              arrowDown ? Icons.keyboard_arrow_down : Icons.chevron_right,
              color: selected ? Colors.white : Colors.grey,
              size: 18,
            ),
        ]),
      ),
    );
  }

  Widget _subTile(String label, {bool selected = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 40, top: 10, bottom: 10),
        child: Row(children: [
          Icon(Icons.circle, size: 8, color: selected ? primary : Colors.grey),
          const SizedBox(width: 10),
          Text(label,
              style: TextStyle(
                  color: selected ? primary : Colors.black, fontSize: 13)),
        ]),
      ),
    );
  }
}