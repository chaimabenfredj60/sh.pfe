import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'providers/app_theme.dart';
import 'providers/api_provider.dart';
import 'screens/login_screen.dart';
import 'screens/personalcalendar_screen.dart';
import 'screens/my_tasks_screen.dart';
import 'screens/news_screen.dart';
import 'screens/events_screen.dart';

void main() {
  initializeDateFormatting('fr_FR', null);
  runApp(const CooptaliteApp());
}

class CooptaliteApp extends StatelessWidget {
  const CooptaliteApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appTheme),
        ChangeNotifierProvider(create: (context) => ApiProvider()),
      ],
      child: MaterialApp(
        title: 'Cooptalite',
        debugShowCheckedModeBanner: false,
        theme: appTheme.getTheme(),
        home: const LoginScreen(),
        routes: {
          '/calendar': (context) => const PersonalCalendarScreen(),
          '/tasks': (context) => const MyTasksScreen(),
          '/news': (context) => const NewsScreen(),
          '/events': (context) => const EventsScreen(),
        },
      ),
    );
  }
}
