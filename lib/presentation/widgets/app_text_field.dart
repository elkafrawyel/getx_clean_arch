import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AppTextFormField extends StatefulWidget {
  final Color? backgroundColor;
  final bool isPassword;
  final String? hintText;
  final String? text;
  final String? validateEmptyText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? labelText;
  final String? suffixText;
  final bool? required;
  final bool? showLabel;
  final Color? hintColor;
  final Color? labelColor;
  final Color? textColor;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Color? suffixIconColor;
  final bool enabled;
  final List<String>? autoFillHints;
  final double? radius;
  final double horizontalPadding;
  final double verticalPadding;
  final Function(String value)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(String value)? onFieldSubmitted;
  final Color? fillColor;
  final TextInputAction? textInputAction;

  const AppTextFormField({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.backgroundColor,
    this.isPassword = false,
    this.hintText,
    this.text,
    this.validateEmptyText,
    this.maxLines,
    this.maxLength,
    this.labelText,
    this.suffixText,
    this.required = true,
    this.hintColor,
    this.labelColor,
    this.textColor,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.autoFillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.radius = 8,
    this.showLabel = false,
    this.suffixIconColor,
    this.horizontalPadding = 24,
    this.verticalPadding = 12,
    this.fillColor,
    this.textInputAction,
  }) : super(key: key);

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isSecure = false;

  @override
  void initState() {
    super.initState();
    isSecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding,
        vertical: widget.verticalPadding,
      ),
      child: TextFormField(
        obscureText: isSecure,
        style: TextStyle(fontSize: 14, color: widget.textColor ?? Theme.of(context).textTheme.subtitle1!.color),
        controller: widget.controller,
        keyboardType: widget.keyboardType??TextInputType.text,
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autofillHints: widget.autoFillHints,
        onEditingComplete: widget.onEditingComplete,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        validator: widget.required ?? true
            ? (String? value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return widget.validateEmptyText ?? 'empty'.tr;
                  } else if (widget.keyboardType == TextInputType.emailAddress) {
                    return email(value);
                  } else if (widget.keyboardType == TextInputType.phone) {
                    return phone(value);
                  }
                } else {
                  return null;
                }
                return null;
              }
            : null,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.showLabel! ? widget.hintText : null,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
          hintText: widget.hintText ?? '',
          fillColor: widget.enabled ? (widget.fillColor ?? Colors.white) : Colors.grey,
          filled: true,
          hintStyle: TextStyle(fontSize: 14, color: widget.hintColor ?? Color(0xFF929292)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          alignLabelWithHint: true,
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 20, color: Colors.grey) : null,
          suffixText: widget.suffixText ?? '',
          suffixStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
          suffixIcon: widget.suffixIcon != null || widget.isPassword
              ? InkWell(
                  onTap: widget.isPassword ? _toggle : null,
                  child: Icon(
                    widget.isPassword
                        ? isSecure
                            ? Icons.remove_red_eye
                            : Icons.visibility_off
                        : widget.suffixIcon,
                    size: 20,
                    color: widget.suffixIconColor ?? Colors.grey,
                  ),
                )
              : null,
          enabled: widget.enabled,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: !widget.enabled
              ? OutlineInputBorder(borderSide: BorderSide.none)
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 8),
                  borderSide: BorderSide(width: 0.5, color: Colors.grey.shade500),
                ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 8),
            borderSide: BorderSide(width: 0.5, color: Colors.red.shade500),
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  static String? email(String value) {
    if (value.isEmpty) {
      return 'empty'.tr;
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'EX: example@mail.com';
    } else {
      return null;
    }
  }

  static String? any(String? value) {
    if ((value ?? '').isEmpty) {
      return 'empty'.tr;
    } else {
      return null;
    }
  }

  static String? phone(String value) {
    if (value.isEmpty) {
      return 'empty'.tr;
    } else if (isPhoneNumber(value)) {
      return 'invalid_phone'.tr;
    } else {
      return null;
    }
  }


  static bool isPhoneNumber(String phone) {
    return RegExp(r'[^0-9+]').hasMatch(phone);
  }
}
