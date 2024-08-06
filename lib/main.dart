import 'package:evpoint/core/providers/lock_state.dart' as custom_lock_state;
import 'package:evpoint/core/view/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => custom_lock_state.LockState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFCC323F),
        ),
      ),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}