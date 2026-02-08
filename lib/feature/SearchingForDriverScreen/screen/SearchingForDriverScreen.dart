import 'package:uberCloneRider/core/widgets/AppscaffoldMessanger.dart';

import '../../../core/App_Imports/app_imports.dart';

class SearchingForDriverScreen extends StatefulWidget {
  const SearchingForDriverScreen({super.key});

  @override
  State<SearchingForDriverScreen> createState() =>
      _SearchingForDriverScreenState();
}

class _SearchingForDriverScreenState extends State<SearchingForDriverScreen> {
  String? selectedDriverId;
  bool isLoading = true;
  List<QueryDocumentSnapshot> drivers = [];

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: DefaultAppBar(
        title: applocalization.searchingforDriver,
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () => context.pop(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Driver')
            .where('status', isEqualTo: 'available')
            .where('isOnline', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              drivers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            drivers = snapshot.data!.docs;
            isLoading = false;
          }

          if (drivers.isEmpty && !isLoading) {
            return Center(child: Text(applocalization.nodriversavailable));
          }

          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              final driverId = driver.id;

              final bool isSelected = selectedDriverId == driverId;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDriverId = driverId;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomContainer(
                    padding: const EdgeInsets.all(10),
                    height: appHeight(context) * 0.31,
                    width: appWidth(context),
                    bgContainerColor: isSelected
                        ? context.bgColor.withOpacity(0.6)
                        : context.bgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(Assets.homeImage),
                              backgroundColor: AppColors.whiteColor,
                              radius: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomAppText(
                                  text:
                                      '${applocalization.name}: ${driver['name']?.toString() ?? 'Unknown'}',
                                  textColor: AppColors.whiteColor,
                                ),
                                CustomAppText(
                                  text:
                                      '${applocalization.carModel}: ${driver['carModel']?.toString() ?? 'Unknown'}',
                                  textColor: AppColors.whiteColor,
                                ),
                                CustomAppText(
                                  text:
                                      '${applocalization.carNumber}: ${driver['carNumber']?.toString() ?? 'Unknown'}',
                                  textColor: AppColors.whiteColor,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (selectedDriverId == null) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //       applocalization
                                  //           .pleaseselectadriverfirst,
                                  //     ),
                                  //   ),
                                  // );
                                  AppScaffoldMessanger(
                                    context,
                                    applocalization.pleaseselectadriverfirst,

                                  );
                                  return;
                                }

                                final tripData =
                                    ModalRoute.of(context)!.settings.arguments
                                        as Tripmodel;

                                final repo = TripRepository();

                                try {
                                  await repo.selectDriver(
                                    tripData,
                                    selectedDriverId!,
                                  );

                                  context.pushNamed(Routes.navbar);
                                } catch (e) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(content: Text(e.toString())),
                                  // );
                                  AppScaffoldMessanger(
                                    context,
                                    e.toString(),

                                  );
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                child: CustomAppText(
                                  text: applocalization.ok,
                                  textColor: context.bgColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Divider(color: Colors.white),
                        const SizedBox(height: 10),
                        CustomAppText(
                          text:
                              '${applocalization.location}: ${driver['location']?.toString() ?? 'Unknown'}',
                          textColor: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
