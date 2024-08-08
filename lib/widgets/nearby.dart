// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';

// class NearbyWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return NearbyWidgetState();
//   }
// }

// class NearbyWidgetState extends State<NearbyWidget> {
//   TextEditingController locationController = TextEditingController();
//   TextEditingController keywordController = TextEditingController(text: "Tea");
//   static final CameraPosition _kInitialPosition = const CameraPosition(
//     target: LatLng(25.321684, 82.987289),
//     zoom: 14.0,
//   );

//   static const String MAP_SDK_KEY = "8d6575c7a835972edece51fe1ecd6a5b";
//   static const String REST_API_KEY = "8d6575c7a835972edece51fe1ecd6a5b";
//   static const String ATLAS_CLIENT_ID =
//       "96dHZVzsAusSZnNdvHTKt3kM6hJynLHd4m5XvWN_uO2i4Xc8s5h6O29bFn8E4Jvh7jdJaFQ8UqaDCq1Gl48gcG4YnugYnMx3";
//   static const String ATLAS_CLIENT_SECRET =
//       "lrFxI-iSEg8XPsyflh-PlAK4sQ_9HQtr78n2Ws2b6doXIwvz4wnwQXXlNSabrRfnOBfQUHjjliHbNK34DRDSsUMwiLF74PbVzhldCe9vSzQ=";

//   @override
//   void initState() {
//     super.initState();
//     MapmyIndiaAccountManager.setMapSDKKey(MAP_SDK_KEY);
//     MapmyIndiaAccountManager.setRestAPIKey(REST_API_KEY);
//     MapmyIndiaAccountManager.setAtlasClientId(ATLAS_CLIENT_ID);
//     MapmyIndiaAccountManager.setAtlasClientSecret(ATLAS_CLIENT_SECRET);
//   }

