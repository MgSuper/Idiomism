import 'package:flutter/material.dart';
import 'package:theidioms/data/model/flash_card.dart';
import 'package:theidioms/data/model/idiom.dart';
import 'package:theidioms/presentation/screens/quiz/quiz_screen.dart';
import 'package:theidioms/presentation/screens/screens.dart';
import 'package:theidioms/presentation/screens/train/train_screen.dart';
import 'package:theidioms/presentation/screens/train_detail/train_detail_screen.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/learn':
        return MaterialPageRoute(
          builder: (_) => const LearnScreen(),
        );
      case '/learn_detail':
        return MaterialPageRoute(
          builder: (_) =>
              LearnDetailScreen(passData: routeSettings.arguments as Idiom),
        );
      case '/train':
        return MaterialPageRoute(builder: (_) => const TrainScreen());
      case '/quiz':
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case TrainDetailScreen.id:
        return MaterialPageRoute(
            builder: (_) => TrainDetailScreen(
                  passedData: routeSettings.arguments as FlashCard,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => ScreenNotFound(),
        );
    }
  }
}
