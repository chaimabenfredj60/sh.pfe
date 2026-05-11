import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/responsive.dart';
import '../utils/responsive_utils.dart';
import '../providers/app_theme.dart';
import '../widgets/top_bar.dart';
import 'dashboard_screen.dart';
import 'offer_list_screen.dart';
import 'personalcalendar_screen.dart';
import 'my_tasks_screen.dart';
import 'news_screen.dart';
import 'events_screen.dart';
import 'my_jackpot_screen.dart';
import 'CRA_screen.dart';
import 'my_cra_tracking_screen.dart';
import 'my_expenses_screen.dart';
import 'postes_screen.dart';
import 'chat_screen.dart';
import 'my_feedbacks_screen.dart';
import 'my_documents_screen.dart';
import 'my_applications_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'cv_list_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const Color primary = Color(0xFF00B4A6);
  static const Color _sidebarBg = Color(0xFFF8FAFC);
  static const Color _sidebarBorder = Color(0xFFE8EDF2);

  static const Map<String, Color> _sectionColors = {
    'dashboard': Color(0xFF2196F3),
    'offer': Color(0xFFFF9800),
    'rh': Color(0xFF4CAF50),
    'personal': Color(0xFF9C27B0),
    'news': Color(0xFFFF5722),
    'communication': Color(0xFF00B4A6),
    'jackpot': Color(0xFFFFC107),
    'applications': Color(0xFFE91E63),
  };

  int _page = 0;
  String _activeSubItem = 'Offer List';

  bool _offerExpanded = false;
  bool _rhExpanded = false;
  bool _personalExpanded = false;
  bool _newsExpanded = false;
  bool _commExpanded = false;

  void _navigate(int page, {String subItem = ''}) {
    setState(() {
      _page = page;
      if (subItem.isNotEmpty) _activeSubItem = subItem;
      if (page == 1) _offerExpanded = true;
    });
  }

  void _onProfileTap() => _navigate(15);
  void _onApplicationTap() => _navigate(10);
  void _onCvTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CvListScreen(userId: 'user123'),
      ),
    );
  }

  void _onLanguageChanged(String lang) {
    context.read<AppTheme>().setLanguage(lang);
  }

  void _onLogout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Widget _buildTopBar(AppTheme appTheme) {
    return TopBar(
      onProfile: _onProfileTap,
      onApplication: _onApplicationTap,
      onJackpot: () => _navigate(9),
      onChats: () => _navigate(12),
      onCv: _onCvTap,
      onSupport: () {},
      onLogout: _onLogout,
      onLanguageChanged: _onLanguageChanged,
      currentLanguage: appTheme.language,
    );
  }

  Widget _buildBody(AppTheme appTheme) {
    Widget body;
    switch (_page) {
      case 0:
        body = const DashboardScreen();
      case 1:
        body =
            OfferListScreen(activeSubItem: _activeSubItem, onOfferTap: (_) {});
      case 2:
        body = const CraScreen();
      case 3:
        body = const MyCraTrackingScreen();
      case 4:
        body = const MyExpensesScreen();
      case 5:
        body = const PersonalCalendarScreen();
      case 6:
        body = const MyTasksScreen();
      case 7:
        body = const NewsScreen();
      case 8:
        body = const EventsScreen();
      case 9:
        body = const MyJackpotScreen();
      case 10:
        body = const MyApplicationsScreen();
      case 11:
        body = const PostesScreen();
      case 12:
        body = const ChatScreen();
      case 13:
        body = const MyFeedbacksScreen();
      case 14:
        body = const MyDocumentsScreen();
      case 15:
        body = const ProfileScreen();
      default:
        body = const DashboardScreen();
    }
    return Consumer<AppTheme>(
      builder: (context, theme, _) => body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) {
        if (Responsive.isMobile(context)) {
          return _buildMobileLayout(context, appTheme);
        } else if (Responsive.isTablet(context)) {
          return _buildTabletLayout(context, appTheme);
        } else {
          return _buildDesktopLayout(context, appTheme);
        }
      },
    );
  }

  // ── Layouts ───────────────────────────────────────────────────────────────

  Widget _buildMobileLayout(BuildContext context, AppTheme appTheme) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          _buildTopBar(appTheme),
          Expanded(
            child:
                _wrapBodyWithResponsivePadding(context, _buildBody(appTheme)),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, AppTheme appTheme) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(appTheme),
          Expanded(
            child: Row(children: [
              SizedBox(width: 72, child: _buildCompactSidebar()),
              Expanded(
                child: _wrapBodyWithResponsivePadding(
                    context, _buildBody(appTheme)),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AppTheme appTheme) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(appTheme),
          Expanded(
            child: Row(children: [
              SizedBox(width: 250, child: _buildSidebar(appTheme)),
              Expanded(
                child: _wrapBodyWithResponsivePadding(
                    context, _buildBody(appTheme)),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // ── Mobile Drawer ─────────────────────────────────────────────────────────

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: _sidebarBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: _sidebarBorder),
              ),
            ),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primary, primary.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.bolt, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'Cooptalite',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]),
          ),
          _tile(
              icon: Icons.dashboard_rounded,
              label: 'Dashboard',
              sectionKey: 'dashboard',
              selected: _page == 0,
              onTap: () => {_navigate(0), Navigator.pop(context)}),
          _tile(
              icon: Icons.local_offer_rounded,
              label: 'Offer',
              sectionKey: 'offer',
              selected: _page == 1,
              hasArrow: true,
              arrowDown: _offerExpanded,
              onTap: () => setState(() => _offerExpanded = !_offerExpanded)),
          if (_offerExpanded) ...[
            _sub('Offer List',
                sel: _page == 1 && _activeSubItem == 'Offer List',
                onTap: () => {
                      _navigate(1, subItem: 'Offer List'),
                      Navigator.pop(context)
                    }),
            _sub('My Offers',
                sel: _page == 1 && _activeSubItem == 'My Offers',
                onTap: () => {
                      _navigate(1, subItem: 'My Offers'),
                      Navigator.pop(context)
                    }),
          ],
          _tile(
              icon: Icons.people_rounded,
              label: 'RH',
              sectionKey: 'rh',
              hasArrow: true,
              arrowDown: _rhExpanded,
              selected: [2, 3, 4].contains(_page),
              onTap: () => setState(() => _rhExpanded = !_rhExpanded)),
          if (_rhExpanded) ...[
            _sub('CRA',
                sel: _page == 2,
                onTap: () =>
                    {_navigate(2, subItem: 'CRA'), Navigator.pop(context)}),
            _sub('My CRA Tracking',
                sel: _page == 3,
                onTap: () => {
                      _navigate(3, subItem: 'My CRA Tracking'),
                      Navigator.pop(context)
                    }),
            _sub('My Expenses',
                sel: _page == 4,
                onTap: () => {
                      _navigate(4, subItem: 'My Expenses'),
                      Navigator.pop(context)
                    }),
          ],
          _tile(
              icon: Icons.bookmark_rounded,
              label: 'Personal',
              sectionKey: 'personal',
              hasArrow: true,
              arrowDown: _personalExpanded,
              selected: [5, 6].contains(_page),
              onTap: () =>
                  setState(() => _personalExpanded = !_personalExpanded)),
          if (_personalExpanded) ...[
            _sub('Personal Calendar',
                sel: _page == 5,
                onTap: () => {
                      _navigate(5, subItem: 'Personal Calendar'),
                      Navigator.pop(context)
                    }),
            _sub('My Tasks',
                sel: _page == 6,
                onTap: () => {
                      _navigate(6, subItem: 'My Tasks'),
                      Navigator.pop(context)
                    }),
          ],
          _tile(
              icon: Icons.campaign_rounded,
              label: 'News & Events',
              sectionKey: 'news',
              hasArrow: true,
              arrowDown: _newsExpanded,
              selected: [7, 8].contains(_page),
              onTap: () => setState(() => _newsExpanded = !_newsExpanded)),
          if (_newsExpanded) ...[
            _sub('News',
                sel: _page == 7,
                onTap: () =>
                    {_navigate(7, subItem: 'News'), Navigator.pop(context)}),
            _sub('Events',
                sel: _page == 8,
                onTap: () =>
                    {_navigate(8, subItem: 'Events'), Navigator.pop(context)}),
          ],
          _tile(
              icon: Icons.casino_rounded,
              label: 'My Jackpot',
              sectionKey: 'jackpot',
              selected: _page == 9,
              onTap: () => {_navigate(9), Navigator.pop(context)}),
          _tile(
              icon: Icons.edit_note_rounded,
              label: 'My Applications',
              sectionKey: 'applications',
              selected: _page == 10,
              onTap: () => {_navigate(10), Navigator.pop(context)}),
          _tile(
              icon: Icons.chat_bubble_rounded,
              label: 'Communication',
              sectionKey: 'communication',
              hasArrow: true,
              arrowDown: _commExpanded,
              selected: [11, 12, 13, 14].contains(_page),
              onTap: () => setState(() => _commExpanded = !_commExpanded)),
          if (_commExpanded) ...[
            _sub('Postes',
                sel: _page == 11,
                onTap: () =>
                    {_navigate(11, subItem: 'Postes'), Navigator.pop(context)}),
            _sub('Chat',
                sel: _page == 12,
                onTap: () =>
                    {_navigate(12, subItem: 'Chat'), Navigator.pop(context)}),
            _sub('My Feedbacks',
                sel: _page == 13,
                onTap: () => {
                      _navigate(13, subItem: 'My Feedbacks'),
                      Navigator.pop(context)
                    }),
            _sub('My Documents',
                sel: _page == 14,
                onTap: () => {
                      _navigate(14, subItem: 'My Documents'),
                      Navigator.pop(context)
                    }),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Compact Sidebar (Tablet) ───────────────────────────────────────────────

  Widget _buildCompactSidebar() {
    return Container(
      decoration: BoxDecoration(
        color: _sidebarBg,
        border: Border(right: BorderSide(color: _sidebarBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 16),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.bolt, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 16),
          _compactTile(
              icon: Icons.dashboard_rounded,
              sectionKey: 'dashboard',
              selected: _page == 0,
              onTap: () => _navigate(0)),
          _compactTile(
              icon: Icons.local_offer_rounded,
              sectionKey: 'offer',
              selected: _page == 1,
              onTap: () => _navigate(1)),
          _compactTile(
              icon: Icons.people_rounded,
              sectionKey: 'rh',
              selected: [2, 3, 4].contains(_page),
              onTap: () => _navigate(2)),
          _compactTile(
              icon: Icons.bookmark_rounded,
              sectionKey: 'personal',
              selected: [5, 6].contains(_page),
              onTap: () => _navigate(5)),
          _compactTile(
              icon: Icons.campaign_rounded,
              sectionKey: 'news',
              selected: [7, 8].contains(_page),
              onTap: () => _navigate(7)),
          _compactTile(
              icon: Icons.casino_rounded,
              sectionKey: 'jackpot',
              selected: _page == 9,
              onTap: () => _navigate(9)),
          _compactTile(
              icon: Icons.edit_note_rounded,
              sectionKey: 'applications',
              selected: _page == 10,
              onTap: () => _navigate(10)),
          _compactTile(
              icon: Icons.chat_bubble_rounded,
              sectionKey: 'communication',
              selected: [11, 12, 13, 14].contains(_page),
              onTap: () => _navigate(11)),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  // ── Full Sidebar (Desktop) ────────────────────────────────────────────────

  Widget _buildSidebar(AppTheme appTheme) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: _sidebarBg,
        border: Border(right: BorderSide(color: _sidebarBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          // Brand header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: _sidebarBorder)),
            ),
            child: Row(children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primary, primary.withOpacity(0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.bolt, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                'Cooptalite',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ]),
          ),

          const SizedBox(height: 10),

          _tile(
              appTheme: appTheme,
              icon: Icons.dashboard_rounded,
              label: appTheme.translate('dashboard'),
              sectionKey: 'dashboard',
              selected: _page == 0,
              onTap: () => _navigate(0)),
          _tile(
              appTheme: appTheme,
              icon: Icons.local_offer_rounded,
              label: appTheme.translate('offer'),
              sectionKey: 'offer',
              selected: _page == 1,
              hasArrow: true,
              arrowDown: _offerExpanded,
              onTap: () => setState(() => _offerExpanded = !_offerExpanded)),
          if (_offerExpanded) ...[
            _sub('Offer List',
                sel: _page == 1 && _activeSubItem == 'Offer List',
                onTap: () => _navigate(1, subItem: 'Offer List')),
            _sub('My Offers',
                sel: _page == 1 && _activeSubItem == 'My Offers',
                onTap: () => _navigate(1, subItem: 'My Offers')),
          ],
          _tile(
              appTheme: appTheme,
              icon: Icons.people_rounded,
              label: appTheme.translate('rh'),
              sectionKey: 'rh',
              hasArrow: true,
              arrowDown: _rhExpanded,
              selected: [2, 3, 4].contains(_page),
              onTap: () => setState(() => _rhExpanded = !_rhExpanded)),
          if (_rhExpanded) ...[
            _sub('CRA',
                sel: _page == 2, onTap: () => _navigate(2, subItem: 'CRA')),
            _sub('My CRA Tracking',
                sel: _page == 3,
                onTap: () => _navigate(3, subItem: 'My CRA Tracking')),
            _sub('My Expenses',
                sel: _page == 4,
                onTap: () => _navigate(4, subItem: 'My Expenses')),
          ],
          _tile(
              appTheme: appTheme,
              icon: Icons.bookmark_rounded,
              label: appTheme.translate('personal'),
              sectionKey: 'personal',
              hasArrow: true,
              arrowDown: _personalExpanded,
              selected: [5, 6].contains(_page),
              onTap: () =>
                  setState(() => _personalExpanded = !_personalExpanded)),
          if (_personalExpanded) ...[
            _sub('Personal Calendar',
                sel: _page == 5,
                onTap: () => _navigate(5, subItem: 'Personal Calendar')),
            _sub('My Tasks',
                sel: _page == 6,
                onTap: () => _navigate(6, subItem: 'My Tasks')),
          ],
          _tile(
              appTheme: appTheme,
              icon: Icons.campaign_rounded,
              label: appTheme.translate('news'),
              sectionKey: 'news',
              hasArrow: true,
              arrowDown: _newsExpanded,
              selected: [7, 8].contains(_page),
              onTap: () => setState(() => _newsExpanded = !_newsExpanded)),
          if (_newsExpanded) ...[
            _sub('News',
                sel: _page == 7, onTap: () => _navigate(7, subItem: 'News')),
            _sub('Events',
                sel: _page == 8, onTap: () => _navigate(8, subItem: 'Events')),
          ],
          _tile(
              appTheme: appTheme,
              icon: Icons.chat_bubble_rounded,
              label: appTheme.translate('communication'),
              sectionKey: 'communication',
              hasArrow: true,
              arrowDown: _commExpanded,
              selected: [11, 12, 13, 14].contains(_page),
              onTap: () => setState(() => _commExpanded = !_commExpanded)),
          if (_commExpanded) ...[
            _sub('Postes',
                sel: _page == 11,
                onTap: () => _navigate(11, subItem: 'Postes')),
            _sub('Chat',
                sel: _page == 12, onTap: () => _navigate(12, subItem: 'Chat')),
            _sub('My Feedbacks',
                sel: _page == 13,
                onTap: () => _navigate(13, subItem: 'My feedbacks')),
            _sub('My Documents',
                sel: _page == 14,
                onTap: () => _navigate(14, subItem: 'My documents')),
          ],
          _tile(
              appTheme: appTheme,
              icon: Icons.casino_rounded,
              label: appTheme.translate('jackpot'),
              sectionKey: 'jackpot',
              selected: _page == 9,
              onTap: () => _navigate(9)),
          _tile(
              appTheme: appTheme,
              icon: Icons.edit_note_rounded,
              label: appTheme.translate('applications'),
              sectionKey: 'applications',
              selected: _page == 10,
              onTap: () => _navigate(10)),

          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  // ── Responsive padding ────────────────────────────────────────────────────

  Widget _wrapBodyWithResponsivePadding(BuildContext context, Widget body) {
    final horizontalPadding = ResponsiveUtils.getHorizontalPadding(context);
    final verticalPadding = ResponsiveUtils.getVerticalPadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: body,
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _tile({
    required IconData icon,
    required String label,
    String sectionKey = 'dashboard',
    AppTheme? appTheme,
    bool selected = false,
    bool hasArrow = false,
    bool arrowDown = false,
    VoidCallback? onTap,
  }) {
    final iconColor = _sectionColors[sectionKey] ?? primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? iconColor.withOpacity(0.08) : Colors.transparent,
          border: selected
              ? Border.all(color: iconColor.withOpacity(0.25), width: 1)
              : Border.all(color: Colors.transparent, width: 1),
        ),
        child: Row(children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(selected ? 0.18 : 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected ? iconColor : Colors.grey[700],
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.1,
              ),
            ),
          ),
          if (hasArrow)
            Icon(
              arrowDown
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.chevron_right_rounded,
              color: selected ? iconColor : Colors.grey[400],
              size: 18,
            ),
        ]),
      ),
    );
  }

  Widget _sub(String label, {bool sel = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 12, top: 2, bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: sel ? primary.withOpacity(0.07) : Colors.transparent,
        ),
        child: Row(children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: sel ? primary : Colors.grey[350],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: sel ? primary : Colors.grey[600],
                fontSize: 12.5,
                fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _compactTile({
    required IconData icon,
    String sectionKey = 'dashboard',
    bool selected = false,
    VoidCallback? onTap,
  }) {
    final iconColor = _sectionColors[sectionKey] ?? primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected
              ? iconColor.withOpacity(0.12)
              : iconColor.withOpacity(0.07),
          border: selected
              ? Border.all(color: iconColor.withOpacity(0.35), width: 1)
              : Border.all(color: Colors.transparent, width: 1),
        ),
        child: Icon(icon, size: 22, color: iconColor),
      ),
    );
  }
}
