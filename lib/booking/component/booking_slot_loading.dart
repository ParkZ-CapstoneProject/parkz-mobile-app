import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookingSlotLoading extends StatelessWidget {
  const BookingSlotLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Number of columns
      crossAxisSpacing: 8, // Spacing between columns
      mainAxisSpacing: 8, // Spacing between rows
      padding: const EdgeInsets.all(16), // Padding around the grid
      children: List.generate(
          8,
          (index) => Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.5),
              highlightColor: Colors.white,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              )
          )
      ),
    );
  }
}
