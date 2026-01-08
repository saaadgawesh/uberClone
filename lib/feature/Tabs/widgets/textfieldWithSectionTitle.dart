import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/widgets/App_TextField.dart';

class Textfieldwithsectiontitle extends StatelessWidget {
  const Textfieldwithsectiontitle({
    super.key,
    required this.text,
    required this.hinttext,
    this.iconName,
    this.onpressed,
  });
  final String text;
  final String hinttext;
  final IconData? iconName;
  final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomAppText(
          text: text,
          textColor: AppColors.blueColor,

          fontWeight: FontWeight.w500,
        ),
        AppTextField(
          prefix: GestureDetector(onTap: onpressed, child: Icon(iconName)),
          readOnly: true,
          hintText: hinttext,
        ),
      ],
    );
  }
}
