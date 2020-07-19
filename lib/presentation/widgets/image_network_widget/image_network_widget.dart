import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:insurance/common/constants/resource_constants.dart';
import 'package:insurance/presentation/theme/theme_color.dart';
import 'package:insurance/presentation/widgets/place_holder_widget/place_holder_widget.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final bool autoSize;
  final double ratio;

  ImageNetworkWidget({
    this.imageUrl = '',
    this.width = 0.0,
    this.height = 0.0,
    this.fit = BoxFit.cover,
    this.autoSize = false,
    this.ratio = 16 / 9,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: autoSize
            ? _buildDynamicSizeImageWidget()
            : _buildDefaultImageViewWidget());
  }

  Widget _buildDefaultImageViewWidget() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, value) {
        return PlaceHolderWidget(
          width: width,
          height: height,
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          color: AppColor.dustyGray.withOpacity(.5),
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Image.asset(
              GraphicConstants.appIconWhite,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDynamicSizeImageWidget() {
    return AspectRatio(
      aspectRatio: ratio,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
        placeholder: (context, value) {
          return PlaceHolderWidget(
            width: width,
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            width: width,
            height: height,
            color: AppColor.dustyGray.withOpacity(.5),
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Image.asset(
                GraphicConstants.appIconWhite,
              ),
            ),
          );
        },
      ),
    );
  }
}
