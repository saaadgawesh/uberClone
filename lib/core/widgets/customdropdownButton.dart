import '../Imports/app_imports.dart';

// ignore: camel_case_types
class customdropdownButton extends StatelessWidget {
  const customdropdownButton({super.key, required this.settingsProvider});

  final SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 70.w,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(border: InputBorder.none),
          // ignore: deprecated_member_use
          value: settingsProvider.language,
          borderRadius: BorderRadius.circular(15),
          icon: Icon(
            Icons.arrow_drop_down,
            color: settingsProvider.isdark
                ? AppColors.blackColorwithopacity
                : AppColors.blueColor,
            size: 30,
          ),

          items: [
            DropdownMenuItem(
              value: "en",
              child: CustomAppText(
                text: "En",
                textColor: settingsProvider.isdark
                    ? AppColors.blackColorwithopacity
                    : AppColors.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownMenuItem(
              value: "ar",
              child: CustomAppText(
                text: "Ar",
                textColor: settingsProvider.isdark
                    ? AppColors.blackColorwithopacity
                    : AppColors.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          onChanged: (String? value) {
            settingsProvider.changelanguage(value!);
          },
        ),
      ),
    );
  }
}
