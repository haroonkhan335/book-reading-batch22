import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/models/chapter.dart';

class LeftOffPoint {
  final int pageNo;
  final Chapter chapter;
  final Book book;

  LeftOffPoint({
    required this.book,
    required this.chapter,
    required this.pageNo,
  });

  factory LeftOffPoint.fromJson(Map<String, dynamic> json) => LeftOffPoint(
        book: Book.fromJson(json["book"]),
        chapter: Chapter.fromJson(json["chapter"]),
        pageNo: json["pageNo"],
      );
  Map<String, dynamic> toJson() => {
        "book": book.toJson(),
        "chapter": chapter.toJson(),
        "pageNo": pageNo,
      };
}
