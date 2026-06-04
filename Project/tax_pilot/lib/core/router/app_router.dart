import 'package:flutter/material.dart';
import 'package:tax_pilot/features/finance/presentation/pages/expense_page.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/login_page.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/onboarding_page.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/signup_page.dart';
import 'package:tax_pilot/features/finance/presentation/pages/income_page.dart';
import 'package:tax_pilot/shared_layout/main_navigation_page.dart';

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

  static const String expense =
    '/expense';

  static const String income =
    '/income';

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
              const LoginPage(),
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
      // DASHBOARD
      // ===================================================

      case dashboard:
        return MaterialPageRoute(
          builder: (_) {
            final index = settings.arguments as int? ?? 0;
            return MainNavigationPage(
              initialIndex: index,
            );
          },
        );

      // ===================================================
      // EXPENSE PAGE
      // ===================================================

      case expense:
        return MaterialPageRoute(
          builder: (_) =>
          const ExpensePage(),
      );

      // ===================================================
      // INCOME PAGE
      // ===================================================

      case income:
      return MaterialPageRoute(
        builder: (_) =>
        const IncomePage(),
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