import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/regular.dart';

class TagCard extends StatelessWidget {
  final String tagName;
  const TagCard({Key? key, required this.tagName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColor.orange),
      ),
      child: RegularText(text: tagName, color: AppColor.orange, fontSize: 13,),
    );
  }
}
