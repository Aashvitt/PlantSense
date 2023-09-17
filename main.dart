import 'package:flutter/material.dart';
import 'entry_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 41, 36, 36),
                  Color.fromARGB(255, 127, 60, 39),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Entry()),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
