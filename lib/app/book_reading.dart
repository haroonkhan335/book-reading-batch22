import 'package:book_reading_batch22/app/splash.dart';
import 'package:book_reading_batch22/home/screens/home.dart';
import 'package:flutter/material.dart';

class BookReading extends StatelessWidget {
  const BookReading({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: (settings) {
      return Router.onGenerateRoute(settings);
    });
  }
}

class Router {
  static const String home = '/home';
  static const String splash = '/splash';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const Splash());
      case Home.routeName:
        final args = settings.arguments as HomeArgs;
        return MaterialPageRoute(builder: (context) => Home(args: args));
    }
  }
}
