import 'package:evpoint/core/utils/dimension_util.dart';
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
                top: DimensionUtil.height(context, 0.5),
                left: DimensionUtil.width(context, 0.5),
                child: const Text("Coming Soon....."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
