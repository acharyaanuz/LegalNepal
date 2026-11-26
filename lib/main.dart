import 'package:flutter/material.dart';
import '../theme.dart';
import 'splash.dart';
import 'onboarding.dart';
import 'login.dart';
import 'client_home.dart';
import 'lawyer_search.dart';
import 'consultations.dart';
import 'saved_lawyers.dart';
import 'profile.dart';

void main() {
  runApp(const LegalNepalApp());
}

class LegalNepalApp extends StatelessWidget {
  const LegalNepalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LegalNepal',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const ClientHomeScreen(),
        '/lawyer-search': (context) => const LawyerSearchScreen(),
        '/consultations': (context) => const ConsultationsScreen(),
        '/saved-lawyers': (context) => const SavedLawyersScreen(),
        '/profile': (context) => const UserProfileScreen(),
      },
    );
  }
}