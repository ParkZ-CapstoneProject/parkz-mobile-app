import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parkz/parkingdetail/parking_detail_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ParkingCardHome extends StatefulWidget {
  final int id;
  final String title;
  final String? imagePath;
  final double? rating;
  final double? carPrice;
  final double? motoPrice;
  final String address;
  final bool isFavorite;
  const ParkingCardHome({Key? key, required this.title,  this.imagePath, required this.rating, required this.address, required this.isFavorite, required this.id, this.carPrice, this.motoPrice}) : super(key: key);

  @override
  State<ParkingCardHome> createState() => _ParkingCardHomeState();
}

class _ParkingCardHomeState extends State<ParkingCardHome> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _isFavorited = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = 146;
    double cardBorder = 12;

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   ParkingDetailPage(id: widget.id,)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 18),
        child: Container(
          height: cardHeight,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white, borderRadius: BorderRadius.circular(cardBorder)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(cardBorder), bottomLeft:Radius.circular(cardBorder) ),
                  child: Image.network(
                    widget.imagePath != null ? widget.imagePath! : 'https://ma-hub.imgix.net/wp-images/2019/11/17203220/final-cut-pro-missing-file.jpg?w=1600&h=850&auto=format',
                    fit: BoxFit.cover,
                    height: cardHeight,
                    width: double.infinity,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    RegularText(text: widget.rating.toString(), fontSize: 12 , color: AppColor.forText),
                                    const Icon(Icons.star_rounded, color: AppColor.orange, size: 16,),
                                  ],
                                ),
                                IconButton(

                                  constraints: const BoxConstraints(),
                                  icon: _isFavorited
                                      ? const Icon(CupertinoIcons.suit_heart, size: 16,)
                                      : const Icon(CupertinoIcons.suit_heart_fill, size: 16, color: Colors.red),
                                  onPressed: () {
                                    _toggleFavorite();
                                  },
                                ),
                              ],
                            ),
                            SemiBoldText(text: widget.title, fontSize: 17, color: Colors.black, maxLine: 1, align: TextAlign.left),
                            const SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: RegularText(text:  widget.address, fontSize: 13, color: Colors.black, maxLine: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.carPrice != null
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icon/car.svg',
                                  width: 20, height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SemiBoldText(
                                    text:
                                    '${NumberFormat('#,###').format(widget.carPrice?.toInt()).replaceAll(',', '.')}đ',
                                    fontSize: 12,
                                    color: AppColor.forText),
                              ),
                            ],
                          )
                              : const SizedBox(),
                          widget.motoPrice != null
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icon/bike.svg',
                                  width: 20, height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SemiBoldText(
                                    text:
                                    '${NumberFormat('#,###').format(widget.carPrice?.toInt()).replaceAll(',', '.')}đ',
                                    fontSize: 12,
                                    color: AppColor.forText),
                              ),
                            ],
                          )
                              : const SizedBox()
                        ],
                      ),

                    ],
                  ),
                ),


              )
            ],
          ),
        ),
      ),
    );
  }


}


