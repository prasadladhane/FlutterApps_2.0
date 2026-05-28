import 'package:flutter/material.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/login_page.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/onboarding_page.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/signup_page.dart';


class AppRouter {
  AppRouter._();

  // =======================================================
  // ROUTE NAMES
  // =======================================================

  static const String login =
      '/login';

  static const String signup =
      '/signup';

  static const String onboarding =
      '/onboarding';

  static const String dashboard =
      '/dashboard';

  // =======================================================
  // ROUTES
  // =======================================================

  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
  ) {

    switch (settings.name) {

      // ===================================================
      // LOGIN
      // ===================================================

      case login:
        return MaterialPageRoute(
          builder: (_) =>
              const DashboardPage(),
        );

      // ===================================================
      // SIGNUP
      // ===================================================

      case signup:
        return MaterialPageRoute(
          builder: (_) =>
              const SignupPage(),
        );

      // ===================================================
      // ONBOARDING
      // ===================================================

      case onboarding:
        return MaterialPageRoute(
          builder: (_) =>
              const OnboardingPage(),
        );

      // ===================================================
      // DEFAULT
      // ===================================================

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const LoginPage(),
        );
    }
  }
}