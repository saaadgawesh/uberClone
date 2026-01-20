import '../../../../core/App_Imports/app_imports.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final setting = context.watch<Settingprovider>();
    final applocalization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: DefaultAppBar(title: applocalization.profile),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Processitem(
                title: "saadGawesh",
                description: "flutter developer",
                leadIcon: Icons.edit,
                actionIcon: Icons.group,
                backgroundColor: context.bgColor,
                child: ClipOval(
                  child: Image.asset(
                    Assets.photo,
                    width: appWidth(context),
                    height: appHeight(context),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              VSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppText(
                    text: setting.languauge == "en" ? "English" : "العربيه",
                    fontWeight: FontWeight.bold,
                    textColor: setting.islight
                        ? AppColors.blueColor
                        : AppColors.blackColor,
                  ),
                  customDropDownButton(),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppText(
                    text: setting.isDark
                        ? applocalization.darkmode
                        : applocalization.lightmode,
                    fontWeight: FontWeight.bold,
                    textColor: setting.islight
                        ? AppColors.blueColor
                        : AppColors.blackColor,
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      thumbColor: WidgetStateProperty.all(AppColors.whiteColor),
                      trackColor: WidgetStateProperty.all(AppColors.blackColor),
                      value: context.settingProvider.isDark,
                      onChanged: (bool value) {
                        setting.changetheme(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultElevatedButton(
          textbutton: 'logout',
          bgButtonColor: context.bgColor,
          onPressed: () {
            context.read<AuthCubit>().logout();
            context.pushNamed(Routes.login);
          },

          textcolor: AppColors.whiteColor,
          width: appWidth(context),
        ),
      ),
    );
  }
}
