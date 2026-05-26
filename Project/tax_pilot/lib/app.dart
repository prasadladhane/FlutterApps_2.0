import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';

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