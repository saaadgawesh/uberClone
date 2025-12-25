import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/customAppIcon.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    required this.actionOntap,
    required this.leadingonTap,
  });
  final String title;
  final VoidCallback actionOntap;
  final VoidCallback leadingonTap;
  @override
  Size get preferredSize => Size.fromHeight(56);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 9, 76, 132),
      elevation: 0,
      title: Text(title),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColor.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: actionOntap,
              icon: customAppIcon(AppColor.whiteColor, Icons.arrow_forward_ios),
            ),
          ],
        ),
      ],
      leading: GestureDetector(
        onTap: leadingonTap,
        child: customAppIcon(AppColor.whiteColor, Icons.person),
      ),
    );
  }
}
