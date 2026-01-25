import '../../../../core/App_Imports/app_imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().loadUserName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of(context);
    return Scaffold(
      appBar: DefaultAppBar(
        actiontitle: applocalization.welcom,
        actionDesc: settingsProvider.isLoading
            ? "...loading"
            : settingsProvider.userName ?? applocalization.welcomeCustomer,
        actionOntap: () {},
        leadingonTap: () {
          context.pushNamed(Routes.profile);
        },
        leadIconName: Icons.person,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.directional(start: 10, top: 8, end: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppText(
                text: applocalization.startyourjourney,
                textColor: settingsProvider.isDark
                    ? AppColors.blackColor
                    : AppColors.blueColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Processitem(
                title: applocalization.areyouready,

                leadIcon: Icons.arrow_forward,
                actionIcon: Icons.group,
                backgroundColor: AppColors.blueColor,
                subtitle1: applocalization.subtitle1,
                subtitle2: applocalization.subtitle2,
                child: customAppIcon(
                  iconName: Icons.car_crash,
                  iconColor: AppColors.whiteColor,
                  size: 40,
                ),
              ),

              VSpace(10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return CustomServiceWidget(context, index);
                },
              ),
              VSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
