import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final bool isEdited;
  const ProfilePic({
    Key? key, required this.isEdited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/03/28/12/35/cat-1285634_1280.png'),
          ),
          isEdited ?
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ) : const SizedBox()
        ],
      ),
    );
  }
}