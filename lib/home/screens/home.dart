import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "HOME",
          style: TextStyle(
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
