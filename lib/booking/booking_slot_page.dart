import 'package:flutter/material.dart';
import 'package:parkz/booking/booking_detail.dart';
import 'package:parkz/booking/component/booking_slot_loading.dart';
import 'package:parkz/booking/component/slot.dart';
import 'package:parkz/model/slots_response.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import '../model/floors_response.dart';
import '../utils/loading/loading.dart';

class BookingSlotPage extends StatefulWidget {
  final List<Floor> floors;
  final DateTime startTime;
  final DateTime endTime;
  const BookingSlotPage(
      {Key? key,
      required this.floors,
      required this.startTime,
      required this.endTime})
      : super(key: key);

  @override
  State<BookingSlotPage> createState() => _BookingSlotPageState();
  static String floorNameGlobal = '';
  static String slotNameGlobal = '';
  static int slotId = -1;

}

class _BookingSlotPageState extends State<BookingSlotPage> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  late Floor selectedFloor = widget.floors.first;
  List<ParkingSlot> slots = [];

  Future<void> _getSlots(id) async {
    SlotsResponse resonse = await getSlotsParkingByFloor(id, widget.startTime, widget.endTime);
    if(resonse.data != null){
      List<ParkingSlot> storeSlot = resonse.data!;
      setState(() {
        slots = storeSlot;
      });
    }
  }


  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    int selectedSlotIndex = -1;
    ParkingSlot slotSelected = ParkingSlot();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: const BackButton(color: AppColor.forText),
        backgroundColor: Colors.white,
        title: const SemiBoldText(
            text: 'Đặt chỗ', fontSize: 20, color: AppColor.forText),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 18, bottom: 8, top: 8),
                    margin: const EdgeInsets.only(left: 8, right: 8,),
                    height: 49,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.navyPale),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: DropdownButton<Floor>(
                            isExpanded: true,
                            value: selectedFloor,
                            onChanged: (newValue) {
                              setState(() {
                                selectedFloor = newValue!;
                                _getSlots(selectedFloor.floorId);
                              });
                            },
                            items: widget.floors.map((floor) {
                              return DropdownMenuItem<Floor>(
                                value: floor,
                                child: Text(floor.floorName!),
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.only(bottom: 3),
                          icon: const Icon(Icons.refresh,),
                          onPressed: () {
                            _refreshData();
                          },
                        ),
                      ],
                    ),

                  ),
                );
              },
            )),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 30.0, right: 30, bottom: 16, top: 16),
        child: MyButton(
            text: 'Tiếp tục',
            function: () {
              BookingSlotPage.slotNameGlobal = slotSelected.parkingSlotDto!.name!;
              BookingSlotPage.slotId = slotSelected.parkingSlotDto!.parkingSlotId!;
              BookingSlotPage.floorNameGlobal = selectedFloor.floorName!;

              Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingDetail()),);
            },
            textColor: Colors.white,
            backgroundColor: AppColor.navy),
      ),
      body: FutureBuilder<SlotsResponse>(
          future: getSlotsParkingByFloor(selectedFloor.floorId, widget.startTime.toIso8601String(), widget.endTime.toIso8601String()),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const BookingSlotLoading();
            }

            if (snapshot.hasError) {
              return const SizedBox(
                width: double.infinity,
                height: 310,
                child: Center(
                  child: SemiBoldText(
                      text: 'Không có slot hợp lệ trong ngày giờ này',
                      fontSize: 19,
                      color: AppColor.forText),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              if (snapshot.data!.data!.isNotEmpty) {
                slots = snapshot.data!.data!;
                slots.sort((a, b) => a.parkingSlotDto!.columnIndex!.compareTo(b.parkingSlotDto!.columnIndex!),);
                int maxColumnIndex = 0;
                int maxRowIndex = 0;
                //Find max column and row
                for (var slot in slots) {
                  if (slot.parkingSlotDto!.columnIndex! > maxColumnIndex) {
                    maxColumnIndex = slot.parkingSlotDto!.columnIndex!;
                  }
                  if (slot.parkingSlotDto!.rowIndex! > maxRowIndex) {
                    maxRowIndex = slot.parkingSlotDto!.rowIndex!;
                  }
                }

                return StatefulBuilder(builder: (context, setState) {
                  //Map ở đây nè
                  List<DataRow> myRows = [];

                  for (int rowIndex = 0; rowIndex <= maxRowIndex; rowIndex++) {

                    List<DataCell> myCells = [];

                    for (int cellIndex = 0; cellIndex <= maxColumnIndex; cellIndex++) {

                      ParkingSlot? slot = slots.firstWhere((element) => element.parkingSlotDto?.columnIndex == cellIndex && element.parkingSlotDto?.rowIndex == rowIndex, orElse: () => ParkingSlot(),);
                      if (slot.parkingSlotDto != null) {
                        myCells.add(
                          DataCell(
                            onTap: () {
                              setState(() {
                                selectedSlotIndex = rowIndex * 10 + cellIndex;
                                if(slot.isBooked == 0){
                                  slotSelected = slot;
                                }else{
                                  Utils(context).showWarningSnackBar('Vui lòng chọn chỗ khác');
                                }
                              }
                              );
                            },

                            Slot(
                                isSelected: selectedSlotIndex == rowIndex * 10 + cellIndex,
                                slotId: slot.parkingSlotDto!.parkingSlotId!,
                                isBooked: slot.isBooked!,
                                srow: slot.parkingSlotDto!.rowIndex!,
                                scell: slot.parkingSlotDto!.columnIndex!,
                                name: slot.parkingSlotDto!.name! ),
                          ),
                        );
                      } else {
                        // Add an empty cell if no slot exists at the current column and row indices
                        myCells.add(
                          DataCell(Container(color: Colors.grey, height: 120, width: 140,)),
                        );
                      }
                    }

                    myRows.add(DataRow(cells: myCells,),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _verticalScrollController,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _horizontalScrollController,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                        child: DataTable(
                          horizontalMargin: 0,
                          headingRowHeight: 0,
                          dataRowMaxHeight: 120,
                          dataRowMinHeight: 120,
                          columnSpacing: 0,
                          dividerThickness: 0,
                          showCheckboxColumn: false,
                          border: TableBorder.all(
                            color: AppColor.fadeText,
                            width: 0.5,
                          ),

                          columns: List.generate(
                            maxColumnIndex + 1,
                            (index) => const DataColumn(
                              label: SizedBox.shrink(),
                            ),
                          ),

                          rows: myRows,
                        ),
                      ),
                    ),
                  );
                });
              } else {
                return const SizedBox(
                  width: double.infinity,
                  height: 310,
                  child: Center(
                    child: SemiBoldText(
                        text: 'Không có slot trong bãi.',
                        fontSize: 19,
                        color: AppColor.forText),
                  ),
                );
              }
            }
            return const SizedBox(
              width: double.infinity,
              height: 310,
              child: Center(
                child: SemiBoldText(
                    text: '[U]Không có slot trong bãi xe',
                    fontSize: 19,
                    color: AppColor.forText),
              ),
            );
          }),
    );
  }
}
