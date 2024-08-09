// import 'package:flutter/material.dart';
// import 'package:evpoint/pages/overview.dart';
// import 'package:evpoint/util/dim.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _isPressed = false;
//   var fluttertts = FlutterTts();

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     )..addListener(() {
//         setState(() {});
//       });
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onTap() {
//     setState(() {
//       _isPressed = !_isPressed;
//       _controller.forward().then((value) {
//         _navigateToNextPage();
//         fluttertts.speak("Welcome to Kheer\n Your Personalized Assistant");
//       });
//     });
//   }

//   void _navigateToNextPage() {
//     Navigator.of(context).push(_createRoute());
//   }

//   Route _createRoute() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => const Overview(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: ScaleTransition(
//             scale: animation,
//             child: child,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             color: Color(0xFFCBE9ED),
//           ),
//           child: Stack(
//             children: <Widget>[
//               Positioned(
//                 left: width(context, 0.2),
//                 top: height(context, 0.3),
//                 child: const SizedBox(
//                   child: Text(
//                     "Hello",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 24.81,
//                       fontFamily: 'Inter',
//                       height: 0.03,
//                       letterSpacing: 18.11,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: width(context, 0.2),
//                 top: height(context, 0.3),
//                 child: const SizedBox(
//                   child: Text(
//                     'NAMO',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 114.84,
//                       fontFamily: 'Inter',
//                       height: 0,
//                       letterSpacing: -4.59,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: width(context, 0.204),
//                 top: height(context, 0.452),
//                 child: const SizedBox(
//                   child: Text(
//                     'Simple and sleek design \nwith users in mind.',
//                     style: TextStyle(
//                       color: Color(0xFF42454A),
//                       fontSize: 18.37,
//                       fontFamily: 'Inter',
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.32),
//                 left: width(context, 0.451),
//                 child: ClipOval(
//                   child: Container(
//                     height: 1200,
//                     width: 1500,
//                     decoration: const ShapeDecoration(
//                       color: Color(0xFF9ADFD3),
//                       shape: OvalBorder(),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0),
//                 right: width(context, 0),
//                 child: ClipRect(
//                   child: Container(
//                     height: height(context, 0.5),
//                     width: width(context, 0.07),
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment(0.06, -1.00),
//                         end: Alignment(-0.06, 1),
//                         colors: [Color(0xFF99DFD3), Color(0xFF35A7A0)],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: height(context, 0),
//                 right: width(context, 0),
//                 child: ClipRect(
//                   child: Container(
//                     height: height(context, 0.5),
//                     width: width(context, 0.07),
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment(0.00, -1.00),
//                         end: Alignment(0, 1),
//                         colors: [Color(0xFF88C7DD), Color(0xFF73ADC1)],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.35),
//                 left: width(context, 0.45),
//                 child: GestureDetector(
//                   onTap: _onTap,
//                   child: Transform.rotate(
//                     angle: _animation.value * 6.3, // 2 * pi for a full rotation
//                     child: ClipOval(
//                       child: Container(
//                         width: width(context, 0.11),
//                         height: height(context, 0.15),
//                         decoration: const ShapeDecoration(
//                           color: Color.fromARGB(54, 42, 31, 31),
//                           shape: OvalBorder(),
//                         ),
//                         child: Transform(
//                           transform: Matrix4.identity()
//                             ..translate(0.0, 0.0)
//                             ..rotateZ(0.01),
//                           child: const Icon(
//                             size: 90,
//                             Icons.lock,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.85),
//                 left: width(context, 0.82),
//                 child: Column(
//                   children: [
//                     const Text("Powered By"),
//                     Container(
//                       height: height(context, 0.09),
//                       width: width(context, 0.09),
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("assets/logo.png"),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:evpoint/pages/overview.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

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
            gradient: LinearGradient(
              colors: [
                Color(0xff75A944),
                Color(0xff79AC46),
                Color(0xff599621),
                Color(0xff75A944),
                Color(0xff91B95F),
                Color(0xff669F30),
                Color(0xff3F870B)
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: width * 0.2,
                top: height * 0.2,
                child:  SizedBox(
                  child: Text(
                    "Hello",
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontSize: 24.81,
                      height: 1.5,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: width * 0.2,
                top: height * 0.254,
                child:  SizedBox(
                  child: Text(
                    'NAMO',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontSize: 64.84,
                      height: 1,
                      letterSpacing: -4.59,
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
                      gradient: LinearGradient(colors: [
                        Color(0xffD9D9D9), Color(0xffFFFFFF)
                      ],
                      begin: Alignment.topRight, 
                      end: Alignment.bottomLeft
                      ),
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
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isLocked = !_isLocked;
                      });

                      // Adding a delay to allow the UI to update
                      if (!_isLocked) {
                        await Future.delayed(const Duration(milliseconds: 300));
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Overview(),
                            ),
                          );
                        }
                        _isLocked = true;
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                top: height * 0.86,
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