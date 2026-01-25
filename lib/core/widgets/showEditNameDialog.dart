import 'package:uberCloneDriver/core/extension/ThemeColorsExtension.dart';
import 'package:uberCloneDriver/core/extension/style.dart';

import '../../core/Imports/app_imports.dart';

// ignore: non_constant_identifier_names, strict_top_level_inference
ShowEditNameDialog(BuildContext context) {
  final applocalization = AppLocalizations.of(context)!;
  final controller = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: context.bgColor,
        title: CustomAppText(
          text: applocalization.editname,
          textColor: AppColors.whiteColor,
          textAlign: TextAlign.center,
        ),
        content: TextField(
          style: TextStyle(color: AppColors.whiteColor.withAppOpacity(0.5)),
          controller: controller,
          decoration: InputDecoration(
            hintText: applocalization.enternewname,
            hintStyle: TextStyle(
              color: AppColors.whiteColor.withAppOpacity(0.5),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            // style: ElevatedButton.styleFrom(backgroundColor: ),
            onPressed: () => Navigator.pop(context),
            child: CustomAppText(
              text: applocalization.canceled,
              textColor: context.bgColor,
            ),
          ),
          HSpace(20),
          ElevatedButton(
            // style: ElevatedButton.styleFrom(backgroundColor: ),
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                context.read<SettingsProvider>().updateUserName(newName);
              }
              Navigator.pop(context);
            },
            child: CustomAppText(
              text: applocalization.saved,
              textColor: context.bgColor,
            ),
          ),
        ],
      );
    },
  );
}
