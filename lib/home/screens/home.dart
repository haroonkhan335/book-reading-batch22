import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({super.key, required this.args});

  final HomeArgs args;

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
                    itemCount: args.books.length,
                    itemBuilder: (context, index) {
                      final book = args.books[index];
                      return Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: Card(
                                elevation: 10,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  width: screenWidth(context) * 0.6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: screenHeight(context) * 0.13,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(book.title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 21,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, bottom: 15),
                                        child: Text(book.author,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey,
                                            )),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
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
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 15),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black87,
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight: Radius.circular(20),
                                                      topLeft: Radius.circular(20)),
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
                              ),
                            ),
                            Positioned(
                              top: -10,
                              left: 50,
                              child: Image.network(
                                book.bookCover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                                height: 100,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                  const Expanded(child: SizedBox()),
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
