import '../../../../core/Imports/app_imports.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: DefaultAppBar(
        title: "الملف الشخصي",

        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Processitem(
                title: "سعد جاويش",
                description: "مطور تطبيقات الموبايل",
                leadIcon: Icons.edit,

                actionIcon: Icons.group,
                backgroundColor: settingsProvider.isdark
                    ? AppColors.blackColorwithopacity
                    : AppColors.blueColor,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5),
                  child: Image.asset(
                    Assets.photo,
                    width: appWidth(context),
                    height: appHeight(context),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              customdropdownButton(settingsProvider: settingsProvider),
            ],
          ),
        ),
      ),
    );
  }
}
