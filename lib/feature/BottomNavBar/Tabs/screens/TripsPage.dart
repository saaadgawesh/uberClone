import '../../../../core/App_Imports/app_imports.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  String? driverId;

  @override
  void initState() {
    super.initState();
    driverId = FirebaseAuth.instance.currentUser?.uid;
  }

  Stream<QuerySnapshot> acceptedTripsStream() {
    if (driverId == null) return const Stream.empty();
    return FirebaseFirestore.instance
        .collection('trips')
        .where('driverId', isEqualTo: driverId)
        .where('status', isEqualTo: 'accepted')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    if (driverId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: DefaultAppBar(title: 'الرحلات المقبولة'),
      body: StreamBuilder<QuerySnapshot>(
        stream: acceptedTripsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: CustomAppText(
                text: 'لا توجد رحلات مقبولة حالياً',
                textColor: context.bgColor,
              ),
            );
          }

          final trips = snapshot.data!.docs;

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index].data()! as Map<String, dynamic>;

              return Card(
                color: context.bgColor,
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رقم الرحلة: ${trip['tripId']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'السعر: ${trip['price']} جنيه',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'من: ${trip['fromLat']}, ${trip['fromLng']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'إلى: ${trip['toLat']}, ${trip['toLng']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'الحالة: ${trip['status']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          openRouteInGoogleMaps(
                            fromLat: (trip['fromLat'] as num).toDouble(),
                            fromLng: (trip['fromLng'] as num).toDouble(),
                            toLat: (trip['toLat'] as num).toDouble(),
                            toLng: (trip['toLng'] as num).toDouble(),
                          );
                        },
                        child: const Text('عرض الرحلة'),
                      ),
                    ],
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
