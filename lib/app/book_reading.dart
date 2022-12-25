import 'package:book_reading_batch22/app/router.dart' as router;
import 'package:flutter/material.dart';

class BookReading extends StatelessWidget {
  const BookReading({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: (settings) {
      return router.Router.onGenerateRoute(settings);
    });
  }
}
