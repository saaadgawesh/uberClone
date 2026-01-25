import '../../../../core/App_Imports/app_imports.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().loadUserName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final applocalization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: DefaultAppBar(title: applocalization.profile),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomContainer(
                bgContainerColor: context.bgColor,
                height: appHeight(context) * 0.1,
                width: appWidth(context),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppText(
                        text: settingsProvider.isLoading
                            ? "...loading"
                            : settingsProvider.userName ??
                                  applocalization.welcomeCustomer,

                        fontWeight: FontWeight.bold,
                        textColor: AppColors.whiteColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ShowEditNameDialog(context);
                            });
                          });
                        },
                        child: customAppIcon(iconName: Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
              VSpace(5),
              CustomContainer(
                bgContainerColor: context.bgColor,
                height: appHeight(context) * 0.1,
                width: appWidth(context),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppText(
                        text: settingsProvider.languauge == "en"
                            ? "Choose Language"
                            : "اختيار اللغه",
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.whiteColor,
                      ),
                      Customdropdownbutton(),
                    ],
                  ),
                ),
              ),
              VSpace(5),
              CustomContainer(
                bgContainerColor: context.bgColor,
                height: appHeight(context) * 0.1,
                width: appWidth(context),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: CustomAppText(
                        text: settingsProvider.isDark
                            ? applocalization.darkmode
                            : applocalization.lightmode,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.whiteColor,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        thumbColor: WidgetStateProperty.all(context.bgColor),
                        trackColor: WidgetStateProperty.all(
                          AppColors.whiteColor,
                        ),
                        value: context.settingProvider.isDark,
                        onChanged: (bool value) {
                          settingsProvider.changeTheme(
                            value ? ThemeMode.dark : ThemeMode.light,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultElevatedButton(
          textbutton: applocalization.logout,

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
