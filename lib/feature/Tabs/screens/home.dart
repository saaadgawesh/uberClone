import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/CustomServiceWidget.dart';
import 'package:uber/core/widgets/ProcessWdget.dart';
import 'package:uber/core/widgets/DefaultAppBar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        actiontitle: 'welcome',
        actionDesc: 'welcome',
        actionOntap: () {},
        leadingonTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              customAppText(
                text: "text",
                textColor: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              ProcessWidget(
                title: "title",
                description: "description",
                leadIcon: Icons.arrow_back,
                actionIcon: Icons.group,
                backgroundColor: AppColor.blueColor,
              ),
              heightSizedbox(10),
              ProcessWidget(
                title: "title",
                description: "description",
                leadIcon: Icons.arrow_back,
                actionIcon: Icons.group,
                backgroundColor: const Color.fromARGB(255, 19, 181, 81),
              ),
              heightSizedbox(10),
              customAppText(
                text: "text",
                textColor: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              heightSizedbox(10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return CustomServiceWidget(context);
                },
              ),
              heightSizedbox(10),
            ],
          ),
        ),
      ),
    );
  }
}
