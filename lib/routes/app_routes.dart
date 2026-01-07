import 'package:flutter/material.dart';
import '../screen/home.dart';
import '../screen/details.dart';
import '../screen/cart.dart';
import '../main.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String home = '/home';
  static const String details = '/details';
  static const String cart = '/cart';

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingScreen(),
    home: (context) => const CoffeeHomeScreen(),
    details: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        return CoffeeDetailScreen(coffeeData: args);
      }
      return const CoffeeDetailScreen(coffeeData: {});
    },
    cart: (context) => const CartScreen(),
  };
}
