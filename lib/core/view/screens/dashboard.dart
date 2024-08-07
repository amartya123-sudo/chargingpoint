// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:evpoint/core/view/screens/overview.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          decoration: const BoxDecoration(
            color: Color(0xFFCBE9ED),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: width * 0.2,
                top: height * 0.2,
                child: const SizedBox(
                  child: Text(
                    "Hello",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.81,
                      fontFamily: 'Inter',
                      height: 1.5,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width * 0.2,
                top: height * 0.25,
                child: const SizedBox(
                  child: Text(
                    'NAMO',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 64.84,
                      fontFamily: 'Inter',
                      height: 1,
                      letterSpacing: -4.59,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width * 0.2,
                top: height * 0.35,
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
                top: height * 0.32,
                left: width * 0.45,
                child: ClipOval(
                  child: Container(
                    height: height * 1.2,
                    width: width * 1.5,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF9ADFD3),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.5,
                left: width * 0.5,
                child: GestureDetector(
                  onTap: _onTap,
                  child: IconButton(
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
                          MaterialPageRoute(
                            builder: (context) => const Overview(),
                          ),
                        );
                        _isLocked = true; 
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                top: height * 0.88,
                left: width * 0.9,
                child: Column(
                  children: [
                    const Text("Powered By"),
                    Container(
                      height: height * 0.09,
                      width: width * 0.09,
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
