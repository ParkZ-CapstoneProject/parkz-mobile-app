import 'package:flutter/material.dart';
import 'package:parkz/account/account_page.dart';
import 'package:parkz/activity/activity_page.dart';
import 'package:parkz/bottombar/components/bottom_iccon.dart';
import 'package:parkz/home/home_page.dart';
import 'package:parkz/location/location_page.dart';
import 'package:parkz/utils/constanst.dart';

class BottomBar extends StatefulWidget {
  final int selectedInit;

  const BottomBar({Key? key, required this.selectedInit}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late  int _selectedIndex = widget.selectedInit;
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    LocationPage(),
    ActivityPage(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration:  BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 20.0,
                  offset: const Offset(1.0, 1.0)
              ),
            ],
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
            elevation: 20.0,
            items:   const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'Trang chủ',
                activeIcon: BottomIcon(url: 'assets/icon/home_selected.svg'),
                icon: BottomIcon(url: 'assets/icon/home.svg'),
              ),

              BottomNavigationBarItem(
                label: 'Vị trí',
                activeIcon: BottomIcon(url: 'assets/icon/map-pin-selected.svg'),
                icon: BottomIcon(url: 'assets/icon/map-pin.svg'),
              ),

              BottomNavigationBarItem(
                label: 'Hoạt động',
                activeIcon: BottomIcon(url: 'assets/icon/calendar_selected.svg'),
                icon: BottomIcon(url: 'assets/icon/calendar.svg'),
              ),

              BottomNavigationBarItem(
                label: 'Tài khoản',
                activeIcon: BottomIcon(url: 'assets/icon/user_selected.svg'),
                icon: BottomIcon(url: 'assets/icon/user.svg'),
              ),

            ],
            selectedItemColor: AppColor.forText,
            unselectedItemColor: AppColor.navy,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped),
      ),
    );
  }
}
