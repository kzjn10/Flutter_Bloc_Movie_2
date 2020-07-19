import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insurance/presentation/widgets/spacing_widget/spacing_widget_constants.dart';

class SpacingWidget extends StatelessWidget {
  final double verticalSpacing; // Vertical spacing value

  final double horizontalSpacing; // Horizontal spacing value

  SpacingWidget({this.verticalSpacing = 0, this.horizontalSpacing = 0})
      : assert(verticalSpacing >= 0, 'Vertical spacing >=0'),
        assert(horizontalSpacing >= 0, 'Horizontal spacing >=0');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: SpacingWidgetKey.sizeBoxKey,
      width: horizontalSpacing.w,
      height: verticalSpacing.h,
    );
  }
}
