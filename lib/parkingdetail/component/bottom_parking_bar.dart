import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkz/booking/booking_slot_page.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:table_calendar/table_calendar.dart';

class BottomParkingBar extends StatefulWidget {
  final double containerPadding;
  const BottomParkingBar({Key? key, required this.containerPadding})
      : super(key: key);

  @override
  State<BottomParkingBar> createState() => _BottomParkingBarState();
}

class _BottomParkingBarState extends State<BottomParkingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        height: 130,
        child: Container(
          padding: EdgeInsets.only(
              top: 8,
              right: widget.containerPadding,
              left: widget.containerPadding,
              bottom: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  showBookingPopup(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 42,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.orange),
                      color: AppColor.paleOrange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.timer_sharp,
                              size: 25, color: AppColor.forText),
                          SizedBox(
                            width: 10,
                          ),
                          SemiBoldText(
                            text: '1 giờ',
                            color: AppColor.forText,
                            fontSize: 15,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          VerticalDivider(
                            thickness: 1,
                            color: AppColor.forText,
                            endIndent: 2,
                            indent: 2,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          SemiBoldText(
                            text: '08:00',
                            color: AppColor.forText,
                            fontSize: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.arrow_forward_outlined, size: 15),
                          SizedBox(
                            width: 5,
                          ),
                          SemiBoldText(
                            text: '09:00 , 29/04',
                            color: AppColor.forText,
                            fontSize: 15,
                          ),
                        ],
                      ),
                      const Icon(Icons.chevron_right_rounded)
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      RegularText(
                          text: 'Giá tạm tính',
                          fontSize: 12,
                          color: AppColor.navy),
                      SemiBoldText(
                          text: '50.000 VND',
                          fontSize: 24,
                          color: AppColor.forText),
                    ],
                  ),
                  MyButton(
                      text: 'Đặt chỗ',
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookingSlotPage()),
                        );
                      },
                      textColor: Colors.white,
                      backgroundColor: AppColor.navy)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBookingPopup(BuildContext context) {
     DateTime _focusedDay = DateTime.now();
     DateTime? _selectedDay = _focusedDay;
     int durationSelected = 0;
    int hourSelected = 0;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16,),
                Center(
                  child: Container(
                      width: 50,
                      height: 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.fadeText)
                  ),
                ),
                const SizedBox(height: 24,),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const RegularText(
                              text: 'Ngày vào',
                              fontSize: 14,
                              color: AppColor.forText),
                          const SizedBox(
                            height: 2,
                          ),
                          SemiBoldText(
                              text: DateFormat('dd/MM').format(_selectedDay!),
                              fontSize: 16,
                              color: AppColor.navy)
                        ],
                      ),
                      const VerticalDivider(
                        thickness: 1.5,
                        color: AppColor.navyPale,
                        endIndent: 3,
                        indent: 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          RegularText(
                              text: 'Giờ vào',
                              fontSize: 14,
                              color: AppColor.forText),
                          SizedBox(
                            height: 2,
                          ),
                          SemiBoldText(
                              text: '2:00', fontSize: 16, color: AppColor.navy)
                        ],
                      ),
                      const VerticalDivider(
                        thickness: 1.5,
                        color: AppColor.navyPale,
                        endIndent: 3,
                        indent: 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          RegularText(
                              text: 'Thời hạn',
                              fontSize: 14,
                              color: AppColor.forText),
                          SizedBox(
                            height: 2,
                          ),
                          SemiBoldText(
                              text: '2 giờ', fontSize: 16, color: AppColor.navy)
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.navyPale),
                  child: TableCalendar(
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday) {
                          const text = 'CN';
                          return const Center(
                            child: SemiBoldText(
                              text: text,
                              fontSize: 14,
                              color: AppColor.forText,
                            ),
                          );
                        }
                        if (day.weekday == DateTime.monday) {
                          const text = 'T2';
                          return const Center(
                            child: SemiBoldText(
                              text: text,
                              fontSize: 14,
                              color: AppColor.forText,
                            ),
                          );
                        }
                        if (day.weekday == DateTime.tuesday) {
                          const text = 'T3';
                          return const Center(
                            child: SemiBoldText(
                              text: text,
                              fontSize: 14,
                              color: AppColor.forText,
                            ),
                          );
                        }
                        if (day.weekday == DateTime.wednesday) {
                          const text = 'T4';
                          return const Center(
                            child: SemiBoldText(
                              text: text,
                              fontSize: 14,
                              color: AppColor.forText,
                            ),
                          );
                        }
                        if (day.weekday == DateTime.thursday) {
                          const text = 'T5';
                          return const Center(
                            child: SemiBoldText(
                              text: text,
                              fontSize: 14,
                              color: AppColor.forText,
                            ),
                          );
                        }
                        if (day.weekday == DateTime.friday) {
                          const text = 'T6';
                          return const Center(
                            child: SemiBoldText(
                              text: text,
                              fontSize: 14,
                              color: AppColor.forText,
                            ),
                          );
                        }
                        if (day.weekday == DateTime.saturday) {
                          const text = 'T7';
                          return const Center(
                            child: SemiBoldText(
                              text: text,
                              fontSize: 14,
                              color: AppColor.forText,
                            ),
                          );
                        }
                        return null;
                      },
                      defaultBuilder: (context, day, focusedDay) {
                        return Center(
                            child: SemiBoldText(
                                text: day.day.toString(),
                                fontSize: 14,
                                color: AppColor.forText));
                      },
                      disabledBuilder: (context, day, focusedDay) {
                        return Center(
                            child: SemiBoldText(
                                text: day.day.toString(),
                                fontSize: 14,
                                color: Colors.grey));
                      },
                      outsideBuilder: (context, day, focusedDay) {
                        return Center(
                            child: SemiBoldText(
                                text: day.day.toString(),
                                fontSize: 14,
                                color: AppColor.fadeText));
                      },
                      headerTitleBuilder: (context, day) {
                        return Center(
                            child: SemiBoldText(
                                text: 'Tháng ${day.month}, ${day.year}',
                                fontSize: 15,
                                color: AppColor.forText));
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        return Center(
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.paleOrange,
                                  border: Border.all(
                                    color: AppColor.orange,
                                    width: 1.0,
                                  ),
                                ),
                                child: Center(
                                    child: SemiBoldText(
                                  text: day.day.toString(),
                                  fontSize: 14,
                                  color: AppColor.forText,
                                  align: TextAlign.center,
                                ))));
                      },
                      todayBuilder: (context, day, focusedDay) {
                        return Center(
                            child: SemiBoldText(
                              text: day.day.toString(),
                              fontSize: 14,
                              color: AppColor.orange,
                              align: TextAlign.center,
                            ));
                      },
                    ),
                    locale: 'vi_VN',
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    rowHeight: 40,
                    lastDay: DateTime.utc(2030),
                    focusedDay: _focusedDay,
                    firstDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    availableGestures: AvailableGestures.all,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        print('Ngày nè: ${_selectedDay}');
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SemiBoldText(
                    text: 'Chọn giờ vào',
                    fontSize: 15,
                    color: AppColor.forText),
                const SizedBox(height: 8,),

                SizedBox(
                  height:
                      35, // Set the desired height for the horizontal scroll
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 24, // Set the total number of items
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              hourSelected = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color:  hourSelected == index ? AppColor.orange : AppColor.navyPale),
                                color: hourSelected == index ? AppColor.paleOrange : AppColor.navyPale,
                            ),
                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 8),
                            child:  SemiBoldText(
                              text: '$index:00',
                              fontSize: 15,
                              color: AppColor.forText,
                            ),
                          ),
                        );
                      }),
                ),

                SizedBox(
                  height: 16,
                ),
                SemiBoldText(
                    text: 'Chọn thời hạn',
                    fontSize: 15,
                    color: AppColor.forText),
                const SizedBox(height: 8,),
                SizedBox(
                  height:
                  35, // Set the desired height for the horizontal scroll
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 12, // Set the total number of items
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              durationSelected = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color:  durationSelected == index ? AppColor.orange : AppColor.navyPale),
                              color: durationSelected == index ? AppColor.paleOrange : AppColor.navyPale,
                            ),
                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 8),
                            child:  SemiBoldText(
                              text: '${index + 1} giờ',
                              fontSize: 15,
                              color: AppColor.forText,
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 24,
                ),
                MyButton(
                  text: 'Áp dụng',
                  function: () {
                    Navigator.pop(context);
                  },
                  textColor: Colors.white,
                  backgroundColor: AppColor.navy,
                  minWidth: double.infinity,
                )
              ],
            ),
          );
        });
      },
    );
  }
}
