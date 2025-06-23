import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'dashboard_screen.dart';
import 'screens/create_job_screen.dart';

void main() {
  runApp(const HireLinkApp());
}

class HireLinkApp extends StatelessWidget {
  const HireLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HireLink',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/create_job': (context) => const CreateJobScreen(),
      },
    );
  }
}
