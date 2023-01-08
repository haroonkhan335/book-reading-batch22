import 'dart:developer';

import 'package:book_reading_batch22/models/chapter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reading extends StatefulWidget {
  const Reading({super.key, required this.chapter});

  final Chapter chapter;

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  int index = 0;

  final PageController _pageController = PageController();
  final Curve curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.chapterTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  log("PAGE CHANGED: $index");
                  setState(() {
                    this.index = index;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.chapter.pages.length,
                itemBuilder: (context, index) {
                  final page = widget.chapter.pages[index];

                  return Column(
                      children: page.paragraphs
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text('        $e', style: GoogleFonts.poppins(fontSize: 19)),
                              ))
                          .toList());
                },
              ),
            ),
          ),
          SafeArea(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(index - 1,
                      duration: const Duration(milliseconds: 500), curve: curve);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_left,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Text('${index + 1}/${widget.chapter.pages.length}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(this.index + 1,
                      duration: const Duration(milliseconds: 500), curve: curve);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_right,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
