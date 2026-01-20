import '../App_Imports/app_imports.dart';

class customDropDownButton extends StatelessWidget {
  const customDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        width: 65.w,
        child: DropdownButtonFormField<String>(
          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: context.bgColor,
          ),
          decoration: InputDecoration(border: InputBorder.none),
          value: context.settingProvider.languauge,
          items: [
            DropdownMenuItem(
              value: "en",
              child: CustomAppText(
                text: "En",
                fontWeight: FontWeight.bold,
                textColor: context.bgColor,
              ),
            ),
            DropdownMenuItem(
              value: "ar",
              child: CustomAppText(
                text: "Ar",
                fontWeight: FontWeight.bold,
                textColor: context.bgColor,
              ),
            ),
          ],
          onChanged: (String? value) {
            context.settingProvider.chanelanguage(value!);
          },
        ),
      ),
    );
  }
}
