import 'package:book_reading_batch22/app/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookReading extends StatelessWidget {
  const BookReading({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      onGenerateRoute: (settings) {
        return router.Router.onGenerateRoute(settings);
      },
    );
  }
}
