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
                              child: BookCard(book: book),
                            ),
                            Positioned(
                              top: -10,
                              left: 50,
                              child: BookCover(
                                coverUrl: book.bookCover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                  Expanded(
                    child: Builder(builder: (context) {
                      final asdfasfa = args.books;

                      asdfasfa.sort((a, b) => b.rating.compareTo(a.rating));
                      final topRatedBook = asdfasfa.first;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Best Of The Day!',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  width: screenWidth(context),
                                  height: screenHeight(context) * 0.17,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(topRatedBook.title,
                                          style: Theme.of(context).textTheme.headline6),
                                      Text(
                                        topRatedBook.author,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(50)),
                                            height: 60,
                                            width: 30,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Icon(Icons.star, color: Colors.yellow),
                                                Text(topRatedBook.rating.toString()),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          SizedBox(
                                            width: screenWidth(context) * 0.4,
                                            child: Text(
                                              topRatedBook.details,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 40,
                                  top: -50,
                                  child: Image.network(
                                    "https://images-platform.99static.com//t1JVDMNSYtG7TUIT-jqybhzvzZ8=/fit-in/590x590/projects-files/113/11302/1130227/b1759218-cfdd-4bba-8129-f1312323471e.jpg",
                                    height: 160,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
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

class BookCover extends StatelessWidget {
  const BookCover({
    Key? key,
    required this.coverUrl,
  }) : super(key: key);

  final String coverUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      coverUrl,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return CircularProgressIndicator();
      },
      height: 100,
      width: 70,
      fit: BoxFit.cover,
    );
  }
}

class HomeArgs {
  final List<Book> books;
  final String name;

  HomeArgs({required this.books, required this.name});
}

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final Book book;

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
