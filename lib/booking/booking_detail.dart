import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/booking/booking_page.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:parkz/vehicle/vehicle_page.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  double containerPadding = 24;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navyPale,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: AppColor.forText),
        backgroundColor: Colors.white,
        title: const SemiBoldText(
            text: 'Xác nhận và thanh toán',
            fontSize: 20,
            color: AppColor.forText),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomAppBar(
          elevation: 10.0,
          color: Colors.white,
          height: 110,
          child: Container(
            padding: EdgeInsets.only(
                top: 8,
                right: containerPadding,
                left: containerPadding,
                bottom: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SemiBoldText(
                        text: 'Tổng thanh toán',
                        fontSize: 20,
                        color: AppColor.navy),
                    SemiBoldText(
                        text: '50.000 VND',
                        fontSize: 24,
                        color: AppColor.forText),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: MyButton(
                      text: 'Xác nhận giao dịch',
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookingPage()),
                        );
                      },
                      textColor: Colors.white,
                      backgroundColor: AppColor.navy),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 29, right: 29, top: 17, bottom: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SemiBoldText(
                      text: 'Thông tin đặt chỗ',
                      fontSize: 20,
                      color: AppColor.forText),
                  SizedBox(height: 19),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg',
                          fit: BoxFit.cover,
                          height: 83,
                          width: 125,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 83,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: const [
                                  MediumText(
                                      text: 'Bãi xe tình thương',
                                      fontSize: 14,
                                      color: AppColor.forText),
                                  SemiBoldText(
                                      text: 'Hầm B3 -  L3.2',
                                      fontSize: 17,
                                      color: AppColor.forText)
                                ],
                              ),
                              const RegularText(
                                  text:
                                      'Số 43 – 45 Nguyễn Thị Minh Khai, Phường Bến Nghé, Quận 1, TP. HCM',
                                  fontSize: 12,
                                  color: AppColor.forText,
                                  maxLine: 5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: 1,
                    color: AppColor.fadeText,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 115,
                        height: 120,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset('assets/image/cardback.png',
                                  width: 115, height: 120, fit: BoxFit.cover),
                            ),
                            Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/icon/hourglassdetail.svg'),
                                SizedBox(
                                  height: 11,
                                ),
                                const SemiBoldText(
                                    text: '4 Giờ',
                                    fontSize: 17,
                                    color: Colors.white)
                              ],
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.only(
                              left: 23, top: 14, bottom: 14),
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.navyPale),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              RegularText(
                                  text: 'Giờ vào',
                                  fontSize: 13,
                                  color: AppColor.forText),
                              SemiBoldText(
                                  text: '14:00 - 29/04/2023',
                                  fontSize: 16,
                                  color: AppColor.forText),
                              SizedBox(
                                height: 17,
                              ),
                              RegularText(
                                  text: 'Giờ ra',
                                  fontSize: 13,
                                  color: AppColor.forText),
                              SemiBoldText(
                                  text: '14:00 - 29/04/2023',
                                  fontSize: 16,
                                  color: AppColor.forText)
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 29, right: 29, top: 17, bottom: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SemiBoldText(
                          text: 'Thông tin người đặt',
                          fontSize: 20,
                          color: AppColor.forText),
                      InkWell(
                        child: SemiBoldText(
                            text: 'Đặt hộ',
                            fontSize: 15,
                            color: AppColor.orange),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      MediumText(
                          text: 'Tên', fontSize: 14, color: AppColor.forText),
                      SemiBoldText(
                          text: 'Trần Ngọc Thắng',
                          fontSize: 15,
                          color: AppColor.forText)
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      MediumText(
                          text: 'Số điện thoại',
                          fontSize: 14,
                          color: AppColor.forText),
                      SemiBoldText(
                          text: '0773834602',
                          fontSize: 15,
                          color: AppColor.forText)
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VehiclePage()),
                      );
                    },
                    child: DottedBorder(
                        color: AppColor.navy,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        strokeWidth: 1,
                        dashPattern: const [7, 5],
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: SizedBox(
                            height: 86,
                            width: double.infinity,
                            child: Icon(Icons.add, color: AppColor.navy),
                          ),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 29, right: 29, top: 17, bottom: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SemiBoldText(
                      text: 'Thanh toán',
                      fontSize: 20,
                      color: AppColor.forText),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MediumText(
                          text: 'Thanh toán trả trước', fontSize: 14, color: AppColor.forText),
                      Icon(Icons.radio_button_off)
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MediumText(
                          text: 'Thanh toán trả sau',
                          fontSize: 14,
                          color: AppColor.forText),
                      Icon(Icons.radio_button_checked)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

