
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

Widget shimmerEffect() {
  return Expanded(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    ),
  );
}
