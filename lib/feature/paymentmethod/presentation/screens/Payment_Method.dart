import 'package:uberCloneRider/core/widgets/AppscaffoldMessanger.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/acceptedTripsStream.dart';

import '../../../../core/App_Imports/app_imports.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int _selectedPayIndex = -1;
  int _selectedTripIndex = 0;

  List<QueryDocumentSnapshot>? acceptedTrips;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(title: "Payment Method"),
      body: StreamBuilder<QuerySnapshot>(
        stream: acceptedTripsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: context.bgColor),
            );
          }

          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لا توجد رحلات مقبولة حالياً'));
          }

          acceptedTrips = snapshot.data!.docs;

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(right: 28.w, left: 28.w, bottom: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  CardItem(
                    text: 'Credit Card',
                    creditName: Assets.visa,
                    isSelected: _selectedPayIndex == 0,
                    onTap: () {
                      setState(() => _selectedPayIndex = 0);
                    },
                  ),

                  SizedBox(height: 6.h),

                  CardItem(
                    text: 'PayPal',
                    creditName: Assets.paypal,
                    isSelected: _selectedPayIndex == 1,
                    onTap: () {
                      setState(() => _selectedPayIndex = 1);
                    },
                  ),

                  SizedBox(height: 6.h),

                  CardItem(
                    text: 'Apple Pay',
                    creditName: Assets.pay,
                    isSelected: _selectedPayIndex == 2,
                    onTap: () {
                      setState(() => _selectedPayIndex = 2);
                    },
                  ),

                  SizedBox(height: 6.h),

                  CardItem(
                    text: 'PayMob',
                    creditName: Assets.paymob,
                    isSelected: _selectedPayIndex == 3,
                    onTap: () {
                      setState(() => _selectedPayIndex = 3);
                    },
                  ),

                  SizedBox(height: 6.h),

                  CardItem(
                    text: 'Cash',
                    creditName: Assets.cash,
                    isSelected: _selectedPayIndex == 4,
                    onTap: () {
                      setState(() => _selectedPayIndex = 4);
                    },
                  ),

                  SizedBox(height: 20.h),

                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 48.h,
                      margin: const EdgeInsets.all(8),
                      width: 364.w,
                      child: DottedBorder(
                        options: RectDottedBorderOptions(
                          dashPattern: const [11, 11],
                          color: AppColors.primary,
                          padding: EdgeInsets.only(
                            left: 30.w,
                            right: 16.w,
                            top: 15.h,
                            bottom: 8.h,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.plus, width: 24.w, height: 24.h),
                            SizedBox(width: 8.w),
                            Text(
                              'Add new card',
                              style: AppTextStyles.montserratButton.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      /// Bottom Bar
      bottomNavigationBar: TotalPriceAndNavBar(
        text: 'Pay',
        index: _selectedTripIndex,
        onPressed: () async {
          if (_selectedPayIndex == -1) {
            AppScaffoldMessanger(context, "اختر طريقه دفع اولا");
            return;
          }

          if (acceptedTrips == null || acceptedTrips!.isEmpty) return;

          final trip =
              acceptedTrips![_selectedTripIndex].data() as Map<String, dynamic>;

          final String riderIdFromTrip = trip['riderId'];
          final double price = (trip['price'] as num).toDouble();
          final String tripId = trip['tripId'];

          if (_selectedPayIndex == 3) {
            final paymobManager = Paymentmanager();

            await paymobManager.payForTripWithPaymob(
              tripId: tripId,
              riderId: riderIdFromTrip,
              amount: price,
            );
          } else if (_selectedPayIndex == 4) {
            context.pushNamed( Routes.navbar);
          }
        },
      ),
    );
  }
}
