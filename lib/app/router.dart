import 'package:book_reading_batch22/app/splash.dart';
import 'package:book_reading_batch22/home/screens/home.dart';
import 'package:flutter/material.dart';

class Router {
  static const String home = '/home';
  static const String splash = '/';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const Splash());
      case home:
        final args = settings.arguments as HomeArgs;
        return MaterialPageRoute(builder: (context) => Home(args: args));
    }
  }
}

class Message {
  final String body;
  final String senderName;
  final DateTime sentAt;
  final String senderPhotoUrl;
  final String? attachment;

  Message(
      {required this.body,
      required this.senderName,
      this.attachment,
      required this.senderPhotoUrl,
      required this.sentAt});
}
