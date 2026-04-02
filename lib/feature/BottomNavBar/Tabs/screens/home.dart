import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/admin_dashboard_repository.dart';

import '../../../../core/Imports/app_imports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AdminDashboardRepository();

    return Scaffold(
      appBar: DefaultAppBar(
        actiontitle: 'لوحة التحكم',
        actionDesc: 'إدارة التشغيل والمتابعة',
        leadingonTap: () {
          context.pushNamed(Routes.profile);
        },
        leadIconName: Icons.person,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AdminHeroSection(),
            const VSpace(16),
            StreamBuilder<AdminOverviewStats>(
              stream: repository.watchOverviewStats(),
              builder: (context, snapshot) {
                final stats =
                    snapshot.data ??
                    const AdminOverviewStats(
                      totalTrips: 0,
                      requestedTrips: 0,
                      activeTrips: 0,
                      completedTrips: 0,
                      unassignedTrips: 0,
                    );

                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.45,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _MetricCard(
                      title: 'إجمالي الرحلات',
                      value: stats.totalTrips.toString(),
                      subtitle: 'كل الرحلات المسجلة',
                      icon: Icons.route,
                      color: AppColors.primary,
                    ),
                    _MetricCard(
                      title: 'طلبات جديدة',
                      value: stats.requestedTrips.toString(),
                      subtitle: 'تحتاج مراجعة أو توزيع',
                      icon: Icons.pending_actions,
                      color: AppColors.warning,
                    ),
                    _MetricCard(
                      title: 'رحلات جارية',
                      value: stats.activeTrips.toString(),
                      subtitle: 'قيد التنفيذ الآن',
                      icon: Icons.local_taxi,
                      color: AppColors.info,
                    ),
                    _MetricCard(
                      title: 'رحلات غير مسندة',
                      value: stats.unassignedTrips.toString(),
                      subtitle: 'تحتاج متابعة من الإدارة',
                      icon: Icons.support_agent,
                      color: AppColors.error,
                    ),
                  ],
                );
              },
            ),
            const VSpace(18),
            CustomAppText(
              text: 'نظرة تشغيلية سريعة',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const VSpace(10),
            Row(
              children: [
                Expanded(
                  child: _CountTile(
                    title: 'المشرفين',
                    subtitle: 'حسابات الإدارة',
                    icon: Icons.admin_panel_settings_outlined,
                    stream: repository.watchCollectionCount(['Admin']),
                  ),
                ),
                const HSpace(10),
                Expanded(
                  child: _CountTile(
                    title: 'السائقين',
                    subtitle: 'المتوفرون في النظام',
                    icon: Icons.drive_eta_outlined,
                    stream: repository.watchCollectionCount(['Driver']),
                  ),
                ),
              ],
            ),
            const VSpace(10),
            Row(
              children: [
                Expanded(
                  child: _CountTile(
                    title: 'الركاب',
                    subtitle: 'إجمالي العملاء',
                    icon: Icons.groups_2_outlined,
                    stream: repository.watchCollectionCount(['Rider']),
                  ),
                ),
                const HSpace(10),
                Expanded(
                  child: _StaticInsightTile(),
                ),
              ],
            ),
            const VSpace(18),
            CustomAppText(
              text: 'أحدث الرحلات',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            const VSpace(10),
            StreamBuilder<List<AdminTripRecord>>(
              stream: repository.watchTrips(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final trips = snapshot.data ?? const <AdminTripRecord>[];
                if (trips.isEmpty) {
                  return const _EmptyStateCard(
                    title: 'لا توجد رحلات حتى الآن',
                    subtitle: 'عند وصول طلبات جديدة ستظهر هنا بشكل مباشر.',
                  );
                }

                final visibleTrips = trips.take(4).toList();
                return Column(
                  children: visibleTrips
                      .map((trip) => _TripPreviewCard(trip: trip))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminHeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomAppText(
            text: 'مركز متابعة التطبيق',
            textColor: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          VSpace(8),
          CustomAppText(
            text:
                'تابع الطلبات والسائقين والرحلات من مكان واحد، وخذ قرارات أسرع أثناء التشغيل.',
            textColor: AppColors.whiteColor,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          CustomAppText(
            text: value,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            textColor: AppColors.text,
          ),
          const VSpace(4),
          CustomAppText(
            text: title,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          const VSpace(2),
          CustomAppText(
            text: subtitle,
            fontSize: 12,
            textColor: AppColors.grey700,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.stream,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Stream<int> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.primary),
              const VSpace(10),
              CustomAppText(
                text: count.toString(),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              const VSpace(4),
              CustomAppText(
                text: title,
                fontWeight: FontWeight.w600,
              ),
              const VSpace(2),
              CustomAppText(
                text: subtitle,
                textColor: AppColors.grey700,
                fontSize: 12,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StaticInsightTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.insights_outlined, color: AppColors.primary),
          VSpace(10),
          CustomAppText(
            text: 'جاهزية المتابعة',
            fontWeight: FontWeight.w700,
          ),
          VSpace(4),
          CustomAppText(
            text:
                'لوحة التشغيل تعرض أحدث الرحلات مباشرة لتسهيل المتابعة واتخاذ القرار.',
            fontSize: 12,
            textColor: AppColors.grey700,
          ),
        ],
      ),
    );
  }
}

class _TripPreviewCard extends StatelessWidget {
  const _TripPreviewCard({required this.trip});

  final AdminTripRecord trip;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(trip.status);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomAppText(
                  text: trip.riderName,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: CustomAppText(
                  text: _statusLabel(trip.status),
                  textColor: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const VSpace(10),
          CustomAppText(
            text: 'من: ${trip.pickup}',
            textColor: AppColors.grey800,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const VSpace(4),
          CustomAppText(
            text: 'إلى: ${trip.destination}',
            textColor: AppColors.grey800,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const VSpace(10),
          Row(
            children: [
              Expanded(
                child: CustomAppText(
                  text: 'السائق: ${trip.driverName}',
                  fontSize: 12,
                  textColor: AppColors.grey700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomAppText(
                text: '${trip.fare.toStringAsFixed(0)} ج.م',
                fontWeight: FontWeight.w700,
                textColor: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.inbox_outlined, size: 32, color: AppColors.grey700),
          const VSpace(10),
          CustomAppText(
            text: title,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            textAlign: TextAlign.center,
          ),
          const VSpace(6),
          CustomAppText(
            text: subtitle,
            textColor: AppColors.grey700,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Color _statusColor(String status) {
  switch (status) {
    case 'completed':
      return AppColors.success;
    case 'requested':
    case 'pending':
      return AppColors.warning;
    case 'accepted':
    case 'ongoing':
      return AppColors.info;
    case 'no_driver':
      return AppColors.error;
    case 'rejected':
    case 'cancelled':
      return AppColors.error;
    default:
      return AppColors.warning;
  }
}

String _statusLabel(String status) {
  switch (status) {
    case 'completed':
      return 'مكتملة';
    case 'requested':
    case 'pending':
      return 'جديدة';
    case 'accepted':
      return 'مقبولة';
    case 'ongoing':
      return 'جارية';
    case 'no_driver':
      return 'بدون سائق';
    case 'rejected':
      return 'مرفوضة';
    case 'cancelled':
      return 'ملغية';
    default:
      return 'قيد الانتظار';
  }
}
