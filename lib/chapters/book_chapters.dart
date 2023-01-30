import 'package:book_reading_batch22/app/controller/service_controller.dart';
import 'package:book_reading_batch22/chapters/reading.dart';
import 'package:book_reading_batch22/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookChapters extends StatelessWidget {
  const BookChapters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          final selectedBook = context.read<ServiceController>().selectedBook!;

          return Stack(
            children: [
              SizedBox(
                height: screenHeight(context) * 0.4,
                width: screenWidth(context),
                child: Image.network(
                  selectedBook.bookCover,
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
                      itemCount: selectedBook.chapters.length,
                      itemBuilder: (context, index) {
                        final chapter = selectedBook.chapters[index];
                        return Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {
                              context.read<ServiceController>().selectedChapter = chapter;
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (BuildContext context) {
                                return Reading();
                              }));
                            },
                            title: Text(chapter.chapterTitle, style: const TextStyle(fontSize: 20)),
                            subtitle: Text(chapter.chapterDetails,
                                maxLines: 2,
                                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                            trailing: Text("Pages: ${chapter.pages.length.toString()}"),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ))
            ],
          );
        }),
      ),
    );
  }
}
