import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

void main() {
  runApp(const TaxPilotApp());
}

class TaxPilotApp extends StatelessWidget {
  const TaxPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,

      title: 'TaxPilot',

      initialRoute: AppRouter.login,

      onGenerateRoute:
          AppRouter.onGenerateRoute,
    );
  }
}