import 'package:evpoint/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:charginpoint/overview.dart';

void main() async {
  await dotenv.load(fileName: '../.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          // scaffoldBackgroundColor: Colors.black,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFCC323F),
          ),
        ),
        home: const Dashboard(),
        debugShowCheckedModeBanner: false,
      );
  }
}