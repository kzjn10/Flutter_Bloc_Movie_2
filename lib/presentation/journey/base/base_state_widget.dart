import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insurance/common/constants/app_constants.dart';
import 'package:insurance/common/injector/injector.dart';
import 'package:insurance/common/utils/analytics_utils.dart';
import 'package:insurance/common/utils/device_dimension_utils.dart';
import 'package:insurance/generated/i18n.dart';
import 'package:insurance/presentation/theme/theme_color.dart';
import 'package:insurance/presentation/widgets/circle_button_widget/circle_button_widget.dart';

abstract class BaseStateWidget<T extends StatefulWidget> extends State<T>
    with RouteAware {
  AnalyticsUtils _analyticsUtils;

  @override
  void initState() {
    super.initState();
    _analyticsUtils = Injector.resolve<AnalyticsUtils>();
  }

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
      body: Stack(
        children: <Widget>[
          buildContentView(context) ?? _buildHintWidget(context),
          hasAppBar()
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: buildAppBar(context),
                )
              : Container()
        ],
      ),
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildAppBar(BuildContext context) =>
      _buildDefaultAppBarWidget(context);

  Widget _buildDefaultAppBarWidget(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
        width: DeviceDimension.getDeviceWidth(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleButtonWidget(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  bool hasAppBar() => false;

  Widget buildContentView(BuildContext context);

  Widget buildFloatingActionButton(BuildContext context) => Container();

  Widget _buildHintWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      height: double.infinity,
      child: Center(
          child: Text(
        S.of(context).common_message_initializationContent,
        textAlign: TextAlign.center,
      )),
    );
  }

  @override
  void didPush() {
    _sendCurrentTabToAnalytics();
  }

  @override
  void didPopNext() {
    _sendCurrentTabToAnalytics();
  }

  void _sendCurrentTabToAnalytics() {
    _analyticsUtils.logCurrentScreen('${T.toString()}');
  }
}
