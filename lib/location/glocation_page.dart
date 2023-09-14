import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkz/location/search_page.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading_page.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../model/location_response.dart';
import '../model/search_parking_response.dart';
import '../parkingdetail/parking_detail_page.dart';
import '../utils/preference_manager.dart';
import '../utils/text/regular.dart';

class GLocationPage extends StatefulWidget {
  const GLocationPage({Key? key}) : super(key: key);

  @override
  State<GLocationPage> createState() => _GLocationPageState();

}

class _GLocationPageState extends State<GLocationPage> {
  double? _long;
  double? _lat;
  int prevPage = 0;
  double radiusValue = 2000.0;
  SearchParkingResponse? parkingNearby ;
  final Set<Marker> _markers = <Marker>{};
  final Set<Circle> _circle = <Circle>{};
  LocationSuggestion? destination;
  late PageController _pageController;
  final _searchController = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  void getLatLong() async {
    double? storeLat = await PreferenceManager.getLatitude();
    double? storeLong = await PreferenceManager.getLongitude();
    setState(() {
      _lat = storeLat;
      _long = storeLong;
    });
  }


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }


  void _currentLocation() async {
    Future<Position> data =  Geolocator.getCurrentPosition();
    data.then((value) async {
      await PreferenceManager.setLatitude(value.latitude);
      await PreferenceManager.setLongitude(value.longitude);
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(_lat!,_long!),
        zoom: 17.0,
      ),
    ));
  }

  Future<void> _goToDestination(LocationSuggestion des) async {
    double desLat = double.parse(des.lat!);
    double desLong = double.parse(des.lon!);
    //Move to destination
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(desLat,desLong),
        zoom: 13.5,
      ),
    ));
    //Add marker
    _addDestinationMarker(destination!);
    //Add range search to this
    _circle.add(Circle(
        circleId: const CircleId('Range'),
        fillColor: Colors.blue.withOpacity(0.1),
        radius: radiusValue,
        center: LatLng(desLat, desLong),
        strokeColor: Colors.blue,
        strokeWidth: 1
    ));
  }


  void _addParkingMarker(SearchParkingResponse parkingNearby) async  {
    _markers.clear();
    Uint8List markerIcon = await getBytesFromAsset('assets/icon/pmarker.png', 120);
    for (int i = 0; i < parkingNearby.data!.length; i++) {
      final marker = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: MarkerId(parkingNearby.data![i].getListParkingNearestWithDistanceResponse!.parkingId!.toString()),
        position: LatLng(
            parkingNearby.data![i].getListParkingNearestWithDistanceResponse!.latitude!,
            parkingNearby.data![i].getListParkingNearestWithDistanceResponse!.longitude!),
        infoWindow: InfoWindow(
            title: parkingNearby.data![i].getListParkingNearestWithDistanceResponse!.name!,
            snippet: parkingNearby.data![i].priceCar.toString(),
            onTap: () {
              print("Clicked on marker");
            }),
        onTap: () {
          print("Clicked on marker");
        },
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }

  void _addDestinationMarker(LocationSuggestion result){
    String title = result.displayName!.split(',').first;
    double lat = double.parse(result.lat!);
    double long = double.parse(result.lon!);
    _markers.add(
        Marker(
          markerId: MarkerId(title),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: title,),
        )
    );

  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    getLatLong();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85)
      ..addListener(_onScroll);

    super.initState();
  }
  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();

    }
  }


  @override
  Widget build(BuildContext context) {
    if (_lat == null || _long == null) {
      // Return a loading indicator or handle the case when lat/long is null
      return const LoadingPage();
    } else {
      return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },
              circles: _circle,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              compassEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(_lat!, _long!),
                zoom: 15,
              ),
              markers: _markers,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                        //set border radius more than 50% of height and width to make circle
                        ),
                      child: Row(
                        children: [
                          //Icon search
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('assets/icon/map-pin-selected.svg', width: 20, height: 20),
                            ),
                          ),
                          //Text
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: TextField(
                                controller: _searchController,
                                readOnly: true,
                                onTap: () async {
                                  destination = await showSearch(
                                    context: context,
                                    delegate: AddressSearch(),
                                  );

                                  if (destination != null) {
                                    double desLat = double.parse(destination!.lat!);
                                    double long = double.parse(destination!.lon!);
                                     parkingNearby =  await getParkingNearbyDestination(desLat, long, 4);
                                    setState(()  {
                                      _searchController.text = destination!.displayName!;
                                      //Move camera to location
                                      _goToDestination(destination!);
                                      //Add parking
                                      if(parkingNearby != null){
                                        _addParkingMarker(parkingNearby!);
                                      }
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Điểm đến của bạn là ...',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            parkingNearby != null ? parkingNearby!.data!.isNotEmpty ?
            AnimatedPositioned(
                bottom: 10.0,
                duration: const Duration(seconds: 1),
                curve: Curves.linear,
                child: SizedBox(
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount:  parkingNearby!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _nearbyPlacesList(index);
                      }),
                )) : const SizedBox() : const SizedBox()
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            destination != null ?
            FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: AppColor.orange,
              onPressed: () {
                _goToDestination(destination!);
              },
              child: const Icon(Icons.near_me),
            ) : const SizedBox(),
            const SizedBox(height: 10,),
            Padding(
              padding: parkingNearby != null ? parkingNearby!.data!.isNotEmpty ?  const EdgeInsets.only(bottom: 140.0) : const EdgeInsets.all(0) : const EdgeInsets.all(0),
              child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: AppColor.navy,
                onPressed: _currentLocation,
                child: const Icon(Icons.location_searching_rounded, color: AppColor.navyPale),
              ),
            ),
          ],
        ),
      );
    }
  }
  _nearbyPlacesList(index) {
    var parking = parkingNearby!.data?[index];
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>   ParkingDetailPage(id: parking.getListParkingNearestWithDistanceResponse!.parkingId!,)),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:  [
                      BoxShadow(
                          color: Colors.black54.withOpacity(0.5),
                          offset: const Offset(0.0, 4.0),
                          blurRadius: 10.0)
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        height: 120.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(parking!.getListParkingNearestWithDistanceResponse!.avatar!),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(width: 18.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 170,
                            child: SemiBoldText(
                                text: parking.getListParkingNearestWithDistanceResponse!.name!,
                                maxLine: 2,
                                fontSize: 15,
                                color: AppColor.forText),
                          ),
                          SizedBox(
                            width: 170,
                            child: parking.getListParkingNearestWithDistanceResponse!.stars != null
                                ? Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: AppColor.orange,
                                  size: 20,
                                ),
                                RegularText(
                                    text: parking.getListParkingNearestWithDistanceResponse!.stars.toString(),
                                    fontSize: 15,
                                    color: AppColor.forText),

                              ],
                            )
                                : const SizedBox(),
                          ),

                          SizedBox(
                            width: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RegularText(
                                    text: 'Cách ${double.parse(parking.distance!.toStringAsFixed(1))} km',
                                    fontSize: 12,
                                    color: AppColor.navy),

                                SemiBoldText(
                                    text: parking.priceCar!.toStringAsFixed(1),
                                    fontSize: 18,
                                    color: AppColor.navy),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

