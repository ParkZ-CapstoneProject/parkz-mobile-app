import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:parkz/activity/component/status_tag.dart';
import 'package:parkz/booking/component/my_seperator.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {},
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
            Expanded(
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

                  }, child:  const SemiBoldText(text: 'Hủy đơn', fontSize: 13, color: Colors.white)),
                )),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: MyButton(
                      text: 'Chỉ dường',
                      function: () {},
                      textColor: Colors.white,
                      backgroundColor: AppColor.orange),
                ))
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
              CouponCard(
                backgroundColor: Colors.white,
                curvePosition: 340,
                borderRadius: 30,
                  height: 450,
                  firstChild: const TicketData(),
                  secondChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RegularText(text: 'Giờ vào tạm tính : ', fontSize: 16, color: AppColor.forText),
                          SemiBoldText(text: '14:00 - 29/04/2023', fontSize: 17, color: AppColor.forText)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RegularText(text: 'Giờ ra tạm tính : ', fontSize: 16, color: AppColor.forText),
                          SizedBox(width: 10,),
                          SemiBoldText(text: '14:00 - 29/04/2023', fontSize: 17, color: AppColor.forText)
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
                height: 129,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Tên', fontSize: 14, color: AppColor.forText),
                        SemiBoldText(
                            text: 'Trần Ngọc Thắng',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Số điện thoại',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: '0773834602',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Biển số xe',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: '75A-165.19',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Hãng xe',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: 'KIA - Soluto 2023',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
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
                              content: const Text(
                                  '43 – 45 Nguyễn Thị Minh Khai, Phường Phạm Ngũ Lão, Thành phố Hồ Chí Minh'),
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
                        children: const [
                          MediumText(
                              text: 'Địa chỉ',
                              fontSize: 14,
                              color: AppColor.forText),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 50.0),
                              child: SemiBoldText(
                                  text:
                                      '43 – 45 Nguyễn Thị Minh Khai, Phường Phạm Ngũ Lão, Thành phố Hồ Chí Minh',
                                  maxLine: 1,
                                  align: TextAlign.left,
                                  fontSize: 14,
                                  color: AppColor.forText),
                            ),
                          ),
                          Icon(
                            Icons.remove_red_eye_rounded,
                            color: AppColor.orange,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Vị trí',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: 'Hầm B3 - L 3.2',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Bãi xe',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: 'Bãi xe Tình thương',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Thời gian đặt',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: '07:19 - 29/04/2023',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
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
                      children: const [
                        MediumText(
                            text: 'Trạng thái',
                            fontSize: 14,
                            color: AppColor.forText),
                        StatusTag(),
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
                                text: '01234567891',
                                fontSize: 14,
                                color: AppColor.forText),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                    const ClipboardData(text: '01234567891'));
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
                      children: const [
                        MediumText(
                            text: 'Phương thức',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: 'Tiền mặt',
                            fontSize: 14,
                            color: AppColor.forText)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MediumText(
                            text: 'Tổng cộng',
                            fontSize: 14,
                            color: AppColor.forText),
                        SemiBoldText(
                            text: '20.000 Đ',
                            fontSize: 25,
                            color: AppColor.forText)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = 'https://static.vecteezy.com/system/resources/previews/002/557/391/original/qr-code-for-scanning-free-vector.jpg';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 8,),
        const RegularText(text: 'Đưa mã này cho nhân viên', fontSize: 16, color: AppColor.fadeText),
        const SizedBox(height: 8,),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RegularText(
                text: 'Hoàn thành',
                fontSize: 17,
                color: AppColor.forText,
              ),
              SizedBox(
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
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(path);

                  await Share.share(path);
                },
                child: Row(
                  children: const [
                    Icon(Icons.share_outlined),
                    SizedBox(width: 5,),
                    RegularText(text: 'Chia sẻ', fontSize: 16, color: AppColor.forText)
                  ],
                ),
              ),
              InkWell(
                onTap:  () async {
                  final BuildContext scaffoldContext = context;
                   await GallerySaver.saveImage(path);

                   ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    const SnackBar(content: Text('Mã QR tải thành công'))
                  );
                },

                child: Row(
                  children: const [
                    Icon(Icons.save_alt),
                    SizedBox(width: 5,),
                    RegularText(text: 'Lưu về máy', fontSize: 16, color: AppColor.forText)
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 24,),
        const MySeparator(color: AppColor.fadeText,)
      ],
    );
  }
}
