import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/App_TextField.dart';
import 'package:uber/core/widgets/DefaultAppBar.dart';
import 'package:uber/core/widgets/defaultElevatedButton.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "profile"),
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
              defaultElevatedButton(
                textbutton: "textbutton",
                bgButtonColor: AppColor.blueColor,
                onPressed: () {},

                width: appWidth(context), textcolor: AppColor.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
