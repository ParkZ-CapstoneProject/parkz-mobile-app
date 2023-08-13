import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:parkz/booking/booking_page.dart';
import 'package:parkz/booking/component/vehicle_selected.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/parkingdetail/component/bottom_parking_bar.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading_page.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/regular.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:parkz/vehicle/vehicle_page.dart';

import '../model/createVehicleRespnse.dart';
import '../model/ecpected_price_response.dart';
import '../model/profile_response.dart';
import '../model/vehicles_response.dart';
import '../parkingdetail/parking_detail_page.dart';
import '../utils/loading/loading.dart';
import 'booking_slot_page.dart';
import 'component/parking_message.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  double containerPadding = 24;
  int selectedPaymentType = 1; // 0: Thanh toán trước, 1: Thanh toán trả sau
  Vehicle? result;
  String? nameBook;
  String? phoneBook;
  String? guessNameBook;
  String? guessPhoneBook;

  TextEditingController guessNameController = TextEditingController();
  TextEditingController guessPhoneController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController colorController = TextEditingController();


  String moneyFormat(double number) {
    String formattedNumber = number.toStringAsFixed(0); // Convert double to string and remove decimal places
    return formattedNumber.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
    );
  }

  Future<void> _getCustomerName(context) async {
    ProfileResponse? profileResponse = await getProfile(context);
    if(profileResponse != null ){
      setState(() {
        nameBook = profileResponse.data!.name;
        phoneBook = profileResponse.data!.phone;

      });
    }

  }

  Future<void> _chooseVehicle(BuildContext context) async {
    Vehicle? storeResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VehiclePage( isSelected: true,)),
    );
    setState(() {
      result = storeResult;
    });
  }

  void _showFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // insetPadding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: guessNameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên người đặt hộ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: guessPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Số điện thoại người đặt hộ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: licensePlateController,
                  decoration: const InputDecoration(
                    labelText: 'Biển số xe người đặt hộ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: vehicleNameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên phương tiện người đặt hộ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: colorController,
                  decoration: const InputDecoration(
                    labelText: 'Màu xe người đặt hộ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                MyButton(text: 'Đặt hộ', function:  () async {
                  guessNameBook = guessNameController.text;
                  guessPhoneBook = guessPhoneController.text;

                  String licensePlate = licensePlateController.text;
                  String vehicleName = vehicleNameController.text;
                  String color = colorController.text;
                  CreateVehicleResponse? response =  await createVehicleGuest(licensePlate, vehicleName, color);
                  if(response != null){
                    setState(() {
                      result = Vehicle(color: color, licensePlate: licensePlate, vehicleName: vehicleName, vehicleInforId: response.data);
                      nameBook = guessNameBook;
                      phoneBook = guessPhoneBook;
                    });

                    Navigator.of(context).pop();

                  }else{
                    Utils(context).showWarningSnackBar('Tạo xe thất bại');
                  }
                }, textColor: Colors.white, backgroundColor: AppColor.navy)
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    _getCustomerName(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExpectedPriceResponse>(
      future: getExpectedPrice(ParkingDetailPage.parkingIdGlobal, BottomParkingBar.startDateTimeGlobal.toIso8601String(), BottomParkingBar.durationGlobal),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingPage();
        }
        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          if(snapshot.data?.data != null){
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
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SemiBoldText(
                            text: 'Tổng thanh toán',
                            fontSize: 20,
                            color: AppColor.navy),
                        SemiBoldText(
                            text: '${ moneyFormat(snapshot.data!.data!)} VND',
                            fontSize: 24,
                            color: AppColor.forText),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                          text: 'Xác nhận giao dịch',
                          function: ()  {

                            if(result != null){
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.bottomSlide,
                                title: 'Thông tin đến bạn',
                                body: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Center(child: SemiBoldText(text: 'Thông tin', fontSize: 15, color: AppColor.forText),),
                                      const Divider(color: AppColor.navy, thickness: 1,),
                                      const SizedBox(height: 16), // Add some spacing between text and the bottom
                                      Text(
                                        parkingServiceText.line1,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(height: 8), // Add some spacing between text and the bottom
                                      Text(
                                        parkingServiceText.line2,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(height: 8), // Add some spacing between text and the bottom

                                      Text(
                                        parkingServiceText.line3,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: double.infinity,
                                        child: MyButton(text: 'Đặt chỗ', function: () async {
                                          int? bookingId = await createPostPayBooking(
                                              BookingSlotPage.slotId,
                                              BottomParkingBar.startDateTimeGlobal.toIso8601String(),
                                              BottomParkingBar.endDateTimeGlobal.toIso8601String(),
                                              DateFormat('yyyy-MM-dd').format(BottomParkingBar.startDayGlobal).toString(),
                                              result!.vehicleInforId,
                                              selectedPaymentType,
                                              guessNameBook,
                                              guessPhoneBook,
                                              context
                                          );
                                          if(bookingId != null){
                                            debugPrint('BookingIDne: $bookingId');
                                            await Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>  BookingPage(bookingId: bookingId,)),
                                            );
                                          }

                                        }, textColor: Colors.white, backgroundColor: AppColor.navy),
                                      )

                                    ],
                                  ),
                                ),
                              ).show();
                            }else {
                              Utils(context).showWarningSnackBar('Bạn phải chọn phương tiện');
                            }
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
                      const SizedBox(height: 19),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.network(ParkingDetailPage.parkingAva,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      MediumText(
                                          text: ParkingDetailPage.parkingName,
                                          fontSize: 14,
                                          color: AppColor.forText),
                                      SemiBoldText(
                                          text: '${BookingSlotPage.floorNameGlobal} -  ${BookingSlotPage.slotNameGlobal}',
                                          fontSize: 17,
                                          color: AppColor.forText)
                                    ],
                                  ),
                                   RegularText(
                                      text: ParkingDetailPage.parkingName,
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
                                    const SizedBox(
                                      height: 11,
                                    ),
                                     SemiBoldText(
                                        text: '${BottomParkingBar.durationGlobal} Giờ',
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
                                children:  [
                                  const RegularText(
                                      text: 'Giờ vào',
                                      fontSize: 13,
                                      color: AppColor.forText),
                                  SemiBoldText(
                                      text: '${BottomParkingBar.startTimeGlobal}:00 - ${DateFormat('dd/MM/yyyy').format(BottomParkingBar.startDayGlobal)}',
                                      fontSize: 16,
                                      color: AppColor.forText),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  const RegularText(
                                      text: 'Giờ ra',
                                      fontSize: 13,
                                      color: AppColor.forText),
                                  SemiBoldText(
                                      text: '${BottomParkingBar.endTimeGlobal}:00 - ${DateFormat('dd/MM/yyyy').format(BottomParkingBar.endDayGlobal)}',
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
                        children:  [
                          const SemiBoldText(
                              text: 'Thông tin người đặt',
                              fontSize: 20,
                              color: AppColor.forText),
                          InkWell(
                            onTap: () {
                              _showFullScreenDialog(context);
                                  },
                            child: const SemiBoldText(
                                text: 'Đặt hộ',
                                fontSize: 15,
                                color: AppColor.orange),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          const MediumText(
                              text: 'Tên', fontSize: 14, color: AppColor.forText),
                          SemiBoldText(
                              text: nameBook.toString(),
                              fontSize: 15,
                              color: AppColor.forText)
                        ],
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          const MediumText(
                              text: 'Số điện thoại',
                              fontSize: 14,
                              color: AppColor.forText),
                          SemiBoldText(
                              text: phoneBook.toString(),
                              fontSize: 15,
                              color: AppColor.forText)
                        ],
                      ),
                      const SizedBox(height: 10),
                      result == null ?
                      InkWell(
                        onTap: () {
                          _chooseVehicle(context);
                        },
                        child:  DottedBorder(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SemiBoldText(text: 'Chọn phương tiện', fontSize: 15, color: AppColor.forText),
                                    SizedBox(width: 5,),
                                    Icon(Icons.add, color: AppColor.navy),
                                  ],
                                ),
                              ),
                            )),
                      ) : VehicleSelected(
                          vehicleName: result!.vehicleName!,
                          licensePlate: result!.licensePlate!,
                          color: result!.color!,
                        function: () {
                          setState(() {
                            result = null;
                          });
                        },

                      )

                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 29, right: 29, top: 17, bottom: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SemiBoldText(text: 'Thanh toán', fontSize: 20, color: AppColor.forText),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const MediumText(text: 'Thanh toán trả sau', fontSize: 15, color: AppColor.forText,),
                            trailing: Radio<int>(
                              activeColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                              value: 1,
                              groupValue: selectedPaymentType,
                              onChanged: (value) {
                                setState(() {
                                  selectedPaymentType = value!;
                                });
                              },
                            ),
                          ),

                          ParkingDetailPage.parkingPrepay == true ?
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const MediumText(text: 'Thanh toán trả trước', fontSize: 15, color: AppColor.forText,),
                            trailing: Radio<int>(
                              activeColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                              value: 0,
                              groupValue: selectedPaymentType,
                              onChanged: (value) {
                                setState(() {
                                  selectedPaymentType = value!;
                                });
                              },
                            ),
                          ) : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        );
        }else {
            return const SizedBox(
            width: double.infinity,
            height: 310,
            child: Center(child: SemiBoldText(text: 'Không tính được phí tạm tính', fontSize: 19, color: AppColor.forText),),
            );
        }
  }
        if(snapshot.hasError){
          return  Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: SemiBoldText(text: 'Đã có lỗi xảy ra ${snapshot.error}', fontSize: 10, color: AppColor.forText, maxLine: 6),),
            ),
          );
        }
        return  Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: const Center(child: SemiBoldText(text: 'Đã có lỗi xảy ra', fontSize: 19, color: AppColor.forText),),
        );
      }
    );
  }
}

