import 'package:flutter/material.dart';
import '../screen/home.dart';
import '../main.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingScreen(),
    home: (context) => const CoffeeHomeScreen(),
  };
}
