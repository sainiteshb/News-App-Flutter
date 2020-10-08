import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerWidget(double height, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget shimmerLine(double width) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Container(
      height: 14.0,
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ),
    ),
  );
}

Widget appBar(Function onPressed) {
  return AppBar(
    elevation: 0.0,
    leading: IconButton(
      splashRadius: 20.0,
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back,
      ),
    ),
  );
}
