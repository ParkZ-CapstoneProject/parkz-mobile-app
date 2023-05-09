import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/home/components/nearby_card.dart';
import 'package:parkz/home/components/parking_horizontal_card.dart';
import 'package:parkz/home/components/title_list.dart';
import 'package:parkz/notification/notification_page.dart';
import 'package:parkz/parkinglist/parking_list_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.navyPale,
        body: CustomScrollView(
        slivers: <Widget> [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 8),
                          child: SvgPicture.asset('assets/icon/location.svg', width: 26,height: 26,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            RegularText(text: 'Vị trí của bạn', fontSize: 12, color: AppColor.navyPale),
                            SemiBoldText(text: 'Đại học Tôn Đức Thắng', fontSize: 15, color: Colors.white),
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const BottomBar(selectedInit: 1)),
                      );
                    },
                  ),

                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const NotificationPage()),
                        );
                  },
                      icon: const Icon(CupertinoIcons.bell_solid, size: 26,))
                ],
              ),
            ),
            backgroundColor: AppColor.navy,
            pinned: true,
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/image/home_banner.png', width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12,width: double.infinity,)),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const TitleList(title: 'Gần đây', page: ParkingListPage()),
                  SizedBox(
                    height: 310,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 12),
                      itemBuilder: (context, index) {
                        return  NearByCard(
                          indexRoom: index,
                          title: 'Phố đi bộ Nguyễn Huệ',
                          imagePath: 'assets/image/home_banner.png',
                          rating: 5.0,
                          price: '100',
                          address: '123 Nguyễn Huệ, Quận 1',
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12,width: double.infinity,)),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const TitleList(title: 'Các bãi đỗ xe gần đây', page: ParkingListPage()),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ParkingCardHome(
                        title: 'Takashimaya - 94 Nam Kỳ Khởi Nghĩa ',
                        imagePath: 'assets/image/home_banner.png',
                        rating: 5,
                        price: '20.000',
                        address: '50/1 Thành Thái, Phường 12, Quận 10, Thành phố Hồ Chí Minh, Thành Phố',
                        isFavorite: true,
                        indexRoom: index,
                      );
                    },
                    itemCount: 16,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ParkingListPage()),
                        );
                      },
                      child: const SemiBoldText(text: 'Xem thêm', fontSize: 14, color: AppColor.navy),
                    ),
                  ),
                  const SizedBox(height: 26,),
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
}
