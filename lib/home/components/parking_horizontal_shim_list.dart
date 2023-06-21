import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ParkinkCardHomeLoadingList extends StatelessWidget {
  const ParkinkCardHomeLoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(baseColor: Colors.grey.withOpacity(0.5), highlightColor: Colors.white, child: const HomeHorizontalCardShim());
      },
      itemCount: 10,
    );
  }
}

class HomeHorizontalCardShim extends StatelessWidget {
  const HomeHorizontalCardShim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = 110;
    double cardBorder = 12;
    return  Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 20),
      child: ClipRRect(
    borderRadius:  BorderRadius.only(topLeft: Radius.circular(cardBorder), bottomLeft:Radius.circular(cardBorder) ),
    child: SizedBox(
        height: cardHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: cardHeight,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 16, width: 150, color: Colors.grey,),
                    const SizedBox(height: 8,),
                    Container(height: 12, width: double.infinity, color: Colors.grey,),
                    const SizedBox(height: 8,),
                    Container(height: 12,  width: double.infinity, color: Colors.grey,),
                    const SizedBox(height: 8,),
                    Container(height: 12, width: double.infinity, color: Colors.grey,),
                    const SizedBox(height: 8,),
                    Container(height: 12,  width: double.infinity, color: Colors.grey,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

