import 'package:evpoint/util/dim.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xFFCBE9ED),
          ),
          child: Column(
            children: [
              Positioned(
                top: height(context, 0.5),
                left: width(context, 0.5),
                child: const Text("Coming Soon....."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
