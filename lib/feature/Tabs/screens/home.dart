import '../../../core/App_Imports/app_imports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: DefaultAppBar(
        actiontitle: appLocalizations.welcom,
        actionDesc: settingsProvider.isLoading
            ? "...loading"
            : settingsProvider.userName ?? appLocalizations.welcomeCustomer,
        actionOntap: () {},
        leadingonTap: () {},
        leadIconName: Icons.person,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppText(
                text: appLocalizations.startyourjourney,
                textColor: context.bgColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Processitem(
                title: appLocalizations.areyouready,

                leadIcon: Icons.arrow_forward,
                actionIcon: Icons.group,
                backgroundColor: AppColors.blueColor,
                subtitle1: appLocalizations.subtitle1,
                subtitle2: appLocalizations.subtitle2,
                child: customAppIcon(
                  iconName: Icons.car_crash,
                  iconColor: AppColors.whiteColor,
                  size: 40,
                ),
              ),

              heightSizedbox(10),
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
              heightSizedbox(10),
            ],
          ),
        ),
      ),
    );
  }
}
