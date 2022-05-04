import 'package:flutter/material.dart';
import 'package:my_movies_app/src/ui/details/details_screen.dart';
import 'package:my_movies_app/src/ui/home/home_screen.dart';
import 'package:my_movies_app/src/ui/login/login_screen.dart';
import 'package:my_movies_app/src/ui/search/search_screen.dart';
import 'package:my_movies_app/src/ui/splash/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(settings: settings, builder: (context) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(settings: settings, builder: (context) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(settings: settings, builder: (context) => const HomeScreen());
      case '/search':
        return MaterialPageRoute(settings: settings, builder: (context) => const SearchScreen());
      case '/details':
        return MaterialPageRoute(settings: settings, builder: (context) => const MovieDetailsScreen());
      default:
        return MaterialPageRoute(settings: settings, builder: (context) => const LoginScreen());
    }
  }
}