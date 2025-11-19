import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'config/routes.dart';

void main() {
  runApp(const CollabifyApp());
}

class CollabifyApp extends StatelessWidget {
  const CollabifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collabify',
      theme: AppTheme.theme,
      
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute, // ⚠️ ADD THIS LINE
      debugShowCheckedModeBanner: false,
    );
  }
}
