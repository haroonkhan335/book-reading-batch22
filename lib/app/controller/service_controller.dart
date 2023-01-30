import 'dart:convert';

import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/models/chapter.dart';
import 'package:book_reading_batch22/models/left_off_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController extends ChangeNotifier {
  List<Book> books = [];

  Book? selectedBook;
  Chapter? selectedChapter;
  LeftOffPoint? lastPoint;
  int currentPageNo = 0;

  SharedPreferences? _preferences;

  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    final stringifedMap = _preferences!.getString("lastPoint");
    if (stringifedMap != null) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(stringifedMap));
      lastPoint = LeftOffPoint.fromJson(data);
    }
    notifyListeners();
  }

  Future<void> getBooks() async {
    final stringifiedData = await rootBundle.loadString("assets/data/data.json");

    final Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(stringifiedData));
    books =
        (data["book"] as Map<String, dynamic>).entries.map((e) => Book.fromJson(e.value)).toList();
  }

  Book getTopRatedBook() {
    final topRatedBooks = [...books];

    topRatedBooks.sort((a, b) => b.rating.compareTo(a.rating));
    final topRatedBook = topRatedBooks.first;
    return topRatedBook;
  }

  void saveLastPoint(int page) async {
    currentPageNo = page;

    lastPoint = LeftOffPoint(book: selectedBook!, chapter: selectedChapter!, pageNo: currentPageNo);

    if (_preferences != null) {
      _preferences!.setString("lastPoint", jsonEncode(lastPoint!.toJson()));
    }
    notifyListeners();
  }
}
