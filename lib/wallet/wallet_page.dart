import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:parkz/utils/input/input_widget.dart';
import 'package:parkz/utils/text/regular.dart';

import '../home/components/title_list.dart';
import '../network/api.dart';
import '../utils/button/button_widget.dart';
import '../utils/constanst.dart';
import '../utils/loading/loading.dart';
import '../utils/text/semi_bold.dart';
import 'component/icon_button.dart';
import 'component/vnpay_page.dart';

// import 'package:url_launcher/url_launcher.dart';


class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  TextEditingController money = TextEditingController();
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
                SizedBox(height: 8),
                MyInput(
                  labelText: 'Số tiền',
                  borderColor: AppColor.navy,
                  controller: money,
                  isMultiLine: false,
                  isNumber: true,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: MyButton(
                        text: 'Nạp tiền',
                        function: () async {

                          int amountMoney = int.parse(money.text);
                          String vnPayLink = await depositWallet(amountMoney, context);
                          print('Link VN PAy $vnPayLink');
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>   VnPayPage(urlVNPay: vnPayLink,)),
                            );



                          //final Uri url = Uri.parse(vnPayLink);
                          // var a = await launchUrl(url);
                          // if (await canLaunchUrl(url)){
                          //   await launchUrl(url);
                          // } else {
                          //   Utils(context).showWarningSnackBar('Đã có lỗi xảy ra');
                          // }
                        },
                        textColor: Colors.white,
                        backgroundColor: AppColor.navy),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: const BackButton(color: AppColor.forText),
          backgroundColor: Colors.white,
          title: const SemiBoldText(
              text: 'Ví thanh toán', fontSize: 20, color: AppColor.forText),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, left: 28.0, right: 28.0, bottom: 18),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xFF064789),
                              Color(0xFF023B72),
                              Color(0xFF034AA6),
                              Color(0xFF032445)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SemiBoldText(
                                text: '150 000 đ',
                                fontSize: 28,
                                color: Colors.white),
                            SizedBox(
                              height: 8,
                            ),
                            RegularText(
                                text: 'Tổng số dư',
                                fontSize: 14,
                                color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: InkWell(
                          onTap: () {
                            _showFullScreenDialog(context);
                          },
                          child: const CustomButton(
                              icon: 'assets/icon/wallet_nap_icon.svg',
                              title: 'Nạp tiền',
                              backgroundColor: AppColor.navy,
                              textColor: Colors.white),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: InkWell(
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.bottomSlide,
                              title: 'Thông tin',
                              desc:
                                  'Liên hệ trụ sỡ gần nhất của ParkZ \n để được hỗ trợ rút tiền',
                              btnOkOnPress: () {},
                            ).show();
                          },
                          child: const CustomButton(
                              icon: 'assets/icon/wallet_rut_icon.svg',
                              title: 'Rút tiền',
                              backgroundColor: Colors.white,
                              textColor: AppColor.navy),
                        )),
                      ],
                    ),
                    // Add more widgets below if needed
                    const SizedBox(height: 32,),
                    const TitleList(title: 'Lịch sử',),

                    const SizedBox(height: 16,),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ListTile(
                            leading: Icon(Icons.monetization_on, color: AppColor.navy),
                            title:  SemiBoldText(text: 'Thanh toán', fontSize: 17, color: AppColor.forText),
                            trailing: SemiBoldText(text: '20 000', fontSize: 15, color: AppColor.forText),
                            // subtitle: MediumText(text: '08/21/2022', fontSize: 14, color: AppColor.navy),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColor.navyPale, thickness: 1,),
                        itemCount: 25
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
