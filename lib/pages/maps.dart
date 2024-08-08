import 'package:evpoint/widgets/autosuggest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  MapmyIndiaMapController? _controller;
  final Location _location = Location();
  LatLng? _currentLocation;
  Symbol? _currentLocationSymbol;
  bool showAutoSuggestWidget = false;

  static const String MAP_SDK_KEY = "8d6575c7a835972edece51fe1ecd6a5b";
  static const String REST_API_KEY = "8d6575c7a835972edece51fe1ecd6a5b";
  static const String ATLAS_CLIENT_ID =
      "96dHZVzsAusSZnNdvHTKt3kM6hJynLHd4m5XvWN_uO2i4Xc8s5h6O29bFn8E4Jvh7jdJaFQ8UqaDCq1Gl48gcG4YnugYnMx3";
  static const String ATLAS_CLIENT_SECRET =
      "lrFxI-iSEg8XPsyflh-PlAK4sQ_9HQtr78n2Ws2b6doXIwvz4wnwQXXlNSabrRfnOBfQUHjjliHbNK34DRDSsUMwiLF74PbVzhldCe9vSzQ=";

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();

    MapmyIndiaAccountManager.setMapSDKKey(MAP_SDK_KEY);
    MapmyIndiaAccountManager.setRestAPIKey(REST_API_KEY);
    MapmyIndiaAccountManager.setAtlasClientId(ATLAS_CLIENT_ID);
    MapmyIndiaAccountManager.setAtlasClientSecret(ATLAS_CLIENT_SECRET);
  }

  Future<void> _fetchCurrentLocation() async {
    final locationData = await _location.getLocation();
    setState(() {
      _currentLocation =
          LatLng(locationData.latitude!, locationData.longitude!);
      if (_controller != null && _currentLocation != null) {
        _addCurrentLocationMarker(_currentLocation!);
      }
    });
  }

  Future<void> _addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return _controller!.addImage(name, list);
  }

  void _addCurrentLocationMarker(LatLng position) async {
    await _addImageFromAsset("current_location_icon", "assets/marker.png");
    if (_currentLocationSymbol != null) {
      _controller!.removeSymbol(_currentLocationSymbol!);
    }
    _currentLocationSymbol = await _controller!.addSymbol(
      SymbolOptions(
        geometry: position,
        iconImage: "current_location_icon",
        iconSize: 1.0,
      ),
    );
  }

  void _onMapCreated(MapmyIndiaMapController controller) {
    _controller = controller;
    if (_currentLocation != null) {
      _addCurrentLocationMarker(_currentLocation!);
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
            children: [
              _currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : MapmyIndiaMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation!,
                        zoom: 14.0,
                      ),
                      onStyleLoadedCallback: () {
                        // if (_currentLocation != null) {
                        //   _addCurrentLocationMarker(_currentLocation!);
                        // }
                        setState(() {
                          showAutoSuggestWidget = true;
                        });
                      },
                    ),
              showAutoSuggestWidget && _controller != null
                  ? Autosuggest(controller: _controller!)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
