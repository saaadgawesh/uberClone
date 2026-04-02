import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/admin_dashboard_repository.dart';

import '../../../../core/Imports/app_imports.dart';

class Requests extends StatefulWidget {
  Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final AdminDashboardRepository _repository = AdminDashboardRepository();
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'الطلبات',
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: StreamBuilder<List<AdminTripRecord>>(
        stream: _repository.watchTrips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final trips = snapshot.data ?? const <AdminTripRecord>[];
          final filteredTrips = _applyFilter(trips);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _RequestsHeader(),
                const VSpace(16),
                SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _FilterChip(
                        label: 'الكل',
                        value: 'all',
                        groupValue: _selectedFilter,
                        onSelected: _onFilterChanged,
                      ),
                      _FilterChip(
                        label: 'جديدة',
                        value: 'requested',
                        groupValue: _selectedFilter,
                        onSelected: _onFilterChanged,
                      ),
                      _FilterChip(
                        label: 'مقبولة',
                        value: 'accepted',
                        groupValue: _selectedFilter,
                        onSelected: _onFilterChanged,
                      ),
                      _FilterChip(
                        label: 'مكتملة',
                        value: 'completed',
                        groupValue: _selectedFilter,
                        onSelected: _onFilterChanged,
                      ),
                      _FilterChip(
                        label: 'بدون سائق',
                        value: 'no_driver',
                        groupValue: _selectedFilter,
                        onSelected: _onFilterChanged,
                      ),
                    ],
                  ),
                ),
                const VSpace(16),
                Expanded(
                  child: filteredTrips.isEmpty
                      ? const _RequestsEmptyState()
                      : ListView.builder(
                          itemCount: filteredTrips.length,
                          itemBuilder: (context, index) {
                            return _RequestCard(trip: filteredTrips[index]);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onFilterChanged(String value) {
    setState(() {
      _selectedFilter = value;
    });
  }

  List<AdminTripRecord> _applyFilter(List<AdminTripRecord> trips) {
    if (_selectedFilter == 'all') {
      return trips;
    }

    if (_selectedFilter == 'requested') {
      return trips
          .where((trip) => trip.status == 'requested' || trip.status == 'pending')
          .toList();
    }

    return trips.where((trip) => trip.status == _selectedFilter).toList();
  }
}

class _RequestsHeader extends StatelessWidget {
  const _RequestsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppText(
            text: 'متابعة الطلبات',
            textColor: AppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          VSpace(6),
          CustomAppText(
            text:
                'راجع أحدث الرحلات، اعرف حالتها الحالية، وتابع توزيع السائقين بسهولة.',
            textColor: AppColors.whiteColor,
            fontSize: 13,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelected(value),
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.whiteColor : AppColors.text,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.grey200,
        ),
        backgroundColor: AppColors.whiteColor,
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.trip});

  final AdminTripRecord trip;

  @override
  Widget build(BuildContext context) {
    final statusColor = _requestStatusColor(trip.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey100),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomAppText(
                  text: trip.riderName,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: CustomAppText(
                  text: _requestStatusLabel(trip.status),
                  textColor: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const VSpace(12),
          _RequestInfoRow(
            icon: Icons.my_location_outlined,
            label: 'الانطلاق',
            value: trip.pickup,
          ),
          const VSpace(8),
          _RequestInfoRow(
            icon: Icons.location_on_outlined,
            label: 'الوجهة',
            value: trip.destination,
          ),
          const VSpace(8),
          _RequestInfoRow(
            icon: Icons.person_outline,
            label: 'السائق',
            value: trip.driverName,
          ),
          const VSpace(12),
          Row(
            children: [
              Expanded(
                child: CustomAppText(
                  text: 'رقم الرحلة: ${trip.id}',
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

class _RequestInfoRow extends StatelessWidget {
  const _RequestInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const HSpace(8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.text, fontSize: 13),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RequestsEmptyState extends StatelessWidget {
  const _RequestsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_late_outlined, size: 38, color: AppColors.grey),
          VSpace(12),
          CustomAppText(
            text: 'لا توجد طلبات ضمن هذا الفلتر',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          VSpace(6),
          CustomAppText(
            text: 'جرّب تغيير الحالة المختارة أو انتظر وصول رحلات جديدة.',
            textColor: AppColors.grey700,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Color _requestStatusColor(String status) {
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

String _requestStatusLabel(String status) {
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
