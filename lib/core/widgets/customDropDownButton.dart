import '../../core/App_Imports/app_imports.dart';

class Customdropdownbutton extends StatelessWidget {
  const Customdropdownbutton({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 105.w,
        child: DropdownButtonFormField<String>(
          dropdownColor: context.bgColor,
          icon: const Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: AppColors.whiteColor,
          ),
          decoration: const InputDecoration(border: InputBorder.none),

          // 👇 watch هنا عادي
          value: settingsProvider.languauge,

          items: const [
            DropdownMenuItem(
              value: "en",
              child: CustomAppText(
                text: "English",
                textColor: AppColors.whiteColor,
              ),
            ),
            DropdownMenuItem(
              value: "ar",
              child: CustomAppText(
                text: "العربيه",
                textColor: AppColors.whiteColor,
              ),
            ),
          ],

          // 👇 read هنا فقط
          onChanged: (String? value) {
            context.read<SettingsProvider>().changeLanguage(value!);
          },
        ),
      ),
    );
  }
}
