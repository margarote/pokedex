import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_typography.dart';

class HighlightedText extends StatelessWidget {
  const HighlightedText({
    super.key,
    required this.text,
    this.searchText,
    this.style,
    this.highlightColor,
    this.maxLines = AppDimens.maxLinesSingle,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final String? searchText;
  final TextStyle? style;
  final Color? highlightColor;
  final int maxLines;
  final TextOverflow overflow;

  TextStyle get _baseStyle => style ?? AppTypography.titleMedium;
  Color get _highlightColor => highlightColor ?? AppColors.primaryDark;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: _buildTextSpans()),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  List<TextSpan> _buildTextSpans() {
    if (searchText == null || searchText!.isEmpty) {
      return [TextSpan(text: text, style: _baseStyle)];
    }

    final searchLower = searchText!.toLowerCase();
    final textLower = text.toLowerCase();
    final startIndex = textLower.indexOf(searchLower);

    if (startIndex == AppDimens.notFoundIndex) {
      return [TextSpan(text: text, style: _baseStyle)];
    }

    final endIndex = startIndex + searchText!.length;

    return [
      TextSpan(
        text: text.substring(0, startIndex),
        style: _baseStyle,
      ),
      TextSpan(
        text: text.substring(startIndex, endIndex),
        style: _baseStyle.copyWith(color: _highlightColor),
      ),
      TextSpan(
        text: text.substring(endIndex),
        style: _baseStyle,
      ),
    ];
  }
}
