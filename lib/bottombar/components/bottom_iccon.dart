import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomIcon extends StatelessWidget {
  final String url;
   const BottomIcon({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(url, height: 26,width: 26),
    );
  }
}
