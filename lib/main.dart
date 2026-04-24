import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    return MaterialApp(
      title: 'Cooptalite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00B4A6),
          primary: const Color(0xFF00B4A6),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      routes: {
        '/calendar': (context) => const PersonalCalendarScreen(),
        '/tasks':    (context) => const MyTasksScreen(),
        '/news':     (context) => const NewsScreen(),
        '/events':   (context) => const EventsScreen(),
      },
      home: const LoginScreen(),
    );
  }
}