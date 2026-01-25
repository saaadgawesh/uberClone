import 'package:uberCloneDriver/core/Imports/app_imports.dart';

// ignore: must_be_immutable, camel_case_types
class validateItem extends StatelessWidget {
  validateItem({super.key, required this.text, required this.isvalid});
  bool isvalid = true;
  String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isvalid
            ? customAppIcon(
                iconName: Icons.circle,
                iconColor: AppColors.blackColor,
              )
            : customAppIcon(
                iconName: Icons.circle_outlined,
                iconColor: AppColors.grey,
              ),
        HSpace(5),
        CustomAppText(
          textColor: isvalid ? AppColors.blackColor : AppColors.grey,
          text: text,
        ),
      ],
    );
  }
}
