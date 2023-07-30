import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkz/utils/input/input_widget.dart';
import 'package:parkz/utils/loading/loading.dart';
import 'package:parkz/utils/text/regular.dart';

import '../home/components/title_list.dart';
import '../location/component/search_loading_widget.dart';
import '../model/balanceResponse.dart';
import '../model/transaction_response.dart';
import '../network/api.dart';
import '../utils/button/button_widget.dart';
import '../utils/constanst.dart';
import '../utils/text/medium.dart';
import '../utils/text/semi_bold.dart';
import 'component/icon_button.dart';
import 'component/vnpay_page.dart';


class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}



class _WalletPageState extends State<WalletPage> {
  TextEditingController money = TextEditingController();

  showVnPay(amountMoney, context) async {
    String? vnPayLink = await depositWallet(amountMoney);
    debugPrint('Link VN PAy $vnPayLink');
    if(vnPayLink != null){
      bool isSucceed = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  VnPayPage(urlVNPay: vnPayLink,)),
      );
      if(isSucceed == true){
        setState(() {
        });
      }
    }else {
      Utils(context).showErrorSnackBar('Không lấy được Link thanh toán');
    }
  }


  void _showFullScreenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
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
                        function: ()  {
                          Navigator.pop(context);
                          int amountMoney = int.parse(money.text);
                          showVnPay(amountMoney, this.context);
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

  Future<void> _refreshData() async {
    setState(() {});
  }
  String moneyFormat(double number) {
    String formattedNumber = number.toStringAsFixed(0); // Convert double to string and remove decimal places
    return formattedNumber.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
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
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [
              SingleChildScrollView(
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
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder<BalanceResponse?>(
                                  future: getBalance(context),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                                      if(snapshot.data!.data != null ){
                                        return SemiBoldText(
                                            text: '${moneyFormat(snapshot.data!.data!.balance!)} đ',
                                            fontSize: 28,
                                            color: Colors.white);
                                      }else {
                                        return const SemiBoldText(
                                            text: '------ đ',
                                            fontSize: 28,
                                            color: Colors.white);
                                      }
                                    }
                                    return const SemiBoldText(
                                        text: '--- đ',
                                        fontSize: 28,
                                        color: Colors.white);
                                }
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const RegularText(
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
                                    desc: 'Liên hệ trụ sỡ gần nhất của ParkZ \n để được hỗ trợ rút tiền',
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
                      FutureBuilder<TransactionResponse?>(
                          future: getTransactionHistory(context),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const SearchLoadingWidget();
                            }
                            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                            if(snapshot.data!.data!.isNotEmpty){

                              List<Transaction> listTransation = snapshot.data!.data!.reversed.toList();

                              return ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return  ListTile(
                                      isThreeLine: true,
                                      contentPadding: EdgeInsets.zero,
                                      leading: listTransation[index].status == 'Nap_tien_vao_vi_thanh_cong' ? const Icon(Icons.monetization_on, color: AppColor.navy, size: 30) : const Icon(Icons.monetization_on, color: AppColor.orange, size: 30) ,
                                      title:  SemiBoldText(text: listTransation[index].description == null ? 'Thanh toán đơn' : listTransation[index].description!, fontSize: 17, color: AppColor.forText),
                                      trailing: SemiBoldText(text: listTransation[index].status == 'Nap_tien_vao_vi_thanh_cong' ? '+ ${moneyFormat(listTransation[index].price!)} đ' : ' - ${moneyFormat(listTransation[index].price!)} đ' , fontSize: 15, color: AppColor.forText),
                                      subtitle: MediumText(text: DateFormat('HH:mm - dd/MM/yyyy').format(listTransation[index].createdDate!).toString(), fontSize: 14, color: AppColor.navy),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => const Divider(color: AppColor.navyPale, thickness: 1,),
                                  itemCount:  snapshot.data!.data!.length
                              );
                            }else{
                              return const Center(
                                child: SemiBoldText(text: 'Không có lịch sử giao dịch',
                                color: AppColor.fadeText,
                                fontSize: 15),
                              );
                            }
                            }
                            return const Center(
                              child: SemiBoldText(text: 'Không tìm thấy dữ liệu',
                                  color: AppColor.fadeText,
                                  fontSize: 15),
                            );

                        }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
