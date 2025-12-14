import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_typography.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.showBackButton = false,
    this.showClearButton = false,
    this.showBorderOnFocus = false,
    this.controller,
    this.onChanged,
  });

  final String hintText;
  final Widget? prefixIcon;
  final bool showBackButton;
  final bool showClearButton;
  final bool showBorderOnFocus;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  static final _borderRadius = BorderRadius.circular(AppDimens.radiusFull);
  static const _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusFull)),
    borderSide: BorderSide.none,
  );
  static const _focusedBorderSide = BorderSide(color: AppColors.borderPure);
  static const _backButtonIcon = Icon(
    Icons.arrow_back_ios,
    color: AppColors.black,
    size: AppDimens.iconSm,
  );
  static const _clearButtonIcon = Icon(
    Icons.close,
    color: AppColors.fillMain,
    size: AppDimens.iconMd,
  );
  static const _clearButtonDecoration = BoxDecoration(
    color: AppColors.textSecondary,
    shape: BoxShape.circle,
  );
  static final _hintStyle = AppTypography.bodyMedium.copyWith(
    color: AppColors.textSecondary,
  );

  late final TextEditingController _controller;
  final _focusNode = FocusNode();
  bool _hasFocus = false;

  bool get _showBackButton => _hasFocus && widget.showBackButton;
  bool get _showClearButton => _hasFocus && widget.showClearButton;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() => _hasFocus = _focusNode.hasFocus);

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  Widget? get _prefixIcon {
    if (!_showBackButton) return widget.prefixIcon;

    return IconButton(
      onPressed: _focusNode.unfocus,
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.only(left: AppDimens.md),
      icon: _backButtonIcon,
    );
  }

  Widget? get _suffixIcon {
    if (!_showClearButton) return null;

    return IconButton(
      onPressed: _clearText,
      icon: Container(
        padding: const EdgeInsets.all(AppDimens.xs),
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSm),
        decoration: _clearButtonDecoration,
        child: _clearButtonIcon,
      ),
    );
  }

  OutlineInputBorder get _focusedBorder {
    if (!widget.showBorderOnFocus) return _defaultBorder;

    return OutlineInputBorder(
      borderRadius: _borderRadius,
      borderSide: _focusedBorderSide,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.fillNeutralLowest,
        hintText: widget.hintText,
        hintStyle: _hintStyle,
        prefixIcon: _prefixIcon,
        suffixIcon: _suffixIcon,
        border: _defaultBorder,
        enabledBorder: _defaultBorder,
        focusedBorder: _focusedBorder,
      ),
    );
  }
}
