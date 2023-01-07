import 'package:book_reading_batch22/models/book.dart';
import 'package:book_reading_batch22/utils/media_query.dart';
import 'package:flutter/material.dart';

class TopRatedBook extends StatelessWidget {
  const TopRatedBook({
    Key? key,
    required this.topRatedBook,
  }) : super(key: key);

  final Book topRatedBook;

  @override
  Widget build(BuildContext context) {
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
                    Text(topRatedBook.title, style: Theme.of(context).textTheme.headline6),
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
                              color: Colors.white, borderRadius: BorderRadius.circular(50)),
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
  }
}
