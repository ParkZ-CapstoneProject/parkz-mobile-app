import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:parkz/activity/component/status_tag.dart';
import 'package:parkz/booking/component/my_seperator.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading_page.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../model/booking_detail_response.dart';
import '../network/api.dart';

class BookingPage extends StatefulWidget {
  final int bookingId;
  const BookingPage({Key? key, required this.bookingId}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String moneyFormat(double number) {
    String formattedNumber = number.toStringAsFixed(0); // Convert double to string and remove decimal places
    return formattedNumber.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
    );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookingDetailResponse>(
        future: getBookingDetail(widget.bookingId),

        builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingPage();
        }
        if(snapshot.hasError){
          return  Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const Center(child: SemiBoldText(text: '[E]Không lấy được thông tin đơn', fontSize: 19, color: AppColor.forText),),
          );
        }
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          DetailBooking booking = snapshot.data!.data!;
            return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  const MyBottomBar(selectedInit: 0,)),
                        );
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ))
                ],
                title: const SemiBoldText(
                    text: 'Chi tiết đơn đặt', fontSize: 20, color: Colors.white),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Nut huy đơn
                    booking.bookingDetails!.status == 'Initial'
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColor.orange, width: 2),
                                shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () {
                                cancelBooking(widget.bookingId, context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  const MyBottomBar(selectedInit: 0,)),
                                );
                              },
                              child:  const SemiBoldText(text: 'Hủy đơn', fontSize: 13, color: Colors.white)
                          ),
                        )
                    )
                    : const SizedBox(),

                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: MyButton(
                              text: 'Chỉ dường',
                              function: () {

                              },
                              textColor: Colors.white,
                              backgroundColor: AppColor.orange
                          ),
                        )
                    )
                  ],
                ),
              ),

              body: Container(
                padding:
                const EdgeInsets.only(left: 24, right: 24, top: 75, bottom: 70),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF064789),
                    Color(0xFF023B72),
                    Color(0xFF022F5B),
                    Color(0xFF032445)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      booking.bookingDetails!.status == 'Done' || booking.bookingDetails!.status == 'Cancel'?
                       Container(
                         padding: const EdgeInsets.only(
                             left: 30, right: 30, top: 20, bottom: 20),
                         height: 300,
                         width: double.infinity,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             color: Colors.white),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             SvgPicture.asset(booking.bookingDetails!.status == 'Done' ? 'assets/icon/car_sucess.svg' : 'assets/icon/car_cancel.svg'),
                             const SizedBox(height: 26,),
                             SemiBoldText(text: booking.bookingDetails!.status == 'Done' ? 'Hoàn thành' : 'Hủy đơn', fontSize: 24, color: AppColor.forText)
                           ],
                         ),
                      ) : CouponCard(
                          backgroundColor: Colors.white,
                          curvePosition: 340,
                          borderRadius: 30,
                          height: 450,
                          firstChild:  TicketData(qrPath: booking.bookingDetails!.qrImage!, status: booking.bookingDetails!.status! ,),
                          secondChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const RegularText(text: 'Giờ vào tạm tính : ', fontSize: 16, color: AppColor.forText),
                                  SemiBoldText(text: DateFormat('HH:mm - dd/MM/yyyy').format(booking.bookingDetails!.startTime!).toString(),
                                      fontSize: 17,
                                      color: AppColor.forText)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const RegularText(text: 'Giờ ra tạm tính : ', fontSize: 16, color: AppColor.forText),
                                  const SizedBox(width: 10,),
                                  SemiBoldText(text: DateFormat('HH:mm - dd/MM/yyyy').format(booking.bookingDetails!.endTime!).toString(),
                                      fontSize: 17,
                                      color: AppColor.forText)
                                ],
                              )
                            ],
                          )
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const MediumText(text: 'Tên', fontSize: 14, color: AppColor.forText),
                                SemiBoldText(
                                    text: booking.user!.name!,
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const MediumText(
                                    text: 'Số điện thoại',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: booking.user!.phone!,
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                            booking.bookingDetails!.guestPhone != null ? Column(
                              children: [
                                const Divider(thickness: 1, color: AppColor.fadeText,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const MediumText(
                                        text: 'Số người đặt hộ',
                                        fontSize: 14,
                                        color: AppColor.forText),
                                    SemiBoldText(
                                        text: booking.bookingDetails!.guestPhone!,
                                        fontSize: 14,
                                        color: AppColor.forText)
                                  ],
                                ),
                                const SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const MediumText(text: 'Tên người đặt hộ', fontSize: 14, color: AppColor.forText),
                                    SemiBoldText(
                                        text: booking.bookingDetails!.guestName!,
                                        fontSize: 14,
                                        color: AppColor.forText)
                                  ],
                                ),
                              ],
                            ) : const SizedBox(),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const MediumText(
                                    text: 'Biển số xe',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: booking.vehicleInfor!.licensePlate!,
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const MediumText(
                                    text: 'Hãng xe',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: booking.vehicleInfor!.vehicleName!,
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14,),

                      Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Địa chỉ'),
                                      content:  Text(booking.parkingWithBookingDetailDto!.address!),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Đóng'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  const MediumText(
                                      text: 'Địa chỉ',
                                      fontSize: 14,
                                      color: AppColor.forText),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 50.0),
                                      child: SemiBoldText(
                                          text: booking.parkingWithBookingDetailDto!.address!.trim(),
                                          maxLine: 1,
                                          align: TextAlign.right,
                                          fontSize: 14,
                                          color: AppColor.forText),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.remove_red_eye_rounded,
                                    color: AppColor.orange,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const MediumText(
                                    text: 'Vị trí',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: '${booking.floorWithBookingDetailDto!.floorName!} - ${booking.parkingSlotWithBookingDetailDto!.name!.trim()}',
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const MediumText(
                                    text: 'Bãi xe',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: booking.parkingWithBookingDetailDto!.name!,
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                MediumText(
                                    text: 'Thời gian bạn vào bãi',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: '---------',
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                const MediumText(
                                    text: 'Trạng thái',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                StatusTag(status: booking.bookingDetails!.status!,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const MediumText(
                                    text: 'Mã đơn',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                Row(
                                  children: [
                                    SemiBoldText(
                                        text: booking.bookingDetails!.bookingId.toString(),
                                        fontSize: 14,
                                        color: AppColor.forText),
                                    const SizedBox(width: 2,),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(
                                             ClipboardData(text: booking.bookingDetails!.bookingId.toString()));
                                      },
                                      child: const Icon(Icons.content_copy,
                                          color: AppColor.orange, size: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                const MediumText(
                                    text: 'Phương thức',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: booking.transactionWithBookingDetailDtos![0].paymentMethod.toString(),
                                    fontSize: 14,
                                    color: AppColor.forText)
                              ],
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const MediumText(
                                    text: 'Tổng cộng',
                                    fontSize: 14,
                                    color: AppColor.forText),
                                SemiBoldText(
                                    text: '${moneyFormat(booking.bookingDetails!.totalPrice!)} Đ',
                                    fontSize: 25,
                                    color: AppColor.forText)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              ),
            );
        }

        return  Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: const Center(child: SemiBoldText(text: '[U]Không lấy được thông tin đơn', fontSize: 19, color: AppColor.forText),),
        );
      }
    );
  }
}

