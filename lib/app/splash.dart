import 'dart:convert';

import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    final stringifiedData = await rootBundle.loadString("assets/data/data.json");

    final Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(stringifiedData));
    final List<Book> books =
        (data["book"] as Map<String, dynamic>).entries.map((e) => Book.fromJson(e.value)).toList();

    final List<Message> messages = (data["messages"] as Map<String, dynamic>)
        .entries
        .map((e) => Message.fromJson(e.value))
        .toList();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Messages(messages: messages)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Book Reading App",
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({super.key, required this.messages});

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return SizedBox();
        },
      ),
    );
  }
}
