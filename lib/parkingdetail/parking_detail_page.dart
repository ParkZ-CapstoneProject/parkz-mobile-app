import 'package:flutter/material.dart';
import 'package:parkz/parkingdetail/component/bottom_parking_bar.dart';
import 'package:parkz/parkingdetail/component/parking_image.dart';
import 'package:parkz/parkingdetail/component/tag_card.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ParkingDetailPage extends StatefulWidget {
  const ParkingDetailPage({Key? key}) : super(key: key);

  @override
  State<ParkingDetailPage> createState() => _ParkingDetailPageState();
}

class _ParkingDetailPageState extends State<ParkingDetailPage> {
  List<String> imageUrls = [
    'https://picsum.photos/id/235/200/300',
    'https://picsum.photos/id/236/200/300',
    'https://picsum.photos/id/200/200/300',
    'https://picsum.photos/id/199/200/300',
    'https://picsum.photos/id/163/200/300',
  ];
  int _currentImage = 0;
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

            Container(
              color: Colors.white,
              padding: EdgeInsets.all(containerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.star_rounded,
                            color: AppColor.orange,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RegularText(
                              text: '5.0',
                              fontSize: 15,
                              color: AppColor.forText),
                        ],
                      ),
                      const MediumText(
                          text: 'Còn trống 60/120 chỗ ',
                          fontSize: 14,
                          color: AppColor.forText),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SemiBoldText(
                      text: 'Bãi xe Tình thương',
                      fontSize: 24,
                      color: AppColor.forText),
                  const SizedBox(height: 8),
                  const MediumText(
                      text:
                          'Số 43 – 45 Nguyễn Thị Minh Khai, Phường Bến Nghé, Quận 1, TP. HCM',
                      fontSize: 14,
                      color: AppColor.forText,
                      maxLine: 5),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: const [
                      TagCard(tagName: 'Bãi Xe máy'),
                      TagCard(tagName: 'Bãi Xe ô tô',),
                      TagCard(tagName: 'Thanh toán trước'),
                      TagCard(tagName: 'Qua đêm'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12,),

            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(containerPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SemiBoldText(
                      text: 'Mô tả', color: AppColor.forText, fontSize: 17),
                  Divider(
                    thickness: 1,
                    color: AppColor.fadeText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Một bãi xe là một khu vực được thiết kế để đỗ xe và giữ xe an toàn. Bãi xe có thể có nhiều dạng, từ các bãi xe trống trải bề mặt đất cho đến các tòa nhà đỗ xe cao tầng. Các bãi xe thường được chia thành các vùng đỗ xe để giúp người dùng dễ dàng tìm kiếm nơi đỗ xe. Ngoài ra, các bãi xe có thể có các tài liệu hướng dẫn để hướng dẫn người dùng về quy định và thời gian hoạt động của bãi xe.'),
                ],
              ),
            ),

            const SizedBox(height: 12,),

            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(containerPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SemiBoldText(
                      text: 'Giá tiền', color: AppColor.forText, fontSize: 17),
                  const SizedBox(
                    height: 5,
                  ),
                  const MediumText(
                      text: 'Ô tô', fontSize: 15, color: AppColor.fadeText),
                  const Divider(
                    thickness: 1,
                    color: AppColor.fadeText,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: const {
                      0: FixedColumnWidth(100),
                    },
                    children: const [
                      TableRow(
                        children: [
                          TableCell(
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
                                text: 'Giá tiền',
                                fontSize: 14,
                                color: AppColor.forText),
                          ),
                          TableCell(
                            child: MediumText(
                                text: 'Phụ phí',
                                fontSize: 14,
                                color: AppColor.forText),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('06:00 -18:00'),
                            ),
                          ),
                          TableCell(
                            child: Text('5.000đ (1h đầu)'),
                          ),
                          TableCell(
                            child: Text('20.000đ (2h sau)'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('06:00 -18:00'),
                            ),
                          ),
                          TableCell(
                            child: Text('5.000đ (1h đầu)'),
                          ),
                          TableCell(
                            child: Text('20.000đ (2h sau)'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('06:00 -18:00'),
                            ),
                          ),
                          TableCell(
                            child: Text('5.000đ (1h đầu)'),
                          ),
                          TableCell(
                            child: Text('20.000đ (2h sau)'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const MediumText(
                      text: 'Xe máy', fontSize: 15, color: AppColor.fadeText),
                  const Divider(
                    thickness: 1,
                    color: AppColor.fadeText,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: {
                      0: FixedColumnWidth(100),
                    },
                    children: const [
                      TableRow(
                        children: [
                          TableCell(
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
                                text: 'Giá tiền',
                                fontSize: 14,
                                color: AppColor.forText),
                          ),
                          TableCell(
                            child: MediumText(
                                text: 'Phụ phí',
                                fontSize: 14,
                                color: AppColor.forText),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('06:00 -18:00'),
                            ),
                          ),
                          TableCell(
                            child: Text('5.000đ (1h đầu)'),
                          ),
                          TableCell(
                            child: Text('20.000đ (2h sau)'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('06:00 -18:00'),
                            ),
                          ),
                          TableCell(
                            child: Text('5.000đ (1h đầu)'),
                          ),
                          TableCell(
                            child: Text('20.000đ (2h sau)'),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text('06:00 -18:00'),
                            ),
                          ),
                          TableCell(
                            child: Text('5.000đ (1h đầu)'),
                          ),
                          TableCell(
                            child: Text('20.000đ (2h sau)'),
                          ),
                        ],
                      ),
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