//   List<NearbyResult> result = [];
//   bool isShowList = false;
//   late MapmyIndiaMapController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Nearby API',
//           style: TextStyle(color: Colors.white),
//         ),
//         elevation: 0.2,
//       ),
//       body: Stack(children: <Widget>[
//         RepaintBoundary(
//           child: MapmyIndiaMap(
//             initialCameraPosition: _kInitialPosition,
//             onMapCreated: (map) => {
//               controller = map,
//             },
//             onMapLongClick: (point, latlng) {
//               locationController.text = '${latlng.latitude},${latlng.longitude}';
//               nearby();
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: RepaintBoundary(
//             child: Container(
//               padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//               child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text("Location:"),
//                           flex: 1,
//                         ),
//                         Expanded(
//                             flex: 2,
//                             child: TextFormField(
//                               controller: locationController,
//                               decoration: InputDecoration(
//                                   hintText: "Lat,Lng/ELOC",
//                                   fillColor: Colors.white),
//                             ))
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(child: Text("Keyword:"), flex: 1),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                             child: TextFormField(
//                               controller: keywordController,
//                               decoration: InputDecoration(
//                                   hintText: "e.g.,Tea", fillColor: Colors.white),
//                             ),
//                             flex: 2)
//                       ],
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           if (locationController.text.isNotEmpty &&
//                               keywordController.text.isNotEmpty) {
//                             nearby();
//                           }
//                         },
//                         child: Text("Submit"),
//                         style: ButtonStyle(
//                             textStyle: MaterialStateProperty.all(
//                                 TextStyle(color: Colors.white))))
//                   ]),
//             ),
//           ),
//         ),
//         if (result.isNotEmpty && isShowList)
//           RepaintBoundary(
//             child: BottomSheet(
//               onClosing: () {},
//               builder: (context) => Expanded(
//                 child: ListView.builder(
//                   itemCount: result.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                         padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: ListTile(
//                           contentPadding: EdgeInsets.all(5),
//                           focusColor: Colors.white,
//                           title: Text(result[index].placeName ?? ''),
//                           subtitle: Text(
//                             result[index].placeAddress ?? '',
//                             maxLines: 2,
//                           ),
//                         ));
//                   },
//                 ),
//               ),
//             ),
//           ),
//       ]),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             isShowList = !isShowList;
//           });
//         },
//         child: isShowList ? Icon(Icons.map) : Icon(Icons.list),
//       ),
//     );
//   }

//   Future<void> addImageFromAsset(String name, String assetName) async {
//     final ByteData bytes = await rootBundle.load(assetName);
//     final Uint8List list = bytes.buffer.asUint8List();
//     return controller.addImage(name, list);
//   }

//   boundsFromLatLngList(List<LatLng> list) {
//     assert(list.isNotEmpty);
//     double? x0, x1, y0, y1;
//     for (LatLng latLng in list) {
//       if (x0 == null || x1 == null || y0 == null || y1 == null) {
//         x0 = x1 = latLng.latitude;
//         y0 = y1 = latLng.longitude;
//       } else {
//         if (latLng.latitude > x1) x1 = latLng.latitude;
//         if (latLng.latitude < x0) x0 = latLng.latitude;
//         if (latLng.longitude > y1) y1 = latLng.longitude;
//         if (latLng.longitude < y0) y0 = latLng.longitude;
//       }
//     }
//     return LatLngBounds(
//         northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
//   }

//   nearby() async {
//     await addImageFromAsset("icon", "assets/marker.png");
//     await controller.clearSymbols();
//     List<NearbyResult> fetchedResults = [];
//     List<SymbolOptions> options = [];
//     List<LatLng> latlngList = [];

//     try {
//       String location = locationController.text;
//       NearbyResponse? nearbyResponse;

//       if (location.contains(",")) {
//         nearbyResponse = await MapmyIndiaNearby(
//           keyword: keywordController.text,
//           location: LatLng(double.parse(location.split(",")[0]),
//               double.parse(location.split(",")[1])),
//         ).callNearby();
//       } else {
//         nearbyResponse = await MapmyIndiaNearby(
//           keyword: keywordController.text,
//           eLoc: location,
//         ).callNearby();
//       }

//       if (nearbyResponse != null &&
//           nearbyResponse.suggestedLocations != null &&
//           nearbyResponse.suggestedLocations!.isNotEmpty) {
//         nearbyResponse.suggestedLocations?.forEach((element) {
//           latlngList.add(LatLng(element.latitude!, element.longitude!));
//           options.add(SymbolOptions(
//             geometry: LatLng(element.latitude!, element.longitude!),
//             iconImage: 'icon',
//           ));
//           fetchedResults.add(element);
//         });

//         setState(() {
//           result = fetchedResults;
//         });

//         controller.addSymbols(options);
//         controller.animateCamera(
//           CameraUpdate.newLatLngBounds(boundsFromLatLngList(latlngList),
//               top: 40),
//         );
//       }
//     } catch (e) {
//       if (e is PlatformException) {
//         Fluttertoast.showToast(msg: '${e.code} --- ${e.message}');
//       }
//     }
//   }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_nearby_plugin/mapmyindia_nearby_plugin.dart';

class NearbyUIWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NearbyUIState();
  }
}

class NearbyUIState extends State {
  NearbyResult? _nearbyResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: MyColor.colorPrimary,
          // brightness: Brightness.dark,
          title: Text(
            'Nearby UI',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.2,
        ),
        body: Center(
            child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(_nearbyResult?.distance == null? 'Distance: ':'Distance: ${_nearbyResult?.distance}'),
                  SizedBox(height: 20),
                  Text(_nearbyResult?.eLoc == null? 'ELoc: ':'ELoc: ${_nearbyResult?.eLoc}'),
                  SizedBox(height: 20),
                  Text(_nearbyResult?.placeName == null? 'Place Name: ':'Place Name: ${_nearbyResult?.placeName}'),
                  SizedBox(height: 20),
                  Text(_nearbyResult?.placeAddress == null? 'Place Address: ':'Place Address: ${_nearbyResult?.placeAddress}'),
                  SizedBox(height: 20),
                  Text(_nearbyResult?.orderIndex == null? 'Index: ':'Index: ${_nearbyResult?.orderIndex}'),
                  SizedBox(height: 20),
                  TextButton(
                      child: Text('Open Nearby Search Widget'),
                      onPressed: () => {
                        openMapmyIndiaNearbyWidget(),
                      })
                ]
            )
        ));
  }

  void openMapmyIndiaNearbyWidget() async {
    NearbyResult nearbyResult;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {

      nearbyResult = await openNearbyWidget();
    } on PlatformException {
      nearbyResult = NearbyResult();
    }
    print(json.encode(nearbyResult.toJson()));

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _nearbyResult = nearbyResult;
    });
  }

}
