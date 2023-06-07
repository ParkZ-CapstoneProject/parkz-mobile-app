import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ParkingImage extends StatefulWidget {
  final List<String> imageUrls;
  const ParkingImage({Key? key, required this.imageUrls}) : super(key: key);

  @override
  State<ParkingImage> createState() => _ParkingImageState();
}

class _ParkingImageState extends State<ParkingImage> {
  int _currentImage = 0;
  late PageController _imageController;

  @override
  void initState() {
    _imageController = PageController(initialPage: _currentImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Stack(children: [
        PageView.builder(
          controller: _imageController,
          itemCount: widget.imageUrls.length,
          onPageChanged: (int page) {
            setState(() {
              _currentImage = page;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              widget.imageUrls[index],
              fit: BoxFit.cover,
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: MediaQuery.of(context).size.width / 2.5,
          child: SmoothPageIndicator(
            controller: _imageController,
            count: widget.imageUrls.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: AppColor.orange,
              dotColor: AppColor.fadeText,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 3,
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: _buildPageIndicator(),
          // ),
        )
      ]),
    );
  }
}
