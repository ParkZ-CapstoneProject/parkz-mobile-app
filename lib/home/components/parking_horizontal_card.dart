import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkz/parkingdetail/parking_detail_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ParkingCardHome extends StatefulWidget {
  final int indexRoom;
  final String title;
  final String imagePath;
  final double rating;
  final String price;
  final String address;
  final bool isFavorite;
  const ParkingCardHome({Key? key, required this.title, required this.imagePath, required this.rating, required this.price, required this.address, required this.isFavorite, required this.indexRoom}) : super(key: key);

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
    double cardHeight = 110;
    double cardBorder = 12;

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const ParkingDetailPage()),
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
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius:  BorderRadius.only(topLeft: Radius.circular(cardBorder), bottomLeft:Radius.circular(cardBorder) ),
                      child: Image.network(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        height: cardHeight,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8, right: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: SemiBoldText(text: widget.title, fontSize: 17, color: Colors.black, maxLine: 1, align: TextAlign.left),
                                ),
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
                              Row(
                                children: [
                                  RegularText(text: widget.rating.toString(), fontSize: 13 , color: AppColor.forText),
                                  const Icon(Icons.star_rounded, color: AppColor.orange, size: 20,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const RegularText(text: 'Chỉ từ ', fontSize: 13, color: AppColor.forText),
                                  SemiBoldText(text: '${widget.price}đ', fontSize: 17, color: AppColor.forText),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                  )
                ],
              ),
              Positioned(
                top: -8,
                right: -2,
                child: IconButton(
                  icon: _isFavorited
                      ? const Icon(CupertinoIcons.suit_heart, size: 20,)
                      : const Icon(CupertinoIcons.suit_heart_fill, size: 20, color: Colors.red),
                  onPressed: () {
                    _toggleFavorite();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
