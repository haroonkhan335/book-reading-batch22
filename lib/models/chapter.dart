import 'package:book_reading_batch22/models/page.dart';

class Chapter {
  int chapterNo;
  String chapterTitle;
  String chapterDetails;
  List<BookPage> pages;

  Chapter({
    required this.chapterDetails,
    required this.chapterNo,
    required this.chapterTitle,
    required this.pages,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterDetails: json["chapterDetails"],
      chapterNo: json["chapterNo"],
      chapterTitle: json["chapterTitle"],
      pages:
          List<Map<String, dynamic>>.from(json["pages"]).map((e) => BookPage.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "chapterDetails": chapterDetails,
        "chapterNo": chapterNo,
        "chapterTitle": chapterTitle,
        "pages": pages.map((e) => e.toJson()).toList(),
      };
}
