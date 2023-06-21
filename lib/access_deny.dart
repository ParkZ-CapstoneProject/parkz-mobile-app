import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/medium.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class DenyPage extends StatelessWidget {
  final String errorMessage;

  const DenyPage({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (errorMessage.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Lỗi'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.block,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            SemiBoldText(text: 'Quyền truy cập từ chối', fontSize: 24, color: Colors.redAccent),
            SizedBox(height: 8),
            MediumText(text: 'Hãy cấp quyền truy cập ví trí để sử dụng ứng dụng', fontSize: 12, color: AppColor.forText),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
