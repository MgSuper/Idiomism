import 'package:flutter/material.dart';
import 'package:idiomism/presentation/screens/screens.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
        break;
      case '/learn':
        return MaterialPageRoute(
          builder: (_) => LearnScreen(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => ScreenNotFound(),
        );
    }
  }
}
