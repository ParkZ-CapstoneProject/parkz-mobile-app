import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:parkz/access_deny.dart';
import 'package:parkz/introduction/introduction_page.dart';
import 'package:parkz/utils/preference_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Truy cập vị trí bị từ chối, hãy cấp quyền truy cập để vào ứng dụng');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getLatLong(context) {
    Future<Position> data = _determinePosition();
    data.then((value) async {
      print("value $value");
      await PreferenceManager.setLatitude(value.latitude);
      await PreferenceManager.setLongitude(value.longitude);
      getAddress(value.latitude, value.longitude);

      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   const IntroductionPage()));
    }

    ).catchError((error) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   DenyPage(errorMessage: error,)));
    });
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    String address = '';
    address = "${placemarks[0].street!} ${placemarks[0].subAdministrativeArea!} ${placemarks[0].administrativeArea!}";
    await PreferenceManager.setAddress(address);
    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    getLatLong(context);
    return Scaffold(
      backgroundColor: AppColor.navy,
      body: Center(
        child: Lottie.asset('assets/logo/data.json'),
      ),
    );
  }
}
