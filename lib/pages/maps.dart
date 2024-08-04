import 'dart:convert';

import 'package:evpoint/schema/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:evpoint/util/dim.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  MapmyIndiaMapController? _controller;
  final Location _location = Location();
  late TextEditingController _searchController;
  LatLng? _currentLocation;
  Symbol? _currentLocationSymbol;
  List<String> suggestions = [];

  static const String MAP_SDK_KEY = "8d6575c7a835972edece51fe1ecd6a5b";
  static const String REST_API_KEY = "8d6575c7a835972edece51fe1ecd6a5b";
  static const String ATLAS_CLIENT_ID =
      "96dHZVzsAusSZnNdvHTKt3kM6hJynLHd4m5XvWN_uO2i4Xc8s5h6O29bFn8E4Jvh7jdJaFQ8UqaDCq1Gl48gcG4YnugYnMx3";
  static const String ATLAS_CLIENT_SECRET =
      "lrFxI-iSEg8XPsyflh-PlAK4sQ_9HQtr78n2Ws2b6doXIwvz4wnwQXXlNSabrRfnOBfQUHjjliHbNK34DRDSsUMwiLF74PbVzhldCe9vSzQ=";

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
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

  void _getCurrentLocation() async {
    final locationData = await _location.getLocation();
    final newLocation = LatLng(locationData.latitude!, locationData.longitude!);
    setState(() {
      _currentLocation = newLocation;
    });
    _controller!.moveCamera(
      CameraUpdate.newLatLng(newLocation),
    );
    _addCurrentLocationMarker(newLocation);
  }

  void _fetchNearbyPlaces(LatLng latlng) async {
    try {
      NearbyResponse? nearbyResponse =
          await MapmyIndiaNearby(keyword: "Charging Station", location: latlng)
              .callNearby();
      if (nearbyResponse != null && nearbyResponse.suggestedLocations != null) {
        for (var place in nearbyResponse.suggestedLocations!) {
          _controller!.addSymbol(
            SymbolOptions(
              geometry: LatLng(place.latitude!, place.longitude!),
              iconImage: "nearby_place_icon",
              iconSize: 1.0,
            ),
          );
        }
      }
    } catch (e) {
      if (e is PlatformException) {
        print(e.code);
      } else {
        print(e.toString());
      }
    }
  }

  void _getNearbyPlaces() async {
    final locationData = await _location.getLocation();
    _fetchNearbyPlaces(LatLng(locationData.latitude!, locationData.longitude!));
  }

  void fetchSuggestions(String query) {
    MapmyIndiaAutoSuggest(query: query).callAutoSuggest().then((response) {
      // // Print the raw response for debugging
      // print('Raw response: $response');

      // // Check the type of the response
      // print('Response type: ${response.runtimeType}');

      // // Assuming response is a String, you may need to preprocess and convert it to JSON
      // if (response is String) {
      //   try {
      //     // Decode the JSON string
      //     final data = jsonDecode(response as String);

      //     // Parse the response using the AutoSuggestResponse class
      //     final autoSuggestResponse = AutoSuggestResponse.fromJson(data);

      //     // Update the state with the parsed suggestions
      //     setState(() {
      //       suggestions = autoSuggestResponse.suggestedLocations.cast<String>();
      //     });
      //   } catch (e) {
      //     print('Error parsing response: $e');
      //   }
      // } else {
      //   print('Unexpected response type: ${response.runtimeType}');
      // }
      setState(() {
        final sugLocation = response;
        print(sugLocation);
      });
    }).onError((error, stackTrace) {
      print('Error: $error');
    });

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
                        if (_currentLocation != null) {
                          _addCurrentLocationMarker(_currentLocation!);
                        }
                      },
                    ),
              Positioned(
                top: height(context, 0.0),
                left: width(context, 0.0),
                right: width(context, 0.0),
                child: Container(
                  width: width(context, 1),
                  height: height(context, 0.18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (text) {
                            fetchSuggestions(text);
                          },
                          decoration: InputDecoration(
                            labelText: 'Search for a location',
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: suggestions.length,
                      //     itemBuilder: (context, index) {
                      //       final suggestion = suggestions[index];
                      //       return ListTile(
                      //         title: Text(suggestion.placeName),
                      //         subtitle: Text(suggestion.addr),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
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

// class AutoSuggestResponse {
//   final List<SuggestedLocation> suggestedLocations;

//   AutoSuggestResponse({required this.suggestedLocations});

//   factory AutoSuggestResponse.fromJson(Map<String, dynamic> json) {
//     return AutoSuggestResponse(
//       suggestedLocations: (json['suggestedLocations'] as List)
//           .map((i) => SuggestedLocation.fromJson(i))
//           .toList(),
//     );
//   }
// }
