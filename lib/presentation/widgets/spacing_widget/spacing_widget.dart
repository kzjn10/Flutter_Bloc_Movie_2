import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpacingWidget extends StatelessWidget {
  final double verticalSpacing;

  final double horizontalSpacing;

  SpacingWidget({this.verticalSpacing = 0.0, this.horizontalSpacing = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalSpacing > 0 ? (horizontalSpacing.w) : 0.0,
      height: verticalSpacing > 0 ? (verticalSpacing.h) : 0.0,
    );
  }
}
