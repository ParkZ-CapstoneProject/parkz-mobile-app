import 'package:flutter/material.dart';
import 'package:parkz/model/parking_detail_response.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/parkingdetail/component/bottom_parking_bar.dart';
import 'package:parkz/parkingdetail/component/parking_image.dart';
import 'package:parkz/parkingdetail/component/tag_card.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading_page.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ParkingDetailPage extends StatefulWidget {
  final int id;
  const ParkingDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ParkingDetailPage> createState() => _ParkingDetailPageState();
}

class _ParkingDetailPageState extends State<ParkingDetailPage> {
  List<String> imageUrls = [];
  final int _currentImage = 0;
  late PageController _imageController;

  @override
  void initState() {
    _imageController = PageController(initialPage: _currentImage);
    super.initState();
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double containerPadding = 24;
    print('id: ${widget.id}');
    return FutureBuilder<ParkingDetailResponse>(
      future: getParkingDetail(widget.id),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingPage();
        }

        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: SemiBoldText(text: 'Đã có lỗi  xảy ra: ${snapshot.error}', fontSize: 15, color: Colors.redAccent),
            ),
          );
        }
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          //add image to list
            if( snapshot.data!.data?.parking?.parkingSpotImages != null){
            for (var parkingSpot in snapshot.data!.data!.parking!.parkingSpotImages!) {
              imageUrls.add(parkingSpot.imgPath!);
            }
          }

        ParkingHasPrice carPrice = ParkingHasPrice();
          ParkingHasPrice motoPrice = ParkingHasPrice();
          if(snapshot.data!.data!.parking!.parkingHasPrices != null){
            carPrice = snapshot.data!.data!.parking!.parkingHasPrices!.firstWhere((parkingHasPrice) => parkingHasPrice.parkingPrice?.traffic?.trafficId == 1,orElse: () => carPrice ,);
            motoPrice = snapshot.data!.data!.parking!.parkingHasPrices!.firstWhere((parkingHasPrice) => parkingHasPrice.parkingPrice?.traffic?.trafficId == 2, orElse: () => motoPrice,);
          }


          return Scaffold(
            backgroundColor: AppColor.navyPale,
            appBar: AppBar(
              bottomOpacity: 0.0,
              elevation: 0.0,
              leading: const BackButton(color: AppColor.forText),
              backgroundColor: Colors.white,
              title: const SemiBoldText(text: 'Chi tiết bãi xe', fontSize: 20, color: AppColor.forText),
            ),
            bottomNavigationBar: BottomParkingBar(containerPadding: containerPadding),

            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ParkingImage(imageUrls: imageUrls),

                  const SizedBox(height: 8,),
                  //Parking Info
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(containerPadding),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Star rating
                        snapshot.data!.data!.parking!.stars != null ?
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColor.orange,
                              size: 20,
                            ),

                            const SizedBox(width: 5,),

                            RegularText(
                                text: snapshot.data!.data!.parking!.stars!.toString(),
                                fontSize: 15,
                                color: AppColor.forText),
                          ],
                        ) : const SizedBox(width: 50),


                        const SizedBox(height: 16),

                        //Parking Name
                        SemiBoldText(
                            text: snapshot.data!.data!.parking!.name!,
                            fontSize: 24,
                            color: AppColor.forText),
                        const SizedBox(height: 8),

                        //Address
                        MediumText(
                            text: snapshot.data!.data!.parking!.address!,
                            fontSize: 14,
                            color: AppColor.forText,
                            maxLine: 5),
                        const SizedBox(height: 24),

                        //Parking tag
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            motoPrice.parkingPrice != null? const TagCard(tagName: 'Bãi Xe máy') : const SizedBox(),

                            carPrice.parkingPrice != null ? const TagCard(tagName: 'Bãi Xe ô tô',) : const SizedBox(),

                            snapshot.data!.data!.parking!.isPrepayment! == true ?
                            const TagCard(tagName: 'Thanh toán trước') : const SizedBox(),
                            snapshot.data!.data!.parking!.isOvernight! == true ?
                            const TagCard(tagName: 'Qua đêm') : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12,),

                  //Parking description
                  snapshot.data!.data!.parking!.description != null ?
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(containerPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const SemiBoldText(
                            text: 'Mô tả', color: AppColor.forText, fontSize: 17),

                        const Divider(thickness: 1, color: AppColor.fadeText,),

                        const SizedBox(height: 5,),

                        Text(snapshot.data!.data!.parking!.description!),
                      ],
                    ),
                  ) : const SizedBox(),

                  const SizedBox(height: 12,),

                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(containerPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SemiBoldText(text: 'Giá tiền', color: AppColor.forText, fontSize: 17),
                        const SizedBox(height: 5,),

                        carPrice.parkingPrice != null ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MediumText(text: 'Ô tô', fontSize: 15, color: AppColor.fadeText),
                            const Divider(thickness: 1, color: AppColor.fadeText,),
                            const SizedBox(height: 5,),
                            createTable(carPrice),
                          ],
                        ) : const SizedBox(),

                        const SizedBox(height: 16,),

                        motoPrice.parkingPrice != null ?
                        Column(
                          children: [
                            const MediumText(text: 'Xe máy', fontSize: 15, color: AppColor.fadeText),
                            const Divider(thickness: 1, color: AppColor.fadeText,),
                            const SizedBox(height: 5,),
                            createTable(motoPrice),
                          ],
                        ) : const SizedBox(),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: SemiBoldText(text: 'Không tìm thấy bãi xe', fontSize: 25, color: AppColor.forText, ),
          ),
        );
      }
    );
  }
}

Widget createTable(ParkingHasPrice price) {

  List<TableRow> rows = [];
  rows.add( TableRow(
    children: [
      const TableCell(
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: MediumText(
              text: 'Thời gian',
              fontSize: 14,
              color: AppColor.forText),
        ),
      ),
      TableCell(
        child: MediumText(
            text: 'Giá tiền (${price.parkingPrice?.startingTime}h đầu)',
            fontSize: 14,
            color: AppColor.forText),
      ),
      TableCell(
        child: MediumText(
            text: 'Phụ phí (${1}h sau)',
            fontSize: 14,
            color: AppColor.forText),
      ),
    ],
  ));

  for (int i = 0; i < price.parkingPrice!.timeLines!.length ; ++i) {
    rows.add(
      TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('${price.parkingPrice?.timeLines?[i].startTime} -${price.parkingPrice?.timeLines?[i].endTime}'),
            ),
          ),
          TableCell(
            child: Text('${price.parkingPrice?.timeLines?[i].price}đ'),
          ),
          TableCell(
            child: Text('${price.parkingPrice?.timeLines?[i].extraFee}đ'),
          ),
        ],
      ),
    );
  }
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.top,
    columnWidths: const {
      0: FixedColumnWidth(100),
    },
    children:  rows
  );
}