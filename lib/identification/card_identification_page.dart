import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkz/authentication/authentication_page.dart';
import 'package:parkz/identification/component/bullet.dart';
import 'package:parkz/identification/infomation_identification.dart';
import 'package:parkz/model/ekyc_response.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/loading/loading.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import 'component/parking_term.dart';

class CardIdentificationPage extends StatefulWidget {
  const CardIdentificationPage({Key? key}) : super(key: key);

  @override
  State<CardIdentificationPage> createState() => _CardIdentificationPageState();
}

class _CardIdentificationPageState extends State<CardIdentificationPage> {
  String idFrontPath = '';
  String idBackPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navyPale,
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 36.0, right: 36, top: 18, bottom: 18),
        child: SizedBox(
          child: MyButton(
              text: 'Tiếp tục',
              function:  (idFrontPath !='' && idBackPath!='')  ? submitEKYC  : null,
              textColor: Colors.white,
              backgroundColor: AppColor.navy),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: AppColor.forText),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationPage()),);
              },
            );
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  const InformationIdentification()),
                );
              },
              child: const SemiBoldText(
                  text: 'Bỏ qua', fontSize: 13, color: AppColor.forText))
        ],
        backgroundColor: Colors.white,
        title: const SemiBoldText(
            text: 'Đăng ký tài khoản', fontSize: 20, color: AppColor.forText),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 36.0, right: 36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const SemiBoldText(
                  text: 'Quét để đăng ký tài khoản nhanh chóng ',
                  fontSize: 17,
                  color: AppColor.forText),
              const SizedBox(
                height: 8,
              ),
              const BulletText(txt: 'Chụp trong môi trường đủ ánh sáng.'),
              const BulletText(txt: 'Ảnh không bị mất góc.'),
              const BulletText(txt: 'Căn chỉnh ảnh chụp đúng với khung hình.'),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ParkingTermsScreen()));
                },
                child: const SemiBoldText(
                    text: ' Điều khoản sử dụng',
                    fontSize: 17,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 24,
              ),
              const SemiBoldText(
                  text: 'Mặt trước CMND/CCCD',
                  fontSize: 17,
                  color: AppColor.forText),
              const SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        selectImage(true);
                        setState(() {});
                      },
                      child: DottedBorder(
                        dashPattern: const [8, 8],
                        color: AppColor.navy,
                        strokeWidth: 2,
                        child: SizedBox(
                          width: double.infinity,
                          child: idFrontPath == ''
                              ? Image.asset(
                                  'assets/image/cmnd_front.png',
                                )
                              : Image.file(File(idFrontPath),
                                  fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    heightFactor: 6.8,
                    alignment: Alignment.bottomRight,
                      child: Icon(
                    Icons.camera_alt,
                    color: AppColor.navy,
                    size: 30,
                  ))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const SemiBoldText(
                  text: 'Mặt sau CMND/CCCD',
                  fontSize: 17,
                  color: AppColor.forText),
              const SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        selectImage(false);
                        setState(() {});
                      },
                      child: DottedBorder(
                        dashPattern: const [8, 8],
                        color: AppColor.navy,
                        strokeWidth: 2,
                        child: SizedBox(
                          width: double.infinity,
                          child: idBackPath == ''
                              ? Image.asset('assets/image/cmnd_back.png')
                              : Image.file(File(idBackPath), fit: BoxFit.fitHeight),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                      heightFactor: 6.8,
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColor.navy,
                        size: 30,
                      ))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future selectImage(bool isFront) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Chọn ảnh từ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (isFront == true) {
                              idFrontPath = await selectImageFromGallery();
                            } else {
                              idBackPath = await selectImageFromGallery();
                            }
                            if (idFrontPath != '' || idBackPath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Chưa chọn ảnh nào!"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(Icons.image,
                                        size: 25, color: AppColor.navy),
                                    Text('Thư viện'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (isFront == true) {
                              idFrontPath = await selectImageFromCamera();
                            } else {
                              idBackPath = await selectImageFromCamera();
                            }

                            if (idFrontPath != '' || idBackPath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 25,
                                      color: AppColor.navy,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  submitEKYC() async {
    Utils(context).startLoading();
    File imageFile = File(idFrontPath);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    File imageFile2 = File(idBackPath);
    List<int> imageBytes2 = imageFile2.readAsBytesSync();
    String base64Image2 = base64Encode(imageBytes2);

    EkycResponse  userInfomation = await ekycRegister(base64Image, base64Image2);

    Utils(context).stopLoading();

    if(userInfomation.resultCode == 101){
      Utils(context).showErrorSnackBar('Hình ảnh phải là CCCD/CMND');
    }
    if (userInfomation.resultCode == 109){
      Utils(context).showErrorSnackBar('Dữ liệu không hợp lệ');
    }
    if(userInfomation.resultCode == 200){
      await  Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  InformationIdentification(userInfo: userInfomation)),
      );
    }






  }
}
