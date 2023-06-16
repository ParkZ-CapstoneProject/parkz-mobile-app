import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final String apiKey = 'ulGtxtkmCd8rrbnU2bzRW5FBKYkbKkFL';




  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const SemiBoldText(text: 'Vị trí', fontSize: 20, color: AppColor.forText),
        ),
        body: Center(
            child: Stack(
              children: <Widget>[
                FlutterMap(
                  options: MapOptions(
                    rotation: 0.0,
                      center: LatLng(10.762622, 106.660172),
                      zoom: 13.0),
                  nonRotatedChildren: [
                    //  WMSTileLayerOptions(
                    //   urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                    //       "{z}/{x}/{y}.png?key={apiKey}",
                    //   additionalOptions: {"apiKey": apiKey},
                    // )
                  ],
                )
              ],
            )),
      ),
    );
  }

}
