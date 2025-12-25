// import 'package:flutter/material.dart';
// import 'package:uber/core/constant/App_Color.dart';

// class DefaultTextFormField extends StatelessWidget {
//   const DefaultTextFormField({
//     super.key,
//     this.readonly,
//     this.controller,
//     this.textalign,
//     this.textdirection,
//     this.obsecuretext,
//     this.keyboardtype,
//    required this.cursorWidth,
//     this.cursorHeight,
//     this.cursorRadius,
//     this.cursorColor,
//     this.cursorErrorColor,
//     this.label,
//     this.hinttext,
//     this.hinttextstyle,
//     this.prefix,
//     this.suffix,
//     this.filled,
//     this.fillColor,
//     this.errorBorder,
//     this.focusedBorder,
//     this.focusedErrorBorder,
//     this.disabledBorder,
//     this.enabledBorder,
//     this.prefixText,
//     this.suffixtext,
//   });
//   final bool? readonly;
//   final TextEditingController? controller;
//   final TextAlign? textalign;
//   final TextDirection? textdirection;
//   final bool? obsecuretext;
//   final TextInputType? keyboardtype;
//   final double cursorWidth;
//   final double? cursorHeight;
//   final Radius? cursorRadius;
//   final Color? cursorColor;
//   final Color? cursorErrorColor;
//   final Widget? label;
//   final String? hinttext;
//   final String? prefixText;
//   final String? suffixtext;
//   final TextStyle? hinttextstyle;
//   final Widget? prefix;
//   final Widget? suffix;
//   final bool? filled;
//   final Color? fillColor;
//   final InputBorder? errorBorder;
//   final InputBorder? focusedBorder;
//   final InputBorder? focusedErrorBorder;
//   final InputBorder? disabledBorder;
//   final InputBorder? enabledBorder;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       cursorWidth: 2,
//       cursorHeight: cursorHeight,
//       cursorRadius: cursorRadius,
//       cursorColor: cursorColor,
//       cursorErrorColor: cursorErrorColor,
//       keyboardType: keyboardtype,
//       obscureText: obsecuretext,
//       textDirection: textdirection,
//       textAlign: textalign!,
//       controller: controller,
//       readOnly: readonly!,
//       decoration: InputDecoration(
//         label: label,
//         hintText: hinttext,
//         hintStyle: hinttextstyle,
//         prefix: prefix,
//         prefixText: prefixText,
//         suffix: suffix,
//         suffixText: suffixtext,
//         filled: filled,
//         fillColor: fillColor,

//         errorBorder: AppInputBorders.error(),
//         focusedBorder: AppInputBorders.focused(),
//         focusedErrorBorder: AppInputBorders.focused(),
//         disabledBorder: AppInputBorders.normal(),
//       ),
//     );
//   }
// }

// extension AppInputBorders on InputBorder {
//   static OutlineInputBorder normal() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: AppColor.greyColor, width: 1),
//     );
//   }

//   static OutlineInputBorder focused() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: AppColor.blueColor, width: 2),
//     );
//   }

//   static OutlineInputBorder error() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: AppColor.redColor, width: 1.5),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber/core/constant/App_Color.dart';


enum TextFieldBorderType { filled, outlined, underlined, none }

class AppTextField extends StatelessWidget {
  final TextFieldBorderType borderType;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final AutovalidateMode? autoValidateMode;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final Widget? suffix;
  final List<TextInputFormatter>? formatter;
  final Widget? prefix;
  final Color? filledColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;

  const AppTextField({
    super.key,
    this.autofocus = false,
    this.borderType = TextFieldBorderType.filled,
    this.readOnly = false,
    this.smartDashesType,
    this.filledColor,
    this.helperText,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.formatter,
    this.keyboardType,
    this.showCursor,
    this.obscuringCharacter = '*',
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.style,
    this.validator,
    this.controller,
    this.initialValue,
    this.suffix,
    this.prefix,
    this.autocorrect = true,
    this.borderColor,
    this.borderRadius = 10,
    this.borderWidth = 1.5,
  });

  InputBorder _getBorder() {
    switch (borderType) {
      case TextFieldBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        );
      case TextFieldBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.blueColor,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ??AppColor.blueColor,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.none:
        return InputBorder.none;
    }
  }

  InputBorder _getFocusedBorder() {
    switch (borderType) {
      case TextFieldBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        );
      case TextFieldBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ??AppColor.blueColor,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ??AppColor.blueColor,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.none:
        return InputBorder.none;
    }
  }

  InputBorder _getErrorBorder() {
    switch (borderType) {
      case TextFieldBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color:AppColor.redColor, width: borderWidth),
        );
      case TextFieldBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color:AppColor.redColor, width: borderWidth),
        );
      case TextFieldBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(color:AppColor.redColor, width: borderWidth),
        );
      case TextFieldBorderType.none:
        return InputBorder.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      inputFormatters: formatter,
      controller: controller,
      initialValue: initialValue,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      validator: validator,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      // style: style ?? AppTextStyles.montserratButton,
      cursorColor: AppColor.blueColor,
      autovalidateMode: autoValidateMode,
      decoration: InputDecoration(
        prefixIconColor: AppColor.greyColor,
        contentPadding: EdgeInsets.zero,
        suffixIconColor: AppColor.greyColor,
        filled: borderType == TextFieldBorderType.filled,
        fillColor:
            filledColor ??
            (borderType == TextFieldBorderType.filled
                ? AppColor.greyColor
                : null),
        prefixIcon: prefix,
        suffixIcon: suffix,
        helperText: helperText,
        hintText: hintText,

        helperStyle: helperStyle,
        // hintStyle:
        //     hintStyle ??
        //     AppTextStyles.montserratButton.copyWith(color: AppColors.grey400),
        labelStyle: labelStyle,
        labelText: labelText,
        border: _getBorder(),
        enabledBorder: _getBorder(),
        focusedBorder: _getFocusedBorder(),
        errorBorder: _getErrorBorder(),
        focusedErrorBorder: _getErrorBorder(),
      ),
    );
  }
}
