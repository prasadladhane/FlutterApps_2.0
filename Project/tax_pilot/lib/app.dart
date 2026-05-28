import 'package:flutter/material.dart';
import 'package:tax_pilot/features/dashboard/presentation/pages/login_page.dart';

import 'core/theme/app_theme.dart';


class TaxPilotApp extends StatelessWidget {
  const TaxPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'TaxPilot',

      theme: AppTheme.darkTheme,

      home: const LoginPage(),
    );
  }
}