import 'package:book_reading_batch22/app/controller/service_controller.dart';
import 'package:book_reading_batch22/app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    await context.read<ServiceController>().getBooks();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(AppRouter.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Book Reading App",
        ),
      ),
    );
  }
}
