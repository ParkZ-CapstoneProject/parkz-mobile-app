import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NearByLoadingList extends StatelessWidget {
  const NearByLoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 12),
        itemBuilder: (context, index) {
          return  Shimmer.fromColors(baseColor: Colors.grey.withOpacity(0.5), highlightColor: Colors.white, child: const NearByShim());
        },
        itemCount: 5,
      ),
    );
  }
}

class NearByShim extends StatelessWidget {
  const NearByShim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 254,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only( topRight:  Radius.circular(7.0), topLeft:  Radius.circular(7.0)),
              child: Container(height: 120, width: 254, color: Colors.grey,)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 80,
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 12,
                  color: Colors.grey,
                ),
              ),

          ],),
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
            child: Container(
              width: 250,
              height: 12,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
            child: Container(
              width: 250,
              height: 12,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
            child: Container(
              width: 250,
              height: 12,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
            child: Container(
              width: 250,
              height: 12,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
            child: Container(
              width: 250,
              height: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
