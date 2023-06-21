import 'package:flutter/material.dart';
import 'package:parkz/bottombar/bottombar_page.dart';
import 'package:parkz/introduction/component/animation_button.dart';
import 'package:parkz/introduction/component/intro_builder_1.dart';
import 'package:parkz/introduction/component/intro_builder_2.dart';
import 'package:parkz/introduction/component/intro_builder_3.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PageController _controller = PageController();

  // keep track on the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              if (index == 2) {
                onLastPage = true;
              }
            });
          },
          children: const [
            IntroductionBuilder1(),
            IntroductionBuilder2(),
            IntroductionBuilder3(),
          ],
        ),
        Container(
            alignment: const Alignment(0, -0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 90,
                ),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: AppColor.orange,
                    dotColor: AppColor.fadeText,
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                  ),
                ),

                onLastPage == false
                    ? InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>  const MyBottomBar(selectedInit: 0)),
                          );
                        },
                        child: const SizedBox(height: 80, width: 80,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(right: 18.0),
                              child: SemiBoldText(
                                text: 'Bỏ qua',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(height: 80, width: 80,),
              ],
            )),
        if(onLastPage == true)
        AnimationButton(onFinalPage: onLastPage),
      ]),
    );
  }
}