class TicketData extends StatelessWidget {
  final String qrPath;
  final String status;
  const TicketData({
    Key? key, required this.qrPath, required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = qrPath;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 8,),
        const RegularText(text: 'Đưa mã này cho nhân viên', fontSize: 16, color: AppColor.fadeText),
        const SizedBox(height: 8,),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               RegularText(
                  fontSize: 13,
                  text: status == "Initial" ? 'Chờ xác nhận'
                      : status == "Approve" ? 'Chờ vào bãi'
                      : status == "Checkin" ? "Chờ ra bãi"
                      : status == "Checkout" ? "Chờ thanh toán"
                      :  status == "Done" ? "Hoàn thành"
                      : "Hủy đơn",
                  color: status == "Initial" ? AppColor.orange
                      : status == "Approve" ? AppColor.navy
                      : status == "Checkin" ? AppColor.forText
                      : status == "Checkout" ? AppColor.orange
                      :  status == "Done" ? Colors.green
                      : Colors.red
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset('assets/icon/hourglass.svg')
            ],
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Center(
          child: Image.network(path,
            height: 200,
            width: 200,
          ),
        ),
        const SizedBox(
          height: 29,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  await Share.share(path);
                },
                child: const Row(
                  children: [
                    Icon(Icons.share_outlined),
                    SizedBox(width: 5,),
                    RegularText(text: 'Chia sẻ', fontSize: 16, color: AppColor.forText)
                  ],
                ),
              ),
              InkWell(
                onTap:  () async {
                   await GallerySaver.saveImage(path);
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mã QR tải thành công'))
                  );
                },

                child: const Row(
                  children: [
                    Icon(Icons.save_alt),
                    SizedBox(width: 5,),
                    RegularText(text: 'Lưu về máy', fontSize: 16, color: AppColor.forText)
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 24,),
        const MySeparator(color: AppColor.fadeText,)
      ],
    );
  }
}
