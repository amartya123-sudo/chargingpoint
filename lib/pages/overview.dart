// import 'package:evpoint/pages/blank.dart';
// import 'package:evpoint/pages/maps.dart';
// import 'package:flutter/material.dart';
// import 'package:evpoint/util/dim.dart';
// import 'package:evpoint/pages/dashboard.dart';
// import 'package:evpoint/service/background_service.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class Overview extends StatefulWidget {
//   const Overview({super.key});

//   @override
//   _OverviewState createState() => _OverviewState();
// }

// class _OverviewState extends State<Overview>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _isPressed = false;

//   final BackendService backendService = BackendService();
//   String _text = '';

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     )..addListener(() {
//         setState(() {});
//       });
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//   }

//   void _listen() {
//     backendService.listen(
//       (text) {
//         setState(() {
//           _text = text;
//           if (_text.isNotEmpty) {
//             backendService.getResponse(_text, (response) {
//               backendService.speak(response);
//             }, (error) {
//               print(error);
//             });
//           }
//         });
//       },
//       () => print("Error occurred."),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onTap() {
//     setState(() {
//       _isPressed = !_isPressed;
//       _controller.forward().then((value) => _navigateToPreviousPage());
//     });
//   }

//   void _navigateToPreviousPage() {
//     Navigator.of(context).pop(_createRoute());
//   }

//   Future<void> _onGPSButtonPressed(BuildContext context) async {
//     _navigateToMapsPage(context);
//     FlutterTts().speak("GPS Navigation");
//   }

//   void _navigateToMapsPage(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const Maps()),
//     );
//   }

//   Route _createRoute() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const Dashboard(),
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
//                 top: height(context, 0.395),
//                 left: width(context, 0.074),
//                 child: const SizedBox(
//                   child: Text(
//                     'LET\'S RIDE THE',
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
//                 top: height(context, 0.41),
//                 left: width(context, 0.074),
//                 child: const SizedBox(
//                   width: 972,
//                   height: 179.15,
//                   child: Text(
//                     'FUTURE',
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
//                 top: height(context, 0.6),
//                 left: width(context, 0.074),
//                 child: const SizedBox(
//                   child: Text(
//                     'Innovation & You',
//                     style: TextStyle(
//                       color: Color(0xFF42454A),
//                       fontSize: 18.37,
//                       fontFamily: 'Inter',
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: height(context, -0.025),
//                 left: width(context, 0.45),
//                 child: ClipOval(
//                   child: Container(
//                     height: 1400,
//                     width: 1500,
//                     decoration: const ShapeDecoration(
//                       color: Color(0xFF9ADFD4),
//                       shape: OvalBorder(),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.069),
//                 left: width(context, 0.25),
//                 child: ClipRect(
//                   child: Container(
//                     width: width(context, 0.364),
//                     color: Colors.transparent,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const BlankPage(),
//                               ),
//                             );
//                             FlutterTts().speak("Profile");
//                           },
//                           child: const Text(
//                             'Profile',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () => _onGPSButtonPressed(context),
//                           child: const Text(
//                             'GPS',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const BlankPage(),
//                               ),
//                             );
//                             FlutterTts().speak("APPS");
//                           },
//                           child: const Text(
//                             'APPS',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const BlankPage(),
//                               ),
//                             );
//                             FlutterTts().speak("Contact");
//                           },
//                           child: const Text(
//                             'CONTACT',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.8),
//                 left: width(context, 0.2),
//                 child: ClipRect(
//                   child: Container(
//                     decoration: ShapeDecoration(
//                       color: const Color(0x267DB9CE),
//                       shape: RoundedRectangleBorder(
//                         side: const BorderSide(
//                             width: 1.50, color: Color(0x5B86C4D9)),
//                         borderRadius: BorderRadius.circular(17.11),
//                       ),
//                     ),
//                     height: height(context, 0.141),
//                     width: width(context, 0.635),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           '26°c\nTemperature',
//                           style: TextStyle(
//                             color: Color(0xFF3A3A3A),
//                             fontSize: 16.24,
//                             fontFamily: 'Inter',
//                           ),
//                         ),
//                         Text(
//                           '50km/h\nSpeed',
//                           style: TextStyle(
//                             color: Color(0xFF3A3A3A),
//                             fontSize: 16.24,
//                             fontFamily: 'Inter',
//                           ),
//                         ),
//                         Text(
//                           '80km\nBattery Range',
//                           style: TextStyle(
//                             color: Color(0xFF3A3A3A),
//                             fontSize: 16.24,
//                             fontFamily: 'Inter',
//                           ),
//                         ),
//                         Text(
//                           '3.5Hr\nCharging Time',
//                           style: TextStyle(
//                             color: Color(0xFF3A3A3A),
//                             fontSize: 16.24,
//                             fontFamily: 'Inter',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.328),
//                 left: width(context, 0.59),
//                 child: const SizedBox(
//                   child: Text(
//                     'EV-2',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 175,
//                       fontFamily: 'Familjen Grotesk',
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.205),
//                 left: width(context, 0.421),
//                 child: Container(
//                   height: height(context, 0.6),
//                   width: width(context, 0.5),
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/image.png"),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: height(context, 0.069),
//                 // left: width(context, 0.9),
//                 right: width(context, 0.09),
//                 child: ElevatedButton(
//                   child: const Icon(Icons.mic),
//                   onPressed: () {
//                     _listen();
//                   },
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
//                 top: height(context, 0.05),
//                 left: width(context, 0.03),
//                 child: GestureDetector(
//                   onTap: _onTap,
//                   child: Transform.rotate(
//                     angle: _animation.value * 6.3, // 2 * pi for a full rotation
//                     child: ClipOval(
//                       child: Container(
//                         width: width(context, 0.1),
//                         height: height(context, 0.1),
//                         decoration: const ShapeDecoration(
//                           color: Color.fromARGB(54, 42, 31, 31),
//                           shape: OvalBorder(),
//                         ),
//                         child: Transform(
//                           transform: Matrix4.identity()
//                             ..translate(0.0, 0.0)
//                             ..rotateZ(0.01),
//                           child: const Icon(
//                             size: 70,
//                             Icons.lock,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:evpoint/pages/blank.dart';
import 'package:evpoint/pages/maps.dart';
import 'package:flutter/material.dart';
import 'package:evpoint/util/dim.dart';
import 'package:evpoint/pages/dashboard.dart';
import 'package:evpoint/service/background_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isPressed = false;

  final BackendService backendService = BackendService();
  String _text = '';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _listen(BuildContext context) {
    setState(() {
      _isListening = true;
    });

    backendService.listen(
      (text) {
        setState(() {
          _text = text;
          if (_text.isNotEmpty) {
            backendService.getResponse(_text, (response) {
              backendService.speak(response);
            }, (error) {
              print(error);
            });
          }
        });
      },
      () {
        // When listening stops, close the modal
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        setState(() {
          _isListening = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _isPressed = !_isPressed;
      _controller.forward().then((value) => _navigateToPreviousPage());
    });
  }

  void _navigateToPreviousPage() {
    Navigator.of(context).pop(_createRoute());
  }

  Future<void> _onGPSButtonPressed(BuildContext context) async {
    _navigateToMapsPage(context);
    FlutterTts().speak("GPS Navigation");
  }

  void _navigateToMapsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Maps()),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Dashboard(),
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

  void _showListeningModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Listening...',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _isListening                            // Animation not working properly
                    ? AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            _text,
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 1,
                      )
                    : Container(),
              ],
            ),
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
                top: height(context, 0.395),
                left: width(context, 0.074),
                child: const SizedBox(
                  child: Text(
                    'LET\'S RIDE THE',
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
                top: height(context, 0.41),
                left: width(context, 0.074),
                child: const SizedBox(
                  width: 972,
                  height: 179.15,
                  child: Text(
                    'FUTURE',
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
                top: height(context, 0.6),
                left: width(context, 0.074),
                child: const SizedBox(
                  child: Text(
                    'Innovation & You',
                    style: TextStyle(
                      color: Color(0xFF42454A),
                      fontSize: 18.37,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height(context, -0.025),
                left: width(context, 0.45),
                child: ClipOval(
                  child: Container(
                    height: 1400,
                    width: 1500,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF9ADFD4),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context, 0.069),
                left: width(context, 0.25),
                child: ClipRect(
                  child: Container(
                    width: width(context, 0.364),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlankPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _onGPSButtonPressed(context),
                          child: const Text(
                            'GPS',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlankPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'APPS',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlankPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'CONTACT',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context, 0.8),
                left: width(context, 0.2),
                child: ClipRect(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color(0x267DB9CE),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1.50, color: Color(0x5B86C4D9)),
                        borderRadius: BorderRadius.circular(17.11),
                      ),
                    ),
                    height: height(context, 0.141),
                    width: width(context, 0.635),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '26°c\nTemperature',
                          style: TextStyle(
                            color: Color(0xFF3A3A3A),
                            fontSize: 16.24,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          '50km/h\nSpeed',
                          style: TextStyle(
                            color: Color(0xFF3A3A3A),
                            fontSize: 16.24,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          '80km\nBattery Range',
                          style: TextStyle(
                            color: Color(0xFF3A3A3A),
                            fontSize: 16.24,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          '3.5Hr\nCharging Time',
                          style: TextStyle(
                            color: Color(0xFF3A3A3A),
                            fontSize: 16.24,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context, 0.328),
                left: width(context, 0.59),
                child: const SizedBox(
                  child: Text(
                    'EV-2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 175,
                      fontFamily: 'Familjen Grotesk',
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context, 0.205),
                left: width(context, 0.421),
                child: Container(
                  height: height(context, 0.6),
                  width: width(context, 0.5),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image.png"),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context, 0.069),
                right: width(context, 0.09),
                child: ElevatedButton(
                  child: const Icon(Icons.mic),
                  onPressed: () {
                    _showListeningModal(context);
                    _listen(context);
                  },
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
                top: height(context, 0.05),
                left: width(context, 0.03),
                child: GestureDetector(
                  onTap: _onTap,
                  child: Transform.rotate(
                    angle: _animation.value * 6.3, // 2 * pi for a full rotation
                    child: ClipOval(
                      child: Container(
                        width: width(context, 0.1),
                        height: height(context, 0.1),
                        decoration: const ShapeDecoration(
                          color: Color.fromARGB(54, 42, 31, 31),
                          shape: OvalBorder(),
                        ),
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(0.01),
                          child: const Icon(
                            size: 70,
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
