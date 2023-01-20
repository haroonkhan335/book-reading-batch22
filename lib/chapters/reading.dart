import 'package:book_reading_batch22/models/page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reading extends StatefulWidget {
  const Reading({
    super.key,
    required this.pages,
    required this.title,
    required this.onPageTurned,
    this.initialPage = 0,
  });

  final List<BookPage> pages;
  final String title;
  final int initialPage;

  final Function(int) onPageTurned;

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  int index = 0;

  late final PageController _pageController = PageController();
  final Curve curve = Curves.bounceOut;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      index = widget.initialPage;
      widget.onPageTurned(index);
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: curve);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    this.index = index;
                  });
                  widget.onPageTurned(index);
                },
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.pages.length,
                itemBuilder: (context, index) {
                  final page = widget.pages[index];

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
              Text('${index + 1}/${widget.pages.length}',
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
