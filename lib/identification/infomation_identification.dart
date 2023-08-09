import 'package:flutter/material.dart';
import 'package:parkz/authentication/authentication_page.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/model/ekyc_response.dart';
import 'package:parkz/model/register.dart';
import 'package:parkz/network/api.dart';
import 'package:parkz/utils/button/button_widget.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/input/date_input.dart';
import 'package:parkz/utils/input/input_widget.dart';
import 'package:parkz/utils/loading/loading.dart';
import 'package:parkz/utils/text/semi_bold.dart';

import 'component/parking_term.dart';

class InformationIdentification extends StatefulWidget {
  final EkycResponse? userInfo;
  const InformationIdentification({Key? key,  this.userInfo})
      : super(key: key);

  @override
  State<InformationIdentification> createState() =>
      _InformationIdentificationState();
}

class _InformationIdentificationState extends State<InformationIdentification> {
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController idCardController = TextEditingController();
  late TextEditingController dateOfBirthController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController genderController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController idDate = TextEditingController();
  late TextEditingController idIssuedBy = TextEditingController();

  bool isChecked = false;

  @override
  void initState() {

    // TODO: implement initState
    if(widget.userInfo != null){
      final recognizedData = widget.userInfo?.recognizedData;

      if(AuthenticationPage.phone.isNotEmpty){
        phoneController.text = AuthenticationPage.phone;
      }
      if (recognizedData != null) {
        if (recognizedData.id != null) {
          idCardController.text = recognizedData.id!;
        }
        if (recognizedData.birthday != null) {
          dateOfBirthController.text = recognizedData.birthday!;
        }
        if (recognizedData.name != null) {
          nameController.text = recognizedData.name!;
        }
        if (recognizedData.sex != null) {
          genderController.text = recognizedData.sex!;
        }
        if (recognizedData.address != null) {
          addressController.text = recognizedData.address!;
        }
        if (recognizedData.issueDate != null) {
          idDate.text = recognizedData.issueDate!;
        }
        if (recognizedData.issueBy != null) {
          idIssuedBy.text = recognizedData.issueBy!;
        }
      }

      // Show snack bar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnack(context, widget.userInfo?.recognizedData?.warningCode);
      });
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.navyPale,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 18.0, bottom: 18, right: 36, left: 36),

        child: MyButton(
            text: 'Tiếp tục',
            function: isChecked == false ? null :() => register(),
            textColor: Colors.white,
            backgroundColor: AppColor.navy),
      ),

      appBar: AppBar(
        elevation: 0.0,
        leading: const BackButton(color: AppColor.forText),
        backgroundColor: Colors.white,
        title: const SemiBoldText(text: 'Xác thực thông tin', fontSize: 20, color: AppColor.forText),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18,),

            const Padding(
              padding: EdgeInsets.only(left: 18.0, top: 8, bottom: 8),
              child: SemiBoldText(text: 'Thông tin tài khoản', fontSize: 17, color: AppColor.forText),
            ),

            MyInput(
                isMultiLine: false,
                isNumber: true,
                labelText: "Số điện thoại",
                borderColor: AppColor.fadeText,
                controller: phoneController),
            MyInput(
                labelText: "Họ tên",
                isMultiLine: true,
                borderColor: AppColor.fadeText,
                controller: nameController),
            DateFormatInput(
                labelText: "Ngày tháng năm sinh",
                borderColor: AppColor.fadeText,
                controller: dateOfBirthController),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, top: 18, bottom: 8),
              child: SemiBoldText(
                  text: 'Thông tin giấy tờ tùy thân',
                  fontSize: 17,
                  color: AppColor.forText),
            ),
            MyInput(
                isNumber: true,
                isMultiLine: false,
                labelText: "Số chứng minh nhân dân",
                borderColor: AppColor.fadeText,
                controller: idCardController),
            MyInput(
                isMultiLine: false,
                labelText: "Giới tính",
                borderColor: AppColor.fadeText,
                controller: genderController),
            DateFormatInput(
                labelText: "Ngày cấp",
                borderColor: AppColor.fadeText,
                controller: idDate),
            MyInput(
                isMultiLine: true,
                labelText: "Nơi cấp",
                borderColor: AppColor.fadeText,
                controller: idIssuedBy),
            MyInput(
                isMultiLine: true,
                labelText: "Địa chỉ",
                borderColor: AppColor.fadeText,
                controller: addressController),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(
                    fillColor: const MaterialStatePropertyAll(AppColor.orange),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                   Row(
                    children: [
                      const SemiBoldText(
                          text: 'Tôi đồng ý với ',
                          fontSize: 14,
                          color: AppColor.forText),
                      InkWell(
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const ParkingTermsScreen()));
                        },
                        child: const SemiBoldText(
                            text: ' Điều khoản sử dụng',
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
   register() async {
    if (idCardController.text.isEmpty ||
        dateOfBirthController.text.isEmpty ||
        nameController.text.isEmpty ||
        genderController.text.isEmpty ||
        addressController.text.isEmpty ||
        idDate.text.isEmpty ||
        idIssuedBy.text.isEmpty)
    {
      Utils(context).showErrorSnackBar('Bạn phải điền tất cả thông tin');

    }
    else{
      Utils(context).startLoading();
      Register response = await authentication(
          phoneController.text,
          nameController.text,
          dateOfBirthController.text,
          idDate.text,
          genderController.text,
          idCardController.text,
          idIssuedBy.text,
          addressController.text);

      Utils(context).stopLoading();
      if (response.data != null){
        Utils(context).showSuccessSnackBar('Đăng ký thành công');
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const MyBottomBar(selectedInit: 0)),
          (route) => false,
        );
      }else{
        Utils(context).showErrorSnackBar('Đăng ký thất bại');
      }
    }
  }
}

showSnack(context, warningCode) {
  if (warningCode!.isEmpty) {
    Utils(context).showSuccessSnackBar('Đọc thông tin thành công');
  } else {
    Utils(context)
        .showWarningSnackBar('Thông tin mặt trước và mặt sau không khớp');
  }
}

