import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import 'package:flutter_movie_app/presentation/theme/theme_color.dart';

class PlaceHolderWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  final BorderRadiusGeometry borderRadius;

  PlaceHolderWidget({
    this.width = 100.0,
    this.height = 100.0,
    this.shimmerBaseColor = AppColor.shimmerBaseColor,
    this.shimmerHighlightColor = AppColor.shimmerHighlightColor,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          shimmerBaseColor,
          shimmerBaseColor,
          shimmerHighlightColor,
          shimmerBaseColor,
          shimmerBaseColor,
        ],
        stops: const <double>[
          0.0,
          0.35,
          0.5,
          0.65,
          1.0
        ]);

    return SizedBox(
      width: width,
      height: height,
      child: Shimmer(
        gradient: gradient,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: borderRadius, color: AppColor.shimmerBaseColor),
        ),
      ),
    );
  }
}
