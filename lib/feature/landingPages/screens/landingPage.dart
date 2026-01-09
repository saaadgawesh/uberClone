import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/resources/customAppIcon.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/routing/routes.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneRider/feature/LandingPages/models/landingPageModel.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentIndex == 0
                    ? customAppIcon(iconName: Icons.language)
                    : SizedBox(width: 20, height: 22),
                _buildDotsIndicator(),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: landingmodels.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final model = landingmodels[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(model.image),
                      heightSizedbox(20),

                      CustomAppText(
                        text: model.title,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),

                      heightSizedbox(10),

                      CustomAppText(
                        text: model.text,
                        fontSize: 16,
                        textColor: AppColors.blueColor,
                        fontWeight: FontWeight.w700,
                      ),

                      heightSizedbox(10),

                      CustomAppText(
                        textAlign: TextAlign.center,
                        text: model.desc,
                        textColor: AppColors.blackColorwithopacity,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultElevatedButton(
          textbutton: landingmodels[currentIndex].buttonText,
          bgButtonColor: AppColors.blueColor,
          textcolor: AppColors.whiteColor,
          width: appWidth(context),
          onPressed: () {
            if (currentIndex < landingmodels.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.of(context).pushNamed(Routes.login);
            }
          },
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(
        landingmodels.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentIndex == index ? 20 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.blueColor
                : AppColors.blueColorwithopacity,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
