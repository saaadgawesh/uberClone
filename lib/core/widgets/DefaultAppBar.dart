import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.title,
    this.actionOntap,
    this.leadingonTap,
    this.actiontitle,
    this.actionDesc,
    this.leadIconName,
  });
  final String? title;
  final String? actiontitle;
  final String? actionDesc;
  final IconData? leadIconName;
  final VoidCallback? actionOntap;
  final VoidCallback? leadingonTap;
  @override
  Size get preferredSize => Size.fromHeight(56);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 9, 76, 132),
      elevation: 0,
      title: customAppText(
        text: title ?? '',
        textColor: AppColor.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customAppText(
                text: actiontitle ?? '',
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w700,
              ),
              customAppText(
                text: actionDesc ?? '',
                textColor: AppColor.whiteColor,
              ),
            ],
          ),
        ),
      ],
      leading: leadIconName == null
          ? null
          : GestureDetector(
              onTap: leadingonTap,
              child: customAppIcon(AppColor.whiteColor, leadIconName!, 20),
            ),
    );
  }
}
