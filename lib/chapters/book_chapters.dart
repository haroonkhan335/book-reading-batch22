import 'package:book_reading_batch22/chapters/reading.dart';
import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/utils/media_query.dart';
import 'package:flutter/material.dart';

class BookChapters extends StatelessWidget {
  const BookChapters({super.key, required this.args});

  final BookChaptersArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: screenHeight(context) * 0.4,
              width: screenWidth(context),
              child: Image.network(
                args.book.bookCover,
                fit: BoxFit.cover,
              ),
            ),
            Center(
                child: Column(
              children: [
                SizedBox(height: screenHeight(context) * 0.35),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.grey);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: args.book.chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = args.book.chapters[index];
                      return Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                              return Reading(chapter: chapter);
                            }));
                          },
                          title: Text(chapter.chapterTitle, style: const TextStyle(fontSize: 20)),
                          subtitle: Text(chapter.chapterDetails,
                              maxLines: 2, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                          trailing: Text("Pages: ${chapter.pages.length.toString()}"),
                        ),
                      );
                    },
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class BookChaptersArgs {
  final Book book;

  BookChaptersArgs({required this.book});
}
