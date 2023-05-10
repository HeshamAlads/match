import 'package:flutter/material.dart';

import 'matchs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tajawal-Medium',
      ),

      home: const Directionality(
          textDirection: TextDirection.rtl, child: Matchs()),
    );
  }
}
