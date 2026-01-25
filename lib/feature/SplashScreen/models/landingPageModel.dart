import '../../../core/App_Imports/app_imports.dart';

class Landingpagemodel {
  final String image;
  final String title;
  final String text;
  final String desc;
  final String buttonText;

  Landingpagemodel({
    required this.image,
    required this.title,
    required this.text,
    required this.desc,
    required this.buttonText,
  });
}

List<Landingpagemodel> landingmodels = [
  Landingpagemodel(
    image: Assets.homeImage,
    title: "Welcome to Uber Clone",
    text: "Easy & Fast",
    desc: "Book rides easily and reach your destination safely.",
    buttonText: "Next",
  ),
  Landingpagemodel(
    image: Assets.homeImage,
    title: "Choose Your Ride",
    text: "Comfort Anytime",
    desc: "Select the ride that fits your needs and budget.",
    buttonText: "Next",
  ),
  Landingpagemodel(
    image: Assets.homeImage,
    title: "Let’s Get Started",
    text: "Ready to Go",
    desc: "Create an account and enjoy your journey.",
    buttonText: "Get Started",
  ),
];
