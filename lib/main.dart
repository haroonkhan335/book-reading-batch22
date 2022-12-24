import 'dart:convert';

import 'package:book_reading_batch22/app/book_reading.dart';
import 'package:book_reading_batch22/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stringifiedData = await rootBundle.loadString("assets/data/data.json");

  final Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(stringifiedData));
  final List<Book> books =
      (data["book"] as Map<String, dynamic>).entries.map((e) => Book.fromJson(e.value)).toList();

  runApp(const BookReading());
}
