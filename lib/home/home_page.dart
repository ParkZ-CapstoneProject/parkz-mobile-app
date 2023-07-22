import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/home/components/nearby_card.dart';
import 'package:parkz/home/components/nearby_shim_list.dart';
import 'package:parkz/home/components/parking_horizontal_card.dart';
import 'package:parkz/home/components/parking_horizontal_shim_list.dart';
import 'package:parkz/home/components/title_list.dart';
import 'package:parkz/model/nearest_response.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/parkinglist/parking_list_page.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/preference_manager.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../model/rating_home_response.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? address;
  double? long;
  double? lat;



  @override
  void initState() {
    super.initState();
    getAddress();
    getLatLong();
  }
  void getAddress() async {
    String? storedAddress = await PreferenceManager.getAddress();
    setState(() {
      address = storedAddress;
    });
  }
  void getLatLong() async {
    double? storeLat = await PreferenceManager.getLatitude();
    double? storeLong = await PreferenceManager.getLongitude();

    setState(() {
      lat = storeLat;
      long = storeLong;
    });
  }

  Future<void> _refreshData() async {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.navyPale,
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _refreshData,
              child: CustomScrollView(
              slivers: <Widget> [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only( right: 5),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 8),
                              child: SvgPicture.asset('assets/icon/location.svg', width: 26,height: 26,),
                            ),
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    const RegularText(text: 'Vị trí của bạn', fontSize: 12, color: AppColor.navyPale),
                                    //address
                                    SemiBoldText(maxLine: 1, text: address != null ? '$address' : 'Loading...',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ]
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  const MyBottomBar(selectedInit: 1)),
                          );
                        },
                      ),
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

                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 16),
                          child: TitleList(title: 'Gần bạn', page: ParkingListPage()),
                        ),

                        FutureBuilder<NearestParkingResponse>(
                          future: getNearestParking(lat, long),
                          builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const NearByLoadingList();
                          }
                          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                            if(snapshot.data!.data!.isNotEmpty){
                              return SizedBox(
                                height: 340,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 12),
                                  itemBuilder: (context, index) {
                                    return  NearByCard(
                                      id: snapshot.data!.data![index].getListParkingNearestYouQueryResponse!.parkingId!,
                                      title: snapshot.data!.data![index].getListParkingNearestYouQueryResponse!.name!,
                                      imagePath: snapshot.data!.data![index].getListParkingNearestYouQueryResponse!.avatar,
                                      rating: snapshot.data!.data![index].getListParkingNearestYouQueryResponse!.stars,
                                      carPrice: snapshot.data!.data![index].priceCar,
                                      motoPrice: snapshot.data!.data![index].priceMoto,
                                      address: snapshot.data!.data![index].getListParkingNearestYouQueryResponse!.address!,
                                      isPrepayment: snapshot.data!.data![index].getListParkingNearestYouQueryResponse!.isPrepayment!,
                                      isOvernight: snapshot.data!.data![index].getListParkingNearestYouQueryResponse!.isOvernight!,
                                      distance: snapshot.data!.data![index].distance!,
                                    );
                                  },
                                  itemCount: snapshot.data?.data?.length,
                                ),
                              );
                            }else {
                              return const SizedBox(
                                width: double.infinity,
                                height: 310,
                                child: Center(child: SemiBoldText(text: 'Không có bãi xe gần bạn', fontSize: 19, color: AppColor.forText),),
                              );
                            }
                          }
                          if(snapshot.hasError){
                              return const SizedBox(
                              width: double.infinity,
                              height: 310,
                              child: Center(child: SemiBoldText(text: '[E]Không có bãi xe gần bạn', fontSize: 19, color: AppColor.forText),),
                            );
                          }
                          return const SizedBox(
                            width: double.infinity,
                            height: 310,
                            child: Center(child: SemiBoldText(text: '[U]Không có bãi xe gần bạn', fontSize: 19, color: AppColor.forText),),
                          );

                        },),

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
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 16),
                          child: TitleList(title: 'Danh sách nổi bật', page: ParkingListPage()),
                        ),

                        FutureBuilder<RatingHomeResponse>(
                          future: getParkingListHome(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const ParkinkCardHomeLoadingList();
                            }
                            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                              if(snapshot.data!.data!.isNotEmpty){
                                return  ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ParkingCardHome(
                                      title: snapshot.data!.data![index].parkingShowInCusDto!.name!,
                                      imagePath: snapshot.data!.data![index].parkingShowInCusDto!.avatar,
                                      rating: snapshot.data!.data![index].parkingShowInCusDto!.stars,
                                      motoPrice: snapshot.data!.data![index].priceMoto,
                                      carPrice: snapshot.data!.data![index].priceCar,
                                      address: snapshot.data!.data![index].parkingShowInCusDto!.address!,
                                      isFavorite: true,
                                      id: snapshot.data!.data![index].parkingShowInCusDto!.parkingId!,
                                    );
                                  },
                                  itemCount: snapshot.data!.data!.length,
                                );
                              }else {
                                return const SizedBox(
                                  width: double.infinity,
                                  height: 310,
                                  child: Center(child: SemiBoldText(text: 'Không có bãi xe gần bạn', fontSize: 19, color: AppColor.forText),),
                                );
                              }
                            }
                            if(snapshot.hasError){
                              return const SizedBox(
                                width: double.infinity,
                                height: 510,
                                child: Center(child: SemiBoldText(text: '[E]Không có bãi xe gần bạn', fontSize: 19, color: AppColor.forText),),
                              );
                            }
                            return const SizedBox(
                              width: double.infinity,
                              height: 510,
                              child: Center(child: SemiBoldText(text: '[U]Không có bãi xe gần bạn', fontSize: 19, color: AppColor.forText),),
                            );
                          },),



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
            ),
            // AnimatedPositioned(
            //   duration: const Duration(seconds: 2),
            //   left: 8,
            //   right: 8,
            //   bottom: 8,
            //   curve: Curves.linear,
            //   child: Container(
            //     width: double.infinity,
            //     height: 100,
            //     padding: EdgeInsets.all(8),
            //     color: Colors.grey,
            //     child: Center(
            //       child: Text('Floating Container'),
            //     ),
            //   ),
            // ),
          ],
        ),
    );
  }
}
