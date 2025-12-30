import 'package:flutter/material.dart';
import 'package:uberCloneCustomer/core/constant/App_Color.dart';
import 'package:uberCloneCustomer/core/resources/customAppText.dart';
import 'package:uberCloneCustomer/core/widgets/App_TextField.dart';

class Textfieldwithsectiontitle extends StatelessWidget {
  const Textfieldwithsectiontitle({
    super.key,
    required this.text,
    required this.hinttext,
  });
  final String text;
  final String hinttext;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        customAppText(
          text: text,
          textColor: AppColor.blueColor,
          textalignment: TextAlign.end,
          fontWeight: FontWeight.w500,
        ),
        AppTextField(
          prefix: Icon(Icons.arrow_drop_down),
          readOnly: true,
          hintText: hinttext,
        ),
      ],
    );
  }
}
