import 'package:flutter/material.dart';
import 'package:parkz/parkingdetail/parking_detail_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class NearByCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final double rating;
  final String price;
  final String address;
  final int indexRoom;

  const NearByCard(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.rating,
      required this.price,
      required this.address,
      required this.indexRoom})
      : super(key: key);

  @override
  State<NearByCard> createState() => _NearByCardState();
}



class _NearByCardState extends State<NearByCard> {
  final List<String> tagName = ['Trả trước', 'Ô tô', 'Xe máy', 'Qua đêm'];


  @override
  Widget build(BuildContext context) {
    List<String> tagNameBuilder = [];

    tagNameBuilder.add(tagName[0]);
    tagNameBuilder.add(tagName[1]);
    tagNameBuilder.add(tagName[2]);
    tagNameBuilder.add(tagName[3]);

     String parkingTagName  = tagNameBuilder.join(' I ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 26.0 , right: 8.0, left: 8, top: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ParkingDetailPage()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                // Phần ảnh của card
                ClipRRect(
                  borderRadius: const BorderRadius.only( topRight:  Radius.circular(7.0), topLeft:  Radius.circular(7.0)),
                  child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    height: 120,
                    width: 254,
                  ),
                ),
              ]),

              // Phần body của card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SizedBox(
                  width: 230,
                  height: 120,
                  child: Stack(
                    children: [
                      Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 180,
                                  child: SemiBoldText(text: widget.title, fontSize: 15, color: AppColor.forText)
                              ),
                              Row(
                                children: [
                                  RegularText(text: widget.rating.toString(), fontSize: 13 , color: AppColor.forText),
                                  const Icon(Icons.star_rounded, color: AppColor.orange, size: 20,)
                                ],
                              )
                            ],
                          ),

                          const SizedBox(height: 4,),

                          // Địa chỉ
                          SizedBox(
                              width: 250,
                              child: RegularText(text: widget.address, fontSize: 13, color: AppColor.navy, maxLine: 2),
                          ),
                          widget.address.length > 36 ? const SizedBox(height: 16,) : const SizedBox(height: 24,),



                          // Tag
                          RegularText(text: parkingTagName, fontSize: 13, color: AppColor.orange)

                        ],
                      ),
                      Positioned(
                        top: 100,
                        width: 225,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const RegularText(text: 'Giá hiện tại / ', fontSize: 13, color: AppColor.forText),
                            SemiBoldText(text: '${widget.price}đ', fontSize: 17, color: AppColor.forText),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
