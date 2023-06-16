import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkz/activity/component/activity_card.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.navyPale,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const SemiBoldText(text: 'Hoạt động', fontSize: 20, color: AppColor.forText),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppColor.orange,
            labelColor: AppColor.forText,
            tabs: const [
              Tab(text: "Upcoming"),
              Tab(text: "Lịch sử"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Lottie.asset('assets/json/empty/629-empty-box.json', ),
                    const SizedBox(height: 30,),
                    const SemiBoldText(text: 'Có vẻ bạn chưa đặt đơn nào.', fontSize: 17, color: AppColor.forText),
                    const SizedBox(height: 5,),
                    const RegularText(text: 'Tìm bãi xe nhanh chóng và tiện lợi', fontSize: 13, color: AppColor.fadeText),
                    const SizedBox(height: 50,),
                    MyButton(text: 'Đặt ngay', function: (){}, textColor: Colors.white, backgroundColor: AppColor.navy, minWidth: 250, ),
                  ],
                ),
                // Content for Tab 1
                // ListView.builder(
                //   itemBuilder: (context, index) {
                //
                //   },
                //
                // ),



                // Content for Tab 2
                ListView.builder(
                  padding: const EdgeInsets.only(top: 10,bottom: 20, left: 15, right: 15),
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ActivityCard(),
                    );
                  },
                  itemCount: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
