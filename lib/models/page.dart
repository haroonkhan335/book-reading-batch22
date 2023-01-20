class BookPage {
  int pageNo;
  List<String> paragraphs;

  BookPage({
    required this.pageNo,
    required this.paragraphs,
  });

  factory BookPage.fromJson(Map<String, dynamic> json) {
    return BookPage(
      pageNo: json['pageNo'],
      paragraphs: List<String>.from(json["paragraphs"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "pageNo": pageNo,
        "paragraphs": paragraphs,
      };
}
