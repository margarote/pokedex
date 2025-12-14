import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final WidgetBuilder? placeholder;
  final Widget Function(BuildContext, Object)? errorWidget;

  static const _loadingIndicator = CircularProgressIndicator(
    strokeWidth: AppDimens.strokeWidth,
  );

  static const _errorIcon = Icon(
    Icons.error_outline,
    color: AppColors.textDisabled,
  );

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, _) =>
          placeholder?.call(context) ?? _buildCentered(_loadingIndicator),
      errorWidget: (context, _, error) =>
          errorWidget?.call(context, error) ?? _buildCentered(_errorIcon),
    );
  }

  Widget _buildCentered(Widget child) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(child: child),
    );
  }
}
