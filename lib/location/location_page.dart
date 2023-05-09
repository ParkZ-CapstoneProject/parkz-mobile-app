import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final String apiKey = 'ulGtxtkmCd8rrbnU2bzRW5FBKYkbKkFL';
  MapController mapController = MapController();




  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        body: Center(
            child: Stack(
              children: <Widget>[
                FlutterMap(
                  mapController: mapController,


                  options: MapOptions(
                    rotation: 0.0,
                      center: latLng.LatLng(52.376372, 4.908066),
                      zoom: 13.0),

                  layers: [

                     TileLayerOptions(


                      urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                          "{z}/{x}/{y}.png?key={apiKey}",
                      additionalOptions: {"apiKey": apiKey},
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

}
