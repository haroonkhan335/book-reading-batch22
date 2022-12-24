class Page {
  int pageNo;
  List<String> paragraphs;

  Page({
    required this.pageNo,
    required this.paragraphs,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      pageNo: json['pageNo'],
      paragraphs: List<String>.from(json["paragraphs"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "pageNo": pageNo,
        "paragraphs": paragraphs,
      };
}
