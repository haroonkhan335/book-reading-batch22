import 'package:book_reading_batch22/app/splash.dart';
import 'package:book_reading_batch22/home/screens/home.dart';
import 'package:flutter/material.dart';

class BookReading extends StatelessWidget {
  const BookReading({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const Splash(),
        "/home": (context) => const Home(),
      },
    );
  }
}
