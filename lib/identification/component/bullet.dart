import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';

class BulletText extends StatelessWidget {
  final String txt;

  const BulletText({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('\u2022'),
        const SizedBox(width: 5),
        Expanded(
            child: Text(txt, style: const TextStyle(color: AppColor.navy),)
        )
      ],
    );
  }
}
