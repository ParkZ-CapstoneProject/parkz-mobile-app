import 'package:flutter/material.dart';
import 'package:parkz/account/no_permission_page.dart';
import 'package:parkz/activity/component/activity_card.dart';
import 'package:parkz/activity/component/empty_booking.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../model/upcoming_response.dart';
import '../network/api.dart';
import 'component/activity_loading.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _token;
  void getToken() async {
    String? token = await storage.read(key: 'token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    getToken();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_token == null) {
      return const NoPermissionPage();
    }
    return Scaffold(
      backgroundColor: AppColor.navyPale,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const SemiBoldText(
            text: 'Hoạt động', fontSize: 20, color: AppColor.forText),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppColor.orange,
            labelColor: AppColor.forText,
            tabs: const [
              Tab(text: "Đang diễn ra"),
              Tab(text: "Lịch sử"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Content for Tab 1

                FutureBuilder<UpcomingResponse?>(
                    future: getBookingUpcoming(context),
                    builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const ActivityLoading();
                  }
                  if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                    if(snapshot.data!.data != null){
                      return RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
                          itemBuilder: (context, index) {
                            return  Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ActivityCard(
                                  bookingId:  snapshot.data!.data![index].bookingSearchResult!.bookingId!,
                                  dateBook: snapshot.data!.data![index].bookingSearchResult!.dateBook!,
                                  startTime: snapshot.data!.data![index].bookingSearchResult!.startTime!,
                                  endTime: snapshot.data!.data![index].bookingSearchResult!.endTime!,
                                  licensePlate: snapshot.data!.data![index].vehicleInforSearchResult!.licensePlate!,
                                  address: snapshot.data!.data![index].parkingSearchResult!.address!,
                                  parkingName: snapshot.data!.data![index].parkingSearchResult!.name!,
                                  floorName: snapshot.data!.data![index].parkingSlotSearchResult!.floorName!,
                                  slotName: snapshot.data!.data![index].parkingSlotSearchResult!.name!,
                                  status: snapshot.data!.data![index].bookingSearchResult!.status!
                              ),
                            );
                          },
                          itemCount: snapshot.data!.data!.length,
                        ),
                      );
                    }
                  }
                  return const EmptyBooking();
                }
                ),

                // Content for Tab 2

                FutureBuilder<UpcomingResponse?>(
                    future: getBookingHistory(context),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const ActivityLoading();
                      }
                      if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                        if(snapshot.data!.data != null){
                          return RefreshIndicator(
                            onRefresh: _refreshData,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
                              itemBuilder: (context, index) {
                                return  Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: ActivityCard(
                                    isRating: snapshot.data!.data![index].bookingSearchResult!.isRating,
                                      bookingId:  snapshot.data!.data![index].bookingSearchResult!.bookingId!,
                                      dateBook: snapshot.data!.data![index].bookingSearchResult!.dateBook!,
                                      startTime: snapshot.data!.data![index].bookingSearchResult!.startTime!,
                                      endTime: snapshot.data!.data![index].bookingSearchResult!.endTime!,
                                      licensePlate: snapshot.data!.data![index].vehicleInforSearchResult!.licensePlate!,
                                      address: snapshot.data!.data![index].parkingSearchResult!.address!,
                                      parkingName: snapshot.data!.data![index].parkingSearchResult!.name!,
                                      floorName: snapshot.data!.data![index].parkingSlotSearchResult!.floorName!,
                                      slotName: snapshot.data!.data![index].parkingSlotSearchResult!.name!,
                                      status: snapshot.data!.data![index].bookingSearchResult!.status!
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.data!.length,
                            ),
                          );
                        }
                      }
                      return const EmptyBooking();
                    }
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
