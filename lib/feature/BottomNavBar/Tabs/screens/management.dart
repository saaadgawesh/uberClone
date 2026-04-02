import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/admin_dashboard_repository.dart';

import '../../../../core/Imports/app_imports.dart';

class Management extends StatelessWidget {
  const Management({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AdminDashboardRepository();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: DefaultAppBar(
          title: 'الإدارة',
          leadIconName: Icons.admin_panel_settings_outlined,
          leadingonTap: () {},
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.grey700,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'السائقون'),
                  Tab(text: 'الركاب'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _DriversTab(repository: repository),
                  _RidersTab(repository: repository),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DriversTab extends StatelessWidget {
  const _DriversTab({required this.repository});

  final AdminDashboardRepository repository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AdminDriverRecord>>(
      stream: repository.watchDrivers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final drivers = snapshot.data ?? const <AdminDriverRecord>[];
        if (drivers.isEmpty) {
          return const _ManagementEmptyState(
            title: 'لا يوجد سائقون',
            subtitle: 'بمجرد تسجيل سائقين في التطبيق سيظهرون هنا.',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            final driver = drivers[index];
            return _DriverCard(driver: driver);
          },
        );
      },
    );
  }
}

class _RidersTab extends StatelessWidget {
  const _RidersTab({required this.repository});

  final AdminDashboardRepository repository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AdminRiderRecord>>(
      stream: repository.watchRiders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final riders = snapshot.data ?? const <AdminRiderRecord>[];
        if (riders.isEmpty) {
          return const _ManagementEmptyState(
            title: 'لا يوجد ركاب',
            subtitle: 'بيانات الركاب ستظهر هنا بعد التسجيل في تطبيق الراكب.',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: riders.length,
          itemBuilder: (context, index) {
            final rider = riders[index];
            return _RiderCard(rider: rider);
          },
        );
      },
    );
  }
}

class _DriverCard extends StatelessWidget {
  const _DriverCard({required this.driver});

  final AdminDriverRecord driver;

  @override
  Widget build(BuildContext context) {
    final bool available = driver.status == 'available' && driver.isOnline;
    final Color statusColor = available ? AppColors.success : AppColors.warning;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              const CircleAvatar(
                backgroundColor: AppColors.primary50,
                child: Icon(Icons.drive_eta, color: AppColors.primary),
              ),
              const HSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppText(
                      text: driver.name,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    const VSpace(2),
                    CustomAppText(
                      text: driver.email,
                      textColor: AppColors.grey700,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: CustomAppText(
                  text: available ? 'متاح' : (driver.isOnline ? 'مشغول' : 'أوفلاين'),
                  textColor: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const VSpace(12),
          _InfoLine(label: 'الهاتف', value: driver.phone),
          const VSpace(6),
          _InfoLine(label: 'المركبة', value: driver.carModel),
          const VSpace(6),
          _InfoLine(label: 'اللوحة', value: driver.carNumber),
          const VSpace(6),
          _InfoLine(label: 'المعرف', value: driver.id),
        ],
      ),
    );
  }
}

class _RiderCard extends StatelessWidget {
  const _RiderCard({required this.rider});

  final AdminRiderRecord rider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              const CircleAvatar(
                backgroundColor: AppColors.primary50,
                child: Icon(Icons.person_outline, color: AppColors.primary),
              ),
              const HSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppText(
                      text: rider.name,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    const VSpace(2),
                    CustomAppText(
                      text: rider.email,
                      textColor: AppColors.grey700,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VSpace(12),
          _InfoLine(label: 'الهاتف', value: rider.phone),
          const VSpace(6),
          _InfoLine(label: 'المعرف', value: rider.id),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppText(
          text: '$label: ',
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        Expanded(
          child: CustomAppText(
            text: value,
            fontSize: 12,
            textColor: AppColors.grey700,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ManagementEmptyState extends StatelessWidget {
  const _ManagementEmptyState({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.groups_outlined, size: 34, color: AppColors.grey700),
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
      ),
    );
  }
}
