import 'package:book_reading_batch22/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({super.key, required this.args});

  final HomeArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "HOME\n${args.books}",
              style: TextStyle(
                fontSize: 48,
              ),
            ),
            Text(args.name),
          ],
        ),
      ),
    );
  }
}

class HomeArgs {
  final List<Book> books;
  final String name;

  HomeArgs({required this.books, required this.name});
}
