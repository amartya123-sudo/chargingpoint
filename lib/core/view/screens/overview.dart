import 'package:flutter/material.dart';
import 'package:evpoint/core/view/screens/blank.dart';
import 'package:evpoint/core/view/screens/maps.dart';
import 'package:evpoint/core/utils/dimension_util.dart';
import 'package:evpoint/core/view/screens/dashboard.dart';
import 'package:evpoint/core/services/background_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isPressed = false;
  bool _isLocked = false;

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
      pageBuilder: (context, animation, secondaryAnimation) =>
          const Dashboard(),
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
                const SizedBox(height: 20),
                _isListening
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BlankPage()),
        );
        break;
      case 1:
        _onGPSButtonPressed(context);
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BlankPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BlankPage()),
        );
        break;
    }
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
                top: DimensionUtil.height(context, 0.395),
                left: DimensionUtil.width(context, 0.074),
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
                top: DimensionUtil.height(context, 0.41),
                left: DimensionUtil.width(context, 0.074),
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
                top: DimensionUtil.height(context, 0.6),
                left: DimensionUtil.width(context, 0.074),
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
                bottom: DimensionUtil.height(context, -0.025),
                left: DimensionUtil.width(context, 0.45),
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
                top: DimensionUtil.height(context, 0.75),
                left: DimensionUtil.width(context, 0.2),
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
                    height: DimensionUtil.height(context, 0.141),
                    width: DimensionUtil.width(context, 0.635),
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
                top: DimensionUtil.height(context, 0.328),
                left: DimensionUtil.width(context, 0.59),
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
                top: DimensionUtil.height(context, 0.205),
                left: DimensionUtil.width(context, 0.421),
                child: Container(
                  height: DimensionUtil.height(context, 0.6),
                  width: DimensionUtil.width(context, 0.5),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: DimensionUtil.height(context, 0.069),
                right: DimensionUtil.width(context, 0.09),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  child: const Icon(Icons.mic),
                  onPressed: () {
                    _showListeningModal(context);
                    _listen(context);
                  },
                ),
              ),
              Positioned(
                top: DimensionUtil.height(context, 0.05),
                left: DimensionUtil.width(context, 0.03),
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
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent, // Transparent container
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // Remove shadow
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed),
              label: 'GPS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Apps',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'Contact',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
