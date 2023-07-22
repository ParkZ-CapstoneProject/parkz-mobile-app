import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? ava;
  const ProfilePic({
    Key? key, this.ava,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: CircleAvatar (
       backgroundImage: NetworkImage(ava == null ? 'https://cdn.pixabay.com/photo/2016/03/28/12/35/cat-1285634_1280.png' : ava!),
          ),
    );
  }
}