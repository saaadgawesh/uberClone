import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/App_TextField.dart';
import 'package:uber/core/widgets/DefaultAppBar.dart';
import 'package:uber/core/widgets/defaultElevatedButton.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'request cars'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: customAppText(
                  text: "from",
                  textColor: AppColor.blueColor,

                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                prefix: Icon(Icons.arrow_drop_down),
                readOnly: true,
                hintText: "choose city",
              ),
              heightSizedbox(10),
              Padding(
                padding: EdgeInsets.only(left: 250),
                child: customAppText(
                  text: "to",
                  textColor: AppColor.blueColor,

                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                prefix: Icon(Icons.arrow_drop_down),
                readOnly: true,
                hintText: "choose city",
              ),
              heightSizedbox(10),
              Padding(
                padding: EdgeInsets.only(left: 230),
                child: customAppText(
                  text: "tasneef",
                  textColor: AppColor.blueColor,

                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                prefix: Icon(Icons.arrow_drop_down),
                readOnly: true,
                hintText: "choose city",
              ),
              heightSizedbox(10),
              Padding(
                padding: EdgeInsets.only(left: 200),
                child: customAppText(
                  text: "type transport",
                  textColor: AppColor.blueColor,

                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                prefix: Icon(Icons.arrow_drop_down),
                readOnly: true,
                hintText: "choose city",
              ),
              heightSizedbox(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customAppText(
                    text: "350Eg",
                    textColor: AppColor.greenColor,

                    fontWeight: FontWeight.w500,
                  ),
                  customAppText(
                    text: "tripPrice",
                    textColor: AppColor.blueColor,

                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              heightSizedbox(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customAppText(
                    text: "time",
                    textColor: AppColor.blueColor,

                    fontWeight: FontWeight.w500,
                  ),
                  customAppText(
                    text: "date",
                    textColor: AppColor.blueColor,

                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  defaultElevatedButton(
                    textbutton: "textbutton",
                    bgButtonColor: AppColor.greyColor.withOpacity(0.3),
                    onPressed: () {},
                    iconName: Icons.alarm,
                    width: appWidth(context) * 0.45,
                  ),
                  defaultElevatedButton(
                    textbutton: "textbutton",
                    bgButtonColor: AppColor.greyColor.withOpacity(0.3),
                    onPressed: () {},
                    iconName: Icons.alarm,
                    width: appWidth(context) * 0.45,
                  ),
                ],
              ),
              heightSizedbox(10),
              defaultElevatedButton(
                textbutton: "textbutton",
                bgButtonColor: AppColor.blueColor,
                onPressed: () {},
                iconName: Icons.abc,
                width: appWidth(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
