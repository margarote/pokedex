import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import 'app_cached_image.dart';

class PositionedImage extends StatelessWidget {
  const PositionedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.top,
    this.bottom,
    this.left = AppDimens.xxxs,
    this.right = AppDimens.md,
  });

  final String imageUrl;
  final double? height;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AppCachedImage(
        imageUrl: imageUrl,
        height: height,
      ),
    );
  }
}
