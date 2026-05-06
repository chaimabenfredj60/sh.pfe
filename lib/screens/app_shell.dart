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

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const Color primary = Color(0xFF00B4A6);

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

  void _onLanguageChanged(String lang) {
    context.read<AppTheme>().setLanguage(lang);
  }

  void _onThemeChanged(bool isDark) {
    context.read<AppTheme>().toggleDarkMode();
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
      onSupport: () {},
      onLogout: _onLogout,
      onLanguageChanged: _onLanguageChanged,
      onThemeChanged: _onThemeChanged,
      currentLanguage: appTheme.language,
      isDarkMode: appTheme.isDarkMode,
    );
  }

  Widget _buildBody(AppTheme appTheme) {
    Widget body;
    switch (_page) {
      case 0:
        body = const DashboardScreen();
      case 1:
        body = OfferListScreen(
          activeSubItem: _activeSubItem,
          onOfferTap: (_) {},
        );
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

    // Envelopper dans Consumer pour que les changements de langue/thème soient écoutés
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
              child: _wrapBodyWithResponsivePadding(
                  context, _buildBody(appTheme))),
        ],
      ),
    );
  }

  // Tablet Layout (600px - 1100px)
  Widget _buildTabletLayout(BuildContext context, AppTheme appTheme) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(appTheme),
          Expanded(
            child: Row(children: [
              SizedBox(
                width: 100,
                child: _buildCompactSidebar(),
              ),
              Expanded(
                  child: _wrapBodyWithResponsivePadding(
                      context, _buildBody(appTheme))),
            ]),
          ),
        ],
      ),
    );
  }

  // Desktop Layout (>= 1100px)
  Widget _buildDesktopLayout(BuildContext context, AppTheme appTheme) {
    return Scaffold(
      body: Column(
        children: [
          _buildTopBar(appTheme),
          Expanded(
            child: Row(children: [
              SizedBox(
                width: 250,
                child: _buildSidebar(appTheme),
              ),
              Expanded(
                  child: _wrapBodyWithResponsivePadding(
                      context, _buildBody(appTheme))),
            ]),
          ),
        ],
      ),
    );
  }

  // Drawer for Mobile
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: primary),
            child: const Text(
              'Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _tile(
              icon: Icons.dashboard,
              label: 'Dashboard',
              selected: _page == 0,
              onTap: () => {_navigate(0), Navigator.pop(context)}),
          _tile(
              icon: Icons.local_offer,
              label: 'Offer',
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
              icon: Icons.people_outline,
              label: 'RH',
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
          // PERSONAL
          _tile(
              icon: Icons.bookmark_outline,
              label: 'Personal',
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
          // NEWS & EVENTS
          _tile(
              icon: Icons.campaign_outlined,
              label: 'News & Events',
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
          // MY JACKPOT
          _tile(
              icon: Icons.casino_outlined,
              label: 'My Jackpot',
              selected: _page == 9,
              onTap: () => {_navigate(9), Navigator.pop(context)}),
          // MY APPLICATIONS
          _tile(
              icon: Icons.edit_note_outlined,
              label: 'My Applications',
              selected: _page == 10,
              onTap: () => {_navigate(10), Navigator.pop(context)}),
          // COMMUNICATION
          _tile(
              icon: Icons.chat_bubble_outline,
              label: 'Communication',
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
        ],
      ),
    );
  }

  // Compact Sidebar for Tablet
  Widget _buildCompactSidebar() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10),
          _compactTile(
              icon: Icons.dashboard,
              selected: _page == 0,
              onTap: () => _navigate(0)),
          _compactTile(
              icon: Icons.local_offer,
              selected: _page == 1,
              onTap: () => _navigate(1)),
          _compactTile(
              icon: Icons.people_outline,
              selected: [2, 3, 4].contains(_page),
              onTap: () => _navigate(2)),
          _compactTile(
              icon: Icons.bookmark_outline,
              selected: [5, 6].contains(_page),
              onTap: () => _navigate(5)),
          _compactTile(
              icon: Icons.campaign_outlined,
              selected: [7, 8].contains(_page),
              onTap: () => _navigate(7)),
          _compactTile(
              icon: Icons.casino_outlined,
              selected: _page == 9,
              onTap: () => _navigate(9)),
          _compactTile(
              icon: Icons.edit_note_outlined,
              selected: _page == 10,
              onTap: () => _navigate(10)),
          _compactTile(
              icon: Icons.chat_bubble_outline,
              selected: [11, 12, 13, 14].contains(_page),
              onTap: () => _navigate(11)),
        ]),
      ),
    );
  }

  // Wrapper pour ajouter du padding responsif au contenu du body
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

  Widget _buildSidebar(AppTheme appTheme) {
    return Container(
      width: 200,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20),

          // DASHBOARD
          _tile(
              appTheme: appTheme,
              icon: Icons.dashboard,
              label: appTheme.translate('dashboard'),
              selected: _page == 0,
              onTap: () => _navigate(0)),

          // OFFER
          _tile(
              appTheme: appTheme,
              icon: Icons.local_offer,
              label: appTheme.translate('offer'),
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

          // RH
          _tile(
              appTheme: appTheme,
              icon: Icons.people_outline,
              label: appTheme.translate('rh'),
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

          // PERSONAL
          _tile(
              appTheme: appTheme,
              icon: Icons.bookmark_outline,
              label: appTheme.translate('personal'),
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

          // NEWS & EVENTS
          _tile(
              appTheme: appTheme,
              icon: Icons.campaign_outlined,
              label: appTheme.translate('news'),
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

          // COMMUNICATION
          _tile(
              appTheme: appTheme,
              icon: Icons.chat_bubble_outline,
              label: appTheme.translate('communication'),
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
            _sub('My feedbacks',
                sel: _page == 13,
                onTap: () => _navigate(13, subItem: 'My feedbacks')),
            _sub('My documents / re...',
                sel: _page == 14,
                onTap: () => _navigate(14, subItem: 'My documents')),
          ],

          // MY JACKPOT
          _tile(
              appTheme: appTheme,
              icon: Icons.casino_outlined,
              label: appTheme.translate('jackpot'),
              selected: _page == 9,
              onTap: () => _navigate(9)),

          // MY APPLICATIONS
          _tile(
              appTheme: appTheme,
              icon: Icons.edit_note_outlined,
              label: appTheme.translate('applications'),
              selected: _page == 10,
              onTap: () => _navigate(10)),

          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  Widget _tile({
    required IconData icon,
    required String label,
    AppTheme? appTheme,
    bool selected = false,
    bool hasArrow = false,
    bool arrowDown = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? primary : Colors.transparent,
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Icon(icon, size: 20, color: selected ? Colors.white : Colors.grey),
          const SizedBox(width: 10),
          Expanded(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontSize: 13))),
          if (hasArrow)
            Icon(arrowDown ? Icons.keyboard_arrow_down : Icons.chevron_right,
                color: selected ? Colors.white : Colors.grey, size: 18),
        ]),
      ),
    );
  }

  Widget _sub(String label, {bool sel = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 40, top: 10, bottom: 10),
        child: Row(children: [
          Icon(Icons.circle, size: 8, color: sel ? primary : Colors.grey),
          const SizedBox(width: 10),
          Expanded(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: sel ? primary : Colors.black, fontSize: 13))),
        ]),
      ),
    );
  }

  // Compact tile for Tablet
  Widget _compactTile({
    required IconData icon,
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? primary : Colors.transparent,
        padding: const EdgeInsets.all(12),
        child:
            Icon(icon, size: 24, color: selected ? Colors.white : Colors.grey),
      ),
    );
  }
}
