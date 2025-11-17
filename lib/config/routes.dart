import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/main_navigation.dart';
import '../screens/about_screen.dart';
import '../screens/profile_info_screen.dart';
import '../screens/settings_screen.dart';
class AppRoutes {
  static const String splash = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String about = '/about';
  static const String settings = '/settings';
  static const String profileInfo = '/profile-info';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      signIn: (context) => SignInScreen(),
      signUp: (context) => const SignUpScreen(),
      about: (context) => const AboutScreen(),
      settings: (context) => const SettingsScreen(),
      // Routes with parameters use onGenerateRoute
    };
  }

  // Use this method when navigating with parameters
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Home route with username
    if (settings.name == home) {
      final args = settings.arguments as Map<String, dynamic>?;
      final username = args?['username'] ?? 'Guest';
      return MaterialPageRoute(
        builder: (context) => MainNavigation(username: username),
      );
    }
    
    // Profile Info route with username
    if (settings.name == profileInfo) {
      final args = settings.arguments as Map<String, dynamic>?;
      final username = args?['username'] ?? 'Guest';
      return MaterialPageRoute(
        builder: (context) => ProfileInfoScreen(username: username),
      );
    }
    
    return null;
  }
}