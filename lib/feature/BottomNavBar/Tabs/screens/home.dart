import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/Processitem.dart';

import '../../../../core/App_Imports/app_imports.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        actiontitle: 'welcome',
        actionDesc: 'welcome',
        actionOntap: () {},
        leadingonTap: () {
          context.pushNamed(Routes.profile);
        },
        leadIconName: Icons.person,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppText(
                text: "start your journey",
                textColor: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Processitem(
                title: "are you ready?",
                description: "request your car and join with good trip",
                leadIcon: Icons.arrow_back,
                actionIcon: Icons.group,
                backgroundColor: AppColors.blueColor,
                child: customAppIcon(
                  iconName: Icons.car_crash,
                  iconColor: AppColors.whiteColor,
                  size: 40,
                ),
              ),
                     VSpace(10),

              Processitem(
                title: "are you ready?",
                description: "request your car and join with good trip",
                leadIcon: Icons.arrow_back,
                actionIcon: Icons.group,
                backgroundColor: AppColors.greenColor,
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
                  return CustomServiceWidget(context);
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
