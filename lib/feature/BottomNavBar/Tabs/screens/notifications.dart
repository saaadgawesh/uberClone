import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/admin_dashboard_repository.dart';

import '../../../../core/Imports/app_imports.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AdminDashboardRepository();

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'الإشعارات والمتابعة',
        leadIconName: Icons.notifications_active_outlined,
        leadingonTap: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle(title: 'إشعارات الدفع'),
          const VSpace(10),
          StreamBuilder<List<AdminPaymentRecord>>(
            stream: repository.watchPayments(),
            builder: (context, snapshot) {
              final payments = snapshot.data ?? const <AdminPaymentRecord>[];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (payments.isEmpty) {
                return const _InfoBox(
                  title: 'لا توجد عمليات دفع',
                  subtitle: 'أي عملية دفع جديدة من تطبيق الراكب ستظهر هنا.',
                );
              }
              return Column(
                children: payments
                    .take(5)
                    .map((payment) => _PaymentNotificationCard(payment: payment))
                    .toList(),
              );
            },
          ),
          const VSpace(18),
          const _SectionTitle(title: 'ملخص رحلات السائقين'),
          const VSpace(10),
          StreamBuilder<List<AdminDriverTripSummary>>(
            stream: repository.watchDriverTripSummaries(),
            builder: (context, snapshot) {
              final summaries = snapshot.data ?? const <AdminDriverTripSummary>[];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (summaries.isEmpty) {
                return const _InfoBox(
                  title: 'لا توجد بيانات سائقين بعد',
                  subtitle: 'بمجرد أن تبدأ الرحلات ستظهر إحصاءات كل سائق هنا.',
                );
              }
              return Column(
                children: summaries
                    .take(6)
                    .map((summary) => _DriverSummaryCard(summary: summary))
                    .toList(),
              );
            },
          ),
          const VSpace(18),
          const _SectionTitle(title: 'استفسارات وشكاوى الركاب'),
          const VSpace(10),
          StreamBuilder<List<AdminSupportRequestRecord>>(
            stream: repository.watchSupportRequests(),
            builder: (context, snapshot) {
              final requests = snapshot.data ?? const <AdminSupportRequestRecord>[];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (requests.isEmpty) {
                return const _InfoBox(
                  title: 'لا توجد رسائل دعم',
                  subtitle: 'أي استفسار أو شكوى من تطبيق الراكب سيظهر هنا.',
                );
              }
              return Column(
                children: requests
                    .take(8)
                    .map((request) => _SupportRequestCard(request: request))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomAppText(
      text: title,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppText(text: title, fontWeight: FontWeight.w700),
          const VSpace(6),
          CustomAppText(text: subtitle, textColor: AppColors.grey700),
        ],
      ),
    );
  }
}

class _PaymentNotificationCard extends StatelessWidget {
  const _PaymentNotificationCard({required this.payment});

  final AdminPaymentRecord payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.primary50,
            child: Icon(Icons.payments_outlined, color: AppColors.primary),
          ),
          const HSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppText(
                  text: 'دفع جديد بقيمة ${payment.amount.toStringAsFixed(0)} ج.م',
                  fontWeight: FontWeight.w700,
                ),
                const VSpace(4),
                CustomAppText(
                  text: 'رحلة ${payment.tripId} - الحالة ${payment.status}',
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

class _DriverSummaryCard extends StatelessWidget {
  const _DriverSummaryCard({required this.summary});

  final AdminDriverTripSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CustomAppText(
            text: summary.driverName,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          const VSpace(8),
          Row(
            children: [
              Expanded(
                child: _TinyStat(
                  label: 'إجمالي',
                  value: summary.totalTrips.toString(),
                ),
              ),
              const HSpace(8),
              Expanded(
                child: _TinyStat(
                  label: 'مكتملة',
                  value: summary.completedTrips.toString(),
                ),
              ),
              const HSpace(8),
              Expanded(
                child: _TinyStat(
                  label: 'جارية',
                  value: summary.activeTrips.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TinyStat extends StatelessWidget {
  const _TinyStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CustomAppText(
            text: value,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            textColor: AppColors.primary,
          ),
          const VSpace(2),
          CustomAppText(text: label, fontSize: 12, textColor: AppColors.grey700),
        ],
      ),
    );
  }
}

class _SupportRequestCard extends StatelessWidget {
  const _SupportRequestCard({required this.request});

  final AdminSupportRequestRecord request;

  @override
  Widget build(BuildContext context) {
    final isComplaint = request.type == 'complaint';

    return Container(
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
              CircleAvatar(
                backgroundColor: (isComplaint ? AppColors.error : AppColors.info)
                    .withOpacity(0.12),
                child: Icon(
                  isComplaint ? Icons.report_gmailerrorred : Icons.help_outline,
                  color: isComplaint ? AppColors.error : AppColors.info,
                ),
              ),
              const HSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppText(
                      text: request.riderName,
                      fontWeight: FontWeight.w700,
                    ),
                    const VSpace(2),
                    CustomAppText(
                      text: isComplaint ? 'شكوى' : 'استفسار',
                      textColor: AppColors.grey700,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VSpace(10),
          CustomAppText(
            text: request.message,
            textColor: AppColors.grey800,
          ),
        ],
      ),
    );
  }
}
