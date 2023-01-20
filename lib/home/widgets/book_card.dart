import 'dart:developer';

import 'package:book_reading_batch22/app/router.dart';
import 'package:book_reading_batch22/chapters/book_chapters.dart';
import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/models/chapter.dart';
import 'package:book_reading_batch22/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookCard extends StatefulWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.onDetailsOpened,
    required this.bookHistorySaved,
  });

  final Book book;
  final Function() onDetailsOpened;
  final Function(Book book, Chapter chapter, int pageNo) bookHistorySaved;

  @override
  State<BookCard> createState() {
    return _BookCardState();
  }
}

class _BookCardState extends State<BookCard> {
  bool isDetailsShowing = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: screenWidth(context) * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenHeight(context) * 0.13,
              child: isDetailsShowing ? Text(widget.book.details) : const SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.book.title, style: GoogleFonts.poppins(fontSize: 21)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 15),
              child: Text(widget.book.author,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  )),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isDetailsShowing == true) {
                          isDetailsShowing = false;
                        } else {
                          isDetailsShowing = true;
                        }
                        widget.onDetailsOpened();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(
                        child: Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.bookChapters,
                          arguments: BookChaptersArgs(
                              book: widget.book,
                              historySaved: (Chapter chapter, int pageNo) {
                                log("CHAPTER: ${chapter.chapterTitle} on Page no: $pageNo");
                                widget.bookHistorySaved(widget.book, chapter, pageNo);
                              }));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Text(
                          "Read",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
