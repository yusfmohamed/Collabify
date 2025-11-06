import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/main_navigation.dart';

class AppRoutes {
  static const String splash = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      signIn: (context) => SignInScreen(),
      signUp: (context) => const SignUpScreen(),
      // Default route - use onGenerateRoute for username passing
    };
  }

  // Use this method when navigating with username
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == home) {
      final args = settings.arguments as Map<String, dynamic>?;
      final username = args?['username'] ?? 'Guest';
      return MaterialPageRoute(
        builder: (context) => MainNavigation(username: username),
      );
    }
    return null;
  }
}