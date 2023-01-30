import 'package:book_reading_batch22/app/controller/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Reading extends StatefulWidget {
  const Reading({
    super.key,
  });

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
      index = context.read<ServiceController>().lastPoint?.pageNo ?? 0;

      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: curve);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<ServiceController>().selectedChapter!.chapterTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  //TODO: Shift to provider
                  this.index = index;

                  context.read<ServiceController>().saveLastPoint(index);
                },
                physics: const NeverScrollableScrollPhysics(),
                itemCount: context.read<ServiceController>().selectedChapter!.pages.length,
                itemBuilder: (context, index) {
                  final page = context.read<ServiceController>().selectedChapter!.pages[index];

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
              Consumer<ServiceController>(builder: (context, provider, _) {
                return Text(
                    '${provider.currentPageNo + 1}/${context.read<ServiceController>().selectedChapter!.pages.length}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500));
              }),
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(index + 1,
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
