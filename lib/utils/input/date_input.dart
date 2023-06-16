import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';

class DateFormatInput extends StatefulWidget {
  final String labelText;
  final Color borderColor;
  final TextEditingController controller;
  const DateFormatInput({super.key, required this.labelText, required this.borderColor, required this.controller});

  @override
  _DateFormatInputState createState() => _DateFormatInputState();
}

class _DateFormatInputState extends State<DateFormatInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.controller.text;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: AppColor.navy,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColor.forText
        ),

        onChanged: (value) {
          value = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
          if (value.length > 2) {
            // Insert '/' after every two digits
            value = value.substring(0, 2) + '/' + value.substring(2);
          }
          if (value.length > 5) {
            // Insert '/' after every two other digits
            value = value.substring(0, 5) + '/' + value.substring(5);
          }
          if (value.length > 10) {
            // Limit the input to 11 characters
            value = value.substring(0,10);
          }
          _controller.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(
                offset: value.length
            ),
          );
        },
      ),
    );
  }
}
