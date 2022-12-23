import 'package:book_reading_batch22/models/page.dart';

class Chapter {
  int chapterNo;
  String chapterTitle;
  String chapterDetails;
  List<Page> pages;

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
        pages: (json["pages"] as List<Map<String, dynamic>>).map((e) => Page.fromJson(e)).toList());
  }
}
