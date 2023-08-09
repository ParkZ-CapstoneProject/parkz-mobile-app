import 'package:flutter/material.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading_page.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:parkz/vehicle/component/vehicle_card.dart';

import '../home/components/parking_horizontal_shim_list.dart';
import '../model/createVehicleRespnse.dart';
import '../model/vehicles_response.dart';
import '../network/api.dart';
import '../utils/loading/loading.dart';

class VehiclePage extends StatefulWidget {
  final bool isSelected;
  const VehiclePage({Key? key, required this.isSelected}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  String? userID;
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  void getToken() async {
    String? storeUserId = await storage.read(key: 'userID');
    if (storeUserId != null) {
      setState(() {
        userID = storeUserId;
      });
    } else {

    }
  }

  Future<void> _refreshData() async {
    setState(() {});
  }

  void _showFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          insetPadding: EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: licensePlateController,
                  decoration: const InputDecoration(
                    labelText: 'Biển số xe',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: vehicleNameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên phương tiện',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: colorController,
                  decoration: const InputDecoration(
                    labelText: 'Màu xe',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.navy, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                MyButton(text: 'Tạo xe', function:  () async {
                  String licensePlate = licensePlateController.text;
                  String vehicleName = vehicleNameController.text;
                  String color = colorController.text;
                  CreateVehicleResponse? response =  await createVehicle(licensePlate, vehicleName, color);
                  if(response != null){
                    setState(() {

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
    getToken();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (userID != null && userID != '') {
      return Scaffold(
        backgroundColor: AppColor.navyPale,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showFullScreenDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: const BackButton(color: AppColor.forText),
          backgroundColor: Colors.white,
          title: const SemiBoldText(
              text: 'Quản lý phương tiện',
              fontSize: 20,
              color: AppColor.forText),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: FutureBuilder<VehicleListResponse>(
              future: getVehicleList(int.parse(userID!)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ParkinkCardHomeLoadingList();
                }
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.data!.isNotEmpty) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8,),
                      padding: const EdgeInsets.only(top: 8),
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(snapshot.data!.data![index].vehicleInforId.toString()), // Unique key for each item
                          onDismissed: (direction)  {
                           deleteVehicle(snapshot.data!.data![index].vehicleInforId!);
                          },
                          background: Container(
                            color: Colors.red,
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap:  widget.isSelected == true ? () {
                              Navigator.pop(context,snapshot.data!.data![index]);
                            } : null,
                            child: VehicleCard(
                              vehicleName: snapshot.data!.data![index].vehicleName!,
                              licensePlate: snapshot.data!.data![index].licensePlate!,
                              color: snapshot.data!.data![index].color!,
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.data!.length,
                    );
                  } else {
                    return const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: SemiBoldText(
                            text: 'Không phương tiện',
                            fontSize: 19,
                            color: AppColor.forText),
                      ),
                    );
                  }
                }
                if (snapshot.hasError) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 510,
                    child: Center(
                      child: SemiBoldText(
                          text: 'Lỗi không xác định',
                          fontSize: 19,
                          color: AppColor.forText),
                    ),
                  );
                }
                return const SizedBox(
                  width: double.infinity,
                  height: 510,
                  child: Center(
                    child: SemiBoldText(
                        text: '[U]Không có bãi xe gần bạn',
                        fontSize: 19,
                        color: AppColor.forText),
                  ),
                );
              }),
        ),
      );
    }
    return const LoadingPage();
  }
}
