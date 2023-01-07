import 'package:flutter/material.dart';

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
        return const Icon(Icons.error);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const CircularProgressIndicator();
      },
      height: 100,
      width: 70,
      fit: BoxFit.cover,
    );
  }
}
