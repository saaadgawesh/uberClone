import '../../../../core/Imports/app_imports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        actiontitle: 'مرحبا بك',
        actionDesc: 'سعد جاويش',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppText(
                text: "الاجراءات الرئيسية",
                textColor: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Processitem(
                title: "كشف الركاب",
                description: "انشاء كشف جديد للركاب",
                leadIcon: Icons.arrow_forward,
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
                title: "استقبال الطلبات",
                description: "قبول طلبات المسافرين الجديده",
                leadIcon: Icons.arrow_forward,
                actionIcon: Icons.group,
                backgroundColor: AppColors.greenColor,
                child: customAppIcon(
                  iconName: Icons.car_crash,
                  iconColor: AppColors.whiteColor,
                  size: 40,
                ),
              ),
              VSpace(10),
              CustomAppText(
                text: "الخدمات",
                textColor: AppColors.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
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
