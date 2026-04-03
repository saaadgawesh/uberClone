import 'package:uberCloneDriver/feature/BottomNavBar/tabs/widgets/admin_dashboard_repository.dart';

import '../../../../core/Imports/app_imports.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AdminDashboardRepository();

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'التقارير',
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: StreamBuilder<List<AdminTripRecord>>(
        stream: repository.watchTrips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final trips = snapshot.data ?? const <AdminTripRecord>[];
          final totalRevenue = trips.fold<double>(
            0,
            (sum, trip) => sum + trip.fare,
          );
          final completedTrips = trips
              .where((trip) => trip.status == 'completed')
              .length;
          final cancelledTrips = trips
              .where(
                (trip) => trip.status == 'cancelled' || trip.status == 'rejected',
              )
              .length;
          final activeTrips = trips
              .where((trip) => trip.status == 'accepted' || trip.status == 'ongoing')
              .length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const _ReportsHero(),
              const VSpace(16),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1.3,
                children: [
                  _ReportStatCard(
                    title: 'إيراد تقريبي',
                    value: '${totalRevenue.toStringAsFixed(0)} ج.م',
                    icon: Icons.account_balance_wallet_outlined,
                    color: AppColors.success,
                  ),
                  _ReportStatCard(
                    title: 'رحلات مكتملة',
                    value: completedTrips.toString(),
                    icon: Icons.done_all_outlined,
                    color: AppColors.primary,
                  ),
                  _ReportStatCard(
                    title: 'رحلات جارية',
                    value: activeTrips.toString(),
                    icon: Icons.local_shipping_outlined,
                    color: AppColors.info,
                  ),
                  _ReportStatCard(
                    title: 'إلغاءات ورفض',
                    value: cancelledTrips.toString(),
                    icon: Icons.warning_amber_outlined,
                    color: AppColors.error,
                  ),
                ],
              ),
              const VSpace(18),
              const CustomAppText(
                text: 'ملخص الأداء',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const VSpace(10),
              _PerformanceTile(
                title: 'نسبة إتمام الرحلات',
                value: _percentage(completedTrips, trips.length),
                helper: 'تعطي انطباعًا سريعًا عن جودة التشغيل.',
              ),
              const VSpace(10),
              _PerformanceTile(
                title: 'معدل الإلغاء أو الرفض',
                value: _percentage(cancelledTrips, trips.length),
                helper: 'يفيد في معرفة إن كانت هناك مشاكل في التوزيع أو القبول.',
              ),
              const VSpace(10),
              _PerformanceTile(
                title: 'متوسط سعر الرحلة',
                value: trips.isEmpty
                    ? '0 ج.م'
                    : '${(totalRevenue / trips.length).toStringAsFixed(0)} ج.م',
                helper: 'متوسط تقريبي محسوب من الرحلات المتاحة في قاعدة البيانات.',
              ),
              const VSpace(18),
              const CustomAppText(
                text: 'ملاحظات تشغيلية',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const VSpace(10),
              const _InsightCard(
                icon: Icons.tips_and_updates_outlined,
                title: 'اجعل شاشة الطلبات نقطة المتابعة الأساسية',
                subtitle:
                    'بعد إضافة الفلاتر والحالات، تقدر تراجع الرحلات الجديدة بسرعة وتعرف الوضع الحالي لكل رحلة.',
              ),
              const VSpace(10),
              const _InsightCard(
                icon: Icons.bar_chart_outlined,
                title: 'التقارير الحالية مرتبطة مباشرة بالرحلات',
                subtitle:
                    'يعني بمجرد توفر بيانات الرحلات والسعر والحالة في Firestore، الأرقام هنا ستتحدث تلقائيًا.',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ReportsHero extends StatelessWidget {
  const _ReportsHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.primary50,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppText(
            text: 'تقارير الأداء',
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
          VSpace(6),
          CustomAppText(
            text:
                'الأرقام هنا مبنية على بيانات الرحلات الحالية لتسهيل متابعة التشغيل والعائد والحالات الحرجة.',
            textColor: AppColors.grey800,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}

class _ReportStatCard extends StatelessWidget {
  const _ReportStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          CustomAppText(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const VSpace(4),
          CustomAppText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}

class _PerformanceTile extends StatelessWidget {
  const _PerformanceTile({
    required this.title,
    required this.value,
    required this.helper,
  });

  final String title;
  final String value;
  final String helper;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppText(
                  text: title,
                  fontWeight: FontWeight.w700,
                ),
                const VSpace(4),
                CustomAppText(
                  text: helper,
                  textColor: AppColors.grey700,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          const HSpace(10),
          CustomAppText(
            text: value,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary50,
            child: Icon(icon, color: AppColors.primary),
          ),
          const HSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppText(
                  text: title,
                  fontWeight: FontWeight.w700,
                ),
                const VSpace(4),
                CustomAppText(
                  text: subtitle,
                  textColor: AppColors.grey700,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _percentage(int count, int total) {
  if (total == 0) {
    return '0%';
  }

  final value = (count / total) * 100;
  return '${value.toStringAsFixed(0)}%';
}
