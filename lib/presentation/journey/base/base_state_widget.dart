import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_movie_app/common/constants/app_constants.dart';
import 'package:flutter_movie_app/presentation/theme/theme_color.dart';

abstract class BaseStateWidget<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: AppConstants.screenWidth,
      height: AppConstants.screenHeight,
      allowFontScaling: AppConstants.allowFontScaling,
    );

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: buildContentView(context),
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildFloatingActionButton(BuildContext context) => const SizedBox();

  Widget buildContentView(BuildContext context);
}
