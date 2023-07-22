import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';

class StatusTag extends StatelessWidget {
  final String status;
  const StatusTag({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.navyPale,
      ),
      child:  RegularText(
          fontSize: 13,
          text: status == "Initial" ? 'Chờ xác nhận'
              : status == "Approve" ? 'Chờ vào bãi'
              : status == "Checkin" ? "Chờ ra bãi"
              : status == "Checkout" ? "Chờ thanh toán"
              :  status == "Done" ? "Hoàn thành"
              : "Hủy đơn",
          color: status == "Initial" ? AppColor.orange
              : status == "Approve" ? AppColor.navy
              : status == "Checkin" ? AppColor.forText
              : status == "Checkout" ? AppColor.orange
              :  status == "Done" ? Colors.green
              : Colors.red
      ),
    );
  }
}
