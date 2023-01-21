import 'dart:convert';

import 'package:book_reading_batch22/chapters/reading.dart';
import 'package:book_reading_batch22/home/widgets/book_card.dart';
import 'package:book_reading_batch22/home/widgets/book_cover.dart';
import 'package:book_reading_batch22/home/widgets/top_rated_book.dart';
import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/models/left_off_point.dart';
import 'package:book_reading_batch22/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationItem {
  Color color;
  String title;

  NotificationItem(this.color, this.title);
}

class Home extends StatefulWidget {
  static const String routeName = "/home";
  Home({super.key, required this.args});

  final HomeArgs args;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDetailsShowing = false;
  int indexCoverToHide = -1;

  LeftOffPoint? lastPoint;

  SharedPreferences? _preferences;

  @override
  void initState() {
    _initPreferences();
    super.initState();
  }

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    final stringifedMap = _preferences!.getString("lastPoint");
    if (stringifedMap != null) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(stringifedMap));
      lastPoint = LeftOffPoint.fromJson(data);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: const Alignment(2, -1.3),
              child: Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE9AFA4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight(context) * 0.15),
                      Text(
                        "What are you\nreading today?",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                          height: context.height * 0.4,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.args.books.length,
                            itemBuilder: (context, index) {
                              final book = widget.args.books[index];
                              return Center(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 40.0),
                                      child: BookCard(
                                        bookHistorySaved: (book, chapter, pageNo) {
                                          setState(() {
                                            lastPoint = LeftOffPoint(
                                                book: book, chapter: chapter, pageNo: pageNo);

                                            if (_preferences != null) {
                                              _preferences!.setString(
                                                  "lastPoint", jsonEncode(lastPoint!.toJson()));
                                            }
                                          });
                                        },
                                        book: book,
                                        onDetailsOpened: () {
                                          setState(() {
                                            if (isDetailsShowing == true) {
                                              isDetailsShowing = false;
                                              indexCoverToHide = -1;
                                            } else {
                                              isDetailsShowing = true;
                                              indexCoverToHide = index;
                                            }
                                          });
                                          print(isDetailsShowing);
                                        },
                                      ),
                                    ),
                                    if (isDetailsShowing && indexCoverToHide == index)
                                      const SizedBox()
                                    else
                                      Positioned(
                                        top: -10,
                                        left: 50,
                                        child: BookCover(
                                          coverUrl: book.bookCover,
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          )),
                      Builder(builder: (context) {
                        final topRatedBooks = [...widget.args.books];

                        topRatedBooks.sort((a, b) => b.rating.compareTo(a.rating));
                        final topRatedBook = topRatedBooks.first;
                        return TopRatedBook(topRatedBook: topRatedBook);
                      }),
                      const SizedBox(height: 40),
                      if (lastPoint != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Container(
                              height: context.height * 0.15,
                              width: context.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        lastPoint!.book.bookCover,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: ListTile(
                                      title: Text("Book: ${lastPoint!.book.title}"),
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("Chapter: ${lastPoint!.chapter.chapterTitle}"),
                                          const SizedBox(height: 15),
                                          Text("Page no: ${lastPoint!.pageNo + 1}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Reading(
                                                pages: lastPoint!.chapter.pages,
                                                initialPage: lastPoint!.pageNo,
                                                title: lastPoint!.chapter.chapterTitle,
                                                onPageTurned: (int page) {},
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.chevron_right)),
                                  )
                                ],
                              )),
                        ),
                    ],
                  ),
                ),
              ),
            ),
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

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
