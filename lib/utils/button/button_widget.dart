import 'package:flutter/material.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? function;
  final Color textColor;
  final Color backgroundColor;
  final double? minWidth;
  final double? minHeight;
  final double? borderRadius;

  const MyButton({Key? key, required this.text, required this.function, required this.textColor, required this.backgroundColor, this.minWidth, this.minHeight, this.borderRadius}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double? width = 150.0;
    double? height = 42.0;
    late double? radius = 50;
    if(minWidth != null){
      width = minWidth;
    }
    if(minHeight != null ){
      height = minHeight;
    }
    if(borderRadius != null){
      radius = borderRadius;
    }

    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        minimumSize: Size(width!, height!),
      ),
      child: SemiBoldText(text: text, fontSize: 13, color: textColor),
    );
  }
}
