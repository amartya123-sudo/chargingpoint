import 'package:flutter/material.dart';
import 'package:evpoint/core/view/screens/registration_page.dart';
import 'package:evpoint/core/view/screens/blank.dart';
import 'package:evpoint/core/view/screens/maps.dart';
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
  int _selectedIndex = 0;

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

  void _listen(BuildContext context) {
    setState(() {
      _isListening = true;
    });

    backendService.listen(
      (text) {
        setState(() {
          _text = text;
        });
        if (_text.isNotEmpty) {
          backendService.getResponse(_text, (response) {
            backendService.speak(response);
          }, (error) {
            debugPrint(error.toString());
          });
        }
      },
      () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        setState(() {
          _isListening = false;
        });
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrationPage()),
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
                bottom: height * -0.025,
                left: width * 0.45,
                child: ClipOval(
                  child: Container(
                    height: height * 1.4,
                    width: width * 1.5,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 228, 226, 226), Color(0xffFFFFFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.328,
                left: width * 0.59,
                child: const Text(
                  'EV-2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 175,
                    fontFamily: 'Familjen Grotesk',
                  ),
                ),
              ),
              Positioned(
                top: height * 0.205,
                left: width * 0.421,
                child: Container(
                  height: height * 0.6,
                  width: width * 0.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.05,
                right: width * 0.02,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  child: const Icon(Icons.mic),
                  onPressed: () {
                    _showListeningModal(context);
                    _listen(context);
                  },
                ),
              ),
              Positioned(
                top: height * 0.05,
                left: width * 0.02,
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
                      if (_isLocked) {
                        await Future.delayed(const Duration(milliseconds: 300));
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                top: height * 0.3,
                left: width * 0.15,
                child: SizedBox(
                  width: width * 0.2, // Adjust width to make the grid smaller
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4, // Reduce spacing
                    crossAxisSpacing: 4, // Reduce spacing
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
                    padding: const EdgeInsets.all(8),
                    children: [
                      _buildGridTile('26°C', 'Temperature'),
                      _buildGridTile('50km/h', 'Speed'),
                      _buildGridTile('80km', 'Battery Range'),
                      _buildGridTile('3.5Hr', 'Charging Time'),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent, // Fully transparent
                    elevation: 0, // Remove shadow
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.gps_fixed),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.apps), label: ""),
                      BottomNavigationBarItem(
                                              icon: Icon(Icons.contact_mail), label: ""),
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.black,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
}

  Widget _buildGridTile(String value, String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent.withOpacity(0.1), // Make tile transparent
          borderRadius: BorderRadius.circular(8), // Smaller rounded corners
          border: Border.all(color: const Color.fromARGB(255, 228, 226, 226), width: 2), // Optional border
          
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0, // Smaller font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0, // Smaller font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
