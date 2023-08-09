import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class RatingPop extends StatefulWidget {
  final int bookingID;
  final int parkingID;
  const RatingPop({Key? key, required this.bookingID, required this.parkingID}) : super(key: key);

  @override
  State<RatingPop> createState() => _RatingPopState();
}

class _RatingPopState extends State<RatingPop> {
  late int cusStar = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.25,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      child: CustomPaint(
                        size: Size(size.width, 250),
                        painter: HalfCirclePainter(),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 55),
                        const SemiBoldText(text: 'Đánh giá bãi xe', fontSize: 15, color: AppColor.forText),
                        const SizedBox(height: 8,),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            shadows: <Shadow>[Shadow(color: Colors.grey, blurRadius: 15.0)],
                            Icons.star_rounded,
                            color: AppColor.orange,
                          ),
                          onRatingUpdate: (rating) {
                            cusStar = rating.toInt();
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColor.navyPale
                          ),
                          child: const Center(child: SemiBoldText(text: 'Xin cảm ơn quý khách đã sử dụng dịch vụ', fontSize: 14, color: AppColor.forText)),
                        ),
                        Container(
                          width: double.infinity,
                          height: 35,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: MyButton(text: 'Gửi', function: () async {
                            bool isSucccess = await ratingBooking(widget.bookingID, cusStar, widget.parkingID);
                            Navigator.pop(context, isSucccess);

                          }, textColor: Colors.white, backgroundColor: AppColor.orange, borderRadius: 10),
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25 - 35,
              left: MediaQuery.of(context).size.width * 0.5 - 35,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE3CC),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: AppColor.orange, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path path = Path();
    path.quadraticBezierTo(size.width * 0.37, 0, size.width * 0.37, 0);
    path.arcToPoint(Offset(size.width * 0.63, 0), radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(5, size.height);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);



  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}