// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:evpoint/core/view/screens/overview.dart';
import 'package:evpoint/core/utils/dimension_util.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isPressed = false;
  bool _isLocked = true;
  var fluttertts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
      _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _isPressed = !_isPressed;
      _controller.forward().then((value) {
        _navigateToNextPage();
        fluttertts.speak("Welcome to Kheer\n Your Personalized Assistant");
      });
    });
  }

  void _navigateToNextPage() {
    Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Overview(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xFFCBE9ED),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: DimensionUtil.width(context, 0.2),
                top: DimensionUtil.height(context, 0.3),
                child: const SizedBox(
                  child: Text(
                    "Hello",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.81,
                      fontFamily: 'Inter',
                      height: 0.03,
                      letterSpacing: 18.11,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: DimensionUtil.width(context, 0.2),
                top: DimensionUtil.height(context, 0.3),
                child: const SizedBox(
                  child: Text(
                    'NAMO',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 114.84,
                      fontFamily: 'Inter',
                      height: 0,
                      letterSpacing: -4.59,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: DimensionUtil.width(context, 0.204),
                top: DimensionUtil.height(context, 0.452),
                child: const SizedBox(
                  child: Text(
                    'Simple and sleek design \nwith users in mind.',
                    style: TextStyle(
                      color: Color(0xFF42454A),
                      fontSize: 18.37,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              Positioned(
                top: DimensionUtil.height(context, 0.32),
                left: DimensionUtil.width(context, 0.451),
                child: ClipOval(
                  child: Container(
                    height: 1200,
                    width: 1500,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF9ADFD3),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: DimensionUtil.height(context, 0),
                right: DimensionUtil.width(context, 0),
                child: ClipRect(
                  child: Container(
                    height: DimensionUtil.height(context, 0.5),
                    width: DimensionUtil.width(context, 0.07),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.06, -1.00),
                        end: Alignment(-0.06, 1),
                        colors: [Color(0xFF99DFD3), Color(0xFF35A7A0)],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: DimensionUtil.height(context, 0),
                right: DimensionUtil.width(context, 0),
                child: ClipRect(
                  child: Container(
                    height: DimensionUtil.height(context, 0.5),
                    width: DimensionUtil.width(context, 0.07),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF88C7DD), Color(0xFF73ADC1)],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: DimensionUtil.height(context, 0.35),
                left: DimensionUtil.width(context, 0.45),
                child: GestureDetector(
                  onTap: _onTap,
                  child:  IconButton(
          icon: Icon(
            _isLocked ? Icons.lock : Icons.lock_open,
            size: 50.0,
          ),
          onPressed: () async {
            setState(() {
              _isLocked = !_isLocked;
            });

            // Adding a delay to allow the UI to update
            if (!_isLocked) {
              await Future.delayed(const Duration(milliseconds: 300));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Overview()),
              );
            }
          },
        ),
                ),
              ),
              Positioned(
                top: DimensionUtil.height(context, 0.85),
                left: DimensionUtil.width(context, 0.82),
                child: Column(
                  children: [
                    const Text("Powered By"),
                    Container(
                      height: DimensionUtil.height(context, 0.09),
                      width: DimensionUtil.width(context, 0.09),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
