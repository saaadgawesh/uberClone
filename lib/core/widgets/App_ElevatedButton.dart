// import 'package:flutter/material.dart';

// class DefaultElevatedButton extends StatelessWidget {
//   const DefaultElevatedButton({
//     super.key,
//     this.icon,
//     required this.text1,
//     this.text2,
//     this.bgColor,
//     this.elevation,
//     this.onPressed,
//   });

//   final IconData? icon;
//   final String text1;
//   final String? text2;
//   final Color? bgColor;
//   final double? elevation;
//   final VoidCallback? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(

//         backgroundColor: bgColor,
//         elevation: elevation,
//         side: const BorderSide(),
//       ),
//       onPressed: onPressed,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) ...[
//             Icon(icon),
//             const SizedBox(width: 8),
//           ],
//           Text(text1),
//           if (text2 != null) ...[
//             const SizedBox(width: 4),
//             Text(text2!),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/widgets/CustomContainer.dart';

// ignore: camel_case_types
class defaultElevatedButton extends StatelessWidget {
  const defaultElevatedButton({
    super.key,
    required this.textbutton,
    required this.bgButtonColor,
    required this.onPressed,
    this.iconName,
  });
  final String textbutton;
  final Color bgButtonColor;
  final VoidCallback onPressed;
  final IconData? iconName;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 35,
      width: appWidth(context) * 0.85,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: bgButtonColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.transparent,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            customAppIcon(AppColor.whiteColor, iconName ?? Icons.abc),
            customAppText(text: textbutton, textColor: AppColor.whiteColor),
          ],
        ),
      ),
    );
  }
}
