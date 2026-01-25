import '../App_Imports/app_imports.dart';

class Customdropdownbutton extends StatelessWidget {
  const Customdropdownbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 110.w,
        child: DropdownButtonFormField<String>(
          dropdownColor: context.bgColor,
          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: AppColors.whiteColor,
          ),
          decoration: InputDecoration(border: InputBorder.none),
          value: context.settingProvider.languauge,
          items: [
            DropdownMenuItem(
              value: "en",
              child: CustomAppText(
                text: "English",
                fontWeight: FontWeight.bold,
                textColor: AppColors.whiteColor,
              ),
            ),
            DropdownMenuItem(
              value: "ar",
              child: CustomAppText(
                text: "العربيه",
                fontWeight: FontWeight.bold,
                textColor: AppColors.whiteColor,
              ),
            ),
          ],
          onChanged: (String? value) {
            context.settingProvider.changeLanguage(value!);
          },
        ),
      ),
    );
  }
}
