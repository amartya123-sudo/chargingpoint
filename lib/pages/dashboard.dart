import 'package:flutter/material.dart';
import 'package:evpoint/pages/overview.dart';
import 'package:evpoint/util/dim.dart';
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
                left: width(context, 0.2),
                top: height(context, 0.3),
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
                left: width(context, 0.2),
                top: height(context, 0.3),
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
                left: width(context, 0.204),
                top: height(context, 0.452),
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
                top: height(context, 0.32),
                left: width(context, 0.451),
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
                top: height(context, 0),
                right: width(context, 0),
                child: ClipRect(
                  child: Container(
                    height: height(context, 0.5),
                    width: width(context, 0.07),
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
                bottom: height(context, 0),
                right: width(context, 0),
                child: ClipRect(
                  child: Container(
                    height: height(context, 0.5),
                    width: width(context, 0.07),
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
                top: height(context, 0.35),
                left: width(context, 0.45),
                child: GestureDetector(
                  onTap: _onTap,
                  child: Transform.rotate(
                    angle: _animation.value * 6.3, // 2 * pi for a full rotation
                    child: ClipOval(
                      child: Container(
                        width: width(context, 0.11),
                        height: height(context, 0.15),
                        decoration: const ShapeDecoration(
                          color: Color.fromARGB(54, 42, 31, 31),
                          shape: OvalBorder(),
                        ),
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(0.01),
                          child: const Icon(
                            size: 90,
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context, 0.85),
                left: width(context, 0.82),
                child: Column(
                  children: [
                    const Text("Powered By"),
                    Container(
                      height: height(context, 0.09),
                      width: width(context, 0.09),
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
