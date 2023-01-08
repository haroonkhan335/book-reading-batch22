import 'package:book_reading_batch22/home/widgets/book_card.dart';
import 'package:book_reading_batch22/home/widgets/book_cover.dart';
import 'package:book_reading_batch22/home/widgets/top_rated_book.dart';
import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  Expanded(
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
                  Expanded(
                    child: Builder(builder: (context) {
                      final topRatedBooks = [...widget.args.books];

                      topRatedBooks.sort((a, b) => b.rating.compareTo(a.rating));
                      final topRatedBook = topRatedBooks.first;
                      return TopRatedBook(topRatedBook: topRatedBook);
                    }),
                  ),
                ],
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
