import '../../../../core/App_Imports/app_imports.dart';

class Textfieldwithsectiontitle extends StatelessWidget {
  const Textfieldwithsectiontitle({
    super.key,
    required this.text,
    required this.hinttext,
  });
  final String text;
  final String hinttext;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomAppText(
          text: text,
          textColor: AppColors.blueColor,

          fontWeight: FontWeight.w500,
        ),
        AppTextField(
          prefix: Icon(Icons.arrow_drop_down),
          readOnly: true,
          hintText: hinttext,
        ),
      ],
    );
  }
}
