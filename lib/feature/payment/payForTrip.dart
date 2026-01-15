import '../../core/App_Imports/app_imports.dart';

class Paymentmanager {
  final Dio _dio = Dio();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> payForTripWithPaymob({
    required String tripId,
    required String riderId,
    required double amount,
  }) async {
    // 1️⃣ جلب بيانات الرحلة
    final tripDoc = await firestore.collection('trips').doc(tripId).get();
    if (!tripDoc.exists) {
      throw Exception('Trip not found');
    }

    final driverId = tripDoc['driverId'];

    // 2️⃣ إنشاء payment pending
    final paymentRef = firestore.collection('payments').doc();

    await paymentRef.set({
      'paymentId': paymentRef.id,
      'tripId': tripId,
      'riderId': riderId,
      'driverId': driverId,
      'amount': amount,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 3️⃣ إنشاء Paymob order + payment key
    final paymentData = await getpaymentkeyWithOrder(amount.toInt(), 'EGP');

    final paymentToken = paymentData['paymentToken'];
    final orderId = paymentData['orderId'];

    // 4️⃣ حفظ orderId في Firestore للربط مع Webhook
    await paymentRef.update({'paymobOrderId': orderId.toString()});

    // 5️⃣ فتح صفحة الدفع
    final url =
        '${ApiConstant.baseurl}acceptance/iframes/953902?payment_token=$paymentToken';

    await launchUrl(Uri.parse(url));
  }

  // ================= PAYMOB METHODS =================

  Future<Map<String, dynamic>> getpaymentkeyWithOrder(
    int amount,
    String currency,
  ) async {
    final auth = await _getauthenticationtoken();

    final orderId = await _getOrderId(
      (amount * 100).toString(),
      auth,
      currency,
    );

    final paymentKey = await _getPaymentKey(
      amount: (amount * 100).toString(),
      authentication: auth,
      currency: currency,
      orderId: orderId,
    );

    return {'paymentToken': paymentKey, 'orderId': orderId};
  }

  Future<String> _getauthenticationtoken() async {
    final response = await _dio.post(
      '${ApiConstant.baseurl}auth/tokens',
      data: {"api_key": ApiConstant.apikey},
    );

    return response.data['token'];
  }

  Future<int> _getOrderId(
    String amount,
    String authentication,
    String currency,
  ) async {
    final response = await _dio.post(
      '${ApiConstant.baseurl}ecommerce/orders',
      data: {
        'auth_token': authentication,
        'amount_cents': amount,
        'currency': currency,
        'delivery_needed': false,
        'items': [],
      },
    );

    return response.data['id'];
  }

  Future<String> _getPaymentKey({
    required String amount,
    required String authentication,
    required String currency,
    required int orderId,
  }) async {
    final response = await _dio.post(
      '${ApiConstant.baseurl}acceptance/payment_keys',
      data: {
        'auth_token': authentication,
        'integration_id': ApiConstant.paymentonlineid,
        'order_id': orderId,
        'amount_cents': amount,
        'currency': currency,
        'lock_order_when_paid': false,
        "billing_data": {
          "first_name": "Rider",
          "last_name": "User",
          "email": "rider@test.com",
          "phone_number": "+201234567890",
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "Cairo",
          "country": "EG",
          "state": "NA",
        },
      },
    );

    return response.data['token'];
  }
}
