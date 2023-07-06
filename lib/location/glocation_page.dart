import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkz/location/search_page.dart';
import 'package:parkz/utils/loading/loading_page.dart';

import '../network/api.dart';
import '../utils/preference_manager.dart';

class GLocationPage extends StatefulWidget {
  const GLocationPage({Key? key}) : super(key: key);

  @override
  State<GLocationPage> createState() => _GLocationPageState();
}

class _GLocationPageState extends State<GLocationPage> {
  double? long;
  double? lat;
  final _searchController = TextEditingController();
  List<String> _suggestions = [];

  final Map<String, Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  final List<Map<String, dynamic>> clityList = const [
    {
      "address": "Jaipur the pink city",
      "id": "jaipur_01",
      "image":
          "https://i.pinimg.com/originals/b7/3a/13/b73a132e165978fa07c6abd2879b47a6.png",
      "lat": 10.922070,
      "lng": 106.778885,
      "name": "Jaipur India",
      "phone": "7014333352",
      "region": "South Asia"
    },
    {
      "address": "New Delhi capital of india",
      "id": "delhi_02",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": 10.644800,
      "lng": 106.216721,
      "name": "Delhi City India",
      "phone": "7014333352",
      "region": "South Asia"
    },
    {
      "address": "Mumbai City",
      "id": "mumbai_03",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/7/7e/Mumbai_Taj.JPG",
      "lat": 10.076090,
      "lng": 106.877426,
      "name": "Mumbai City India",
      "phone": "7014333352",
      "region": "South Asia"
    },
    {
      "address": "Udaipur City",
      "id": "udaipur_04",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/6/6f/Evening_view%2C_City_Palace%2C_Udaipur.jpg",
      "lat": 10.571270,
      "lng": 106.691544,
      "name": "Udaipur City India",
      "phone": "7014333352",
      "region": "South Asia"
    },
    {
      "address": "Nepal Country",
      "id": "nepal_5",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/6/6f/Evening_view%2C_City_Palace%2C_Udaipur.jpg",
      "lat": 10.394857,
      "lng": 106.124008,
      "name": "Nepal",
      "phone": "7014333352",
      "region": "South Asia"
    }
  ];

  void getLatLong() async {
    double? storeLat = await PreferenceManager.getLatitude();
    double? storeLong = await PreferenceManager.getLongitude();

    setState(() {
      lat = storeLat;
      long = storeLong;
    });
  }

  void _currentLocation() async {
    Future<Position> data =  Geolocator.getCurrentPosition();
    data.then((value) async {
      print("value $value");
      await PreferenceManager.setLatitude(value.latitude);
      await PreferenceManager.setLongitude(value.longitude);

    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(lat!,long!),
        zoom: 17.0,
      ),
    ));
  }

  void getSuggestions(String query) {
    if (query.isNotEmpty) {
      fetchSuggestions(query).then((suggestions) {
        setState(() {
          _suggestions = suggestions;
        });
      }).catchError((error) {
        print('error ne');
        print(error);
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    _controller.complete(controller);
    // setState(() {
    //   for (int i = 0; i < clityList.length; i++) {
    //     print("For Loop");
    //     final marker = Marker(
    //       markerId: MarkerId(clityList[i]['name']),
    //       position: LatLng(clityList[i]['lat'], clityList[i]['lng']),
    //       infoWindow: InfoWindow(
    //           title: clityList[i]['name'],
    //           snippet: clityList[i]['address'],
    //           onTap: () {
    //             print("${clityList[i]['lat']}, ${clityList[i]['lng']}");
    //           }),
    //       onTap: () {
    //         print("Clicked on marker");
    //       },
    //     );
    //     print("${clityList[i]['lat']}, ${clityList[i]['lng']}");
    //     _markers[clityList[i]['name']] = marker;
    //   }
    // });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatLong();
  }


  @override
  Widget build(BuildContext context) {
    if (lat == null || long == null) {
      // Return a loading indicator or handle the case when lat/long is null
      return const LoadingPage();
    } else {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(lat!, long!),
              zoom: 15,
            ),
            markers: _markers.values.toSet(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 16),
            child: Column(
              children: [
                Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/icon/map-pin-selected.svg',
                            width: 20, height: 20),
                      ),
                       Expanded(
                        child: TextField(
                          controller: _searchController,
                          readOnly: true,
                          onTap: () async {
                            // generate a new token here
                            final String? result = await showSearch(
                              context: context,
                              delegate: AddressSearch(),
                            );
                            // This will change the text displayed in the TextField
                            if (result != null) {
                              setState(() {
                                _searchController.text = result;
                              });
                            }
                          },
                          onChanged: getSuggestions,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Điểm đến của bạn là ...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _suggestions.isNotEmpty ?
                Expanded(
                  child: ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(_suggestions[index]),
                          onTap: () {
                            // Handle the selected location
                            print(_suggestions[index]);
                          },
                        ),
                      );
                    },
                  ),
                ) : const SizedBox(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _currentLocation,
        child: const Icon(Icons.location_searching_rounded),
      ),
    );
    }
  }
}

