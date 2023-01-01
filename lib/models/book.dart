import 'package:book_reading_batch22/models/chapter.dart';

class Book {
  String title;
  String author;
  DateTime publishedDate;
  String details;
  String bookCover;
  List<Chapter> chapters;
  double rating;

  Book({
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.details,
    required this.bookCover,
    required this.chapters,
    required this.rating,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        rating: json["rating"],
        author: json["author"],
        publishedDate: DateTime.tryParse(json["publishedDate"]) ?? DateTime.now(),
        details: json["details"],
        bookCover: json["bookCover"],
        chapters: List<Map<String, dynamic>>.from(json["chapters"])
            .map((e) => Chapter.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "rating": rating,
        "publishedDate": publishedDate.toIso8601String(),
        "details": details,
        "bookCover": bookCover,
        "chapters": chapters.map((e) => e.toJson()).toList(),
      };
}
