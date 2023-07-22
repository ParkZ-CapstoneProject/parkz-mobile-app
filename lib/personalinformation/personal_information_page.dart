import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';

import '../utils/text/semi_bold.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: AppColor.forText),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const SemiBoldText(
              text: 'Thông tin cá nhân', fontSize: 20, color: AppColor.forText),
          actions: [
            isEdit == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isEdit = true;
                      });
                    },
                    icon: const Icon(Icons.edit))
                : IconButton(onPressed: () {}, icon: const Icon(Icons.save))
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF064789),
                  Color(0xFF023B72),
                  Color(0xFF022F5B),
                  Color(0xFF032445)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2016/03/28/12/35/cat-1285634_1280.png'),
                    ),
                    Positioned(
                      right: 50,
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
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            )
          ],
        ));
  }
}
