import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(baseColor: Colors.grey.withOpacity(0.5), highlightColor: Colors.white, child: const SearchLoadingBuilder());
      },
      itemCount: 5,
    );
  }
}

class SearchLoadingBuilder extends StatelessWidget {
  const SearchLoadingBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = 60;
    return  Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: cardHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),)
              ),
              Flexible(
                flex: 6,
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

