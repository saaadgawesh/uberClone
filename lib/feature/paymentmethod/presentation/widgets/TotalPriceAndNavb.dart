import 'package:uberCloneRider/feature/Tabs/widgets/acceptedTripsStream.dart';

import '../../../../core/App_Imports/app_imports.dart';

class TotalPriceAndNavBar extends StatelessWidget {
  const TotalPriceAndNavBar({
    super.key,
    required this.text,
    required this.onPressed,
    required this.index,
  });

  final String text;
  final VoidCallback onPressed;
  final int index;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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

        final trips = snapshot.data!.docs;

        // حماية من الخطأ لو index أكبر من عدد الرحلات
        if (index >= trips.length || index < 0) {
          return const SizedBox();
        }

        final trip = trips[index].data() as Map<String, dynamic>;
        final double price = (trip['price'] as num).toDouble();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5.w, color: AppColors.grey50),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price ',
                          style: AppTextStyles.montserratH3,
                        ),
                        TextSpan(
                          text: '/ ',
                          style: AppTextStyles.georgiaCaption,
                        ),
                        TextSpan(
                          text: 'Trip',
                          style: AppTextStyles.georgiaCaption.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: ' ${price.toInt()} ',
                          style: AppTextStyles.montserratRegularButton.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                        // TextSpan(
                        //   text: '\$',
                        //   style: AppTextStyles.montserratRegularButton.copyWith(
                        //     color: AppColors.error,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              AppButton(
                height: appHeight(context) * 0.11,
                color: context.bgColor,
                onPressed: onPressed,
                text: text,
                style: AppTextStyles.montserratButton.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
