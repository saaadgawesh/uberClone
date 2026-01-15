/**
 * Test Script for Paymob Webhook
 *
 * هذا السكريبت يقوم بـ:
 * 1. إنشاء payment تجريبي في Firestore
 * 2. إرسال webhook تجريبي للـ Function
 * 3. التحقق من تحديث حالة الـ payment
 *
 * الاستخدام:
 * npm run test-webhook
 */

const axios = require('axios');
const admin = require('firebase-admin');

// ============== Configuration ==============

// تأكد من وجود ملف serviceAccountKey.json
// إذا لم يكن موجود، حمله من Firebase Console
let serviceAccount;
try {
  serviceAccount = require('./serviceAccountKey.json');
} catch (error) {
  console.error('❌ Error: serviceAccountKey.json not found!');
  console.log('📝 Please download it from:');
  console.log('   Firebase Console → Project Settings → Service Accounts → Generate New Private Key');
  console.log('   Then save it as: functions/serviceAccountKey.json\n');
  process.exit(1);
}

// Initialize Firebase Admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  projectId: 'uberclonerider-5105a'
});

// Connect to Firestore Emulator
const db = admin.firestore();

// Check if emulator is running
const EMULATOR_HOST = process.env.FIRESTORE_EMULATOR_HOST || 'localhost:8080';
db.settings({
  host: EMULATOR_HOST,
  ssl: false
});

console.log('🔧 Configuration:');
console.log('   Firestore Emulator:', EMULATOR_HOST);
console.log('   Project ID:', 'uberclonerider-5105a');
console.log('');

// ============== Test Function ==============

async function testWebhook() {
  console.log('🚀 Starting Webhook Test...\n');

  try {
    // 1️⃣ Create test payment in Firestore
    const testOrderId = Math.floor(Math.random() * 1000000);
    const paymentRef = db.collection('payments').doc();

    console.log('📝 Step 1: Creating test payment...');

    const paymentData = {
      paymentId: paymentRef.id,
      tripId: 'test-trip-' + Date.now(),
      riderId: 'test-rider-456',
      driverId: 'test-driver-789',
      amount: 100,
      status: 'pending',
      paymobOrderId: testOrderId,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    await paymentRef.set(paymentData);

    console.log('   ✅ Payment ID:', paymentRef.id);
    console.log('   ✅ Paymob Order ID:', testOrderId);
    console.log('   ✅ Status: pending');
    console.log('');

    // 2️⃣ Wait for data to be saved
    console.log('⏳ Step 2: Waiting for Firestore to save data...');
    await new Promise(resolve => setTimeout(resolve, 2000));
    console.log('   ✅ Done\n');

    // 3️⃣ Verify payment was created
    console.log('🔍 Step 3: Verifying payment exists...');
    const checkDoc = await paymentRef.get();
    if (!checkDoc.exists) {
      throw new Error('Payment was not created in Firestore!');
    }
    console.log('   ✅ Payment exists in Firestore');
    console.log('   ✅ paymobOrderId:', checkDoc.data().paymobOrderId);
    console.log('');

    // 4️⃣ Prepare webhook payload (simulating Paymob)
    const webhookPayload = {
      obj: {
        id: 987654, // Transaction ID من Paymob
        order: {
          id: testOrderId // هذا هو المهم - يطابق paymobOrderId
        },
        success: true,
        amount_cents: 10000, // 100 EGP
        currency: 'EGP',
        created_at: new Date().toISOString(),
        integration_id: 123456,
        is_3d_secure: true,
        is_auth: false,
        is_capture: true
      }
    };

    // 5️⃣ Send webhook to Cloud Function
    console.log('📤 Step 4: Sending webhook to Cloud Function...');
    console.log('   URL: http://127.0.0.1:5001/uberclonerider-5105a/us-central1/paymobWebhook');

    const response = await axios.post(
      'http://127.0.0.1:5001/uberclonerider-5105a/us-central1/paymobWebhook',
      webhookPayload,
      {
        headers: {
          'Content-Type': 'application/json'
        },
        timeout: 10000 // 10 seconds timeout
      }
    );

    console.log('   ✅ Status Code:', response.status);
    console.log('   ✅ Response:', response.data);
    console.log('');
// 6️⃣ Wait for function to process
    console.log('⏳ Step 5: Waiting for function to update payment...');
    await new Promise(resolve => setTimeout(resolve, 2000));
    console.log('   ✅ Done\n');

    // 7️⃣ Verify payment was updated
    console.log('🔍 Step 6: Verifying payment was updated...');
    const updatedDoc = await paymentRef.get();
    const finalStatus = updatedDoc.data().status;
    const hasResponse = updatedDoc.data().paymobResponse !== undefined;

    console.log('   📊 Final Status:', finalStatus);
    console.log('   📊 Has Paymob Response:', hasResponse);
    console.log('');

    // 8️⃣ Check test result
    if (finalStatus === 'success') {
      console.log('✅✅✅ TEST PASSED! ✅✅✅');
      console.log('');
      console.log('Summary:');
      console.log('  • Payment created: ✅');
      console.log('  • Webhook sent: ✅');
      console.log('  • Payment updated: ✅');
      console.log('  • Status changed to success: ✅');
      console.log('');
    } else {
      console.log('❌❌❌ TEST FAILED! ❌❌❌');
      console.log('');
      console.log('Expected status: success');
      console.log('Actual status:', finalStatus);
      console.log('');
      console.log('Debug Info:');
      console.log(JSON.stringify(updatedDoc.data(), null, 2));
      console.log('');
    }

  } catch (error) {
    console.error('\n❌ Test Error:');

    if (error.code === 'ECONNREFUSED') {
      console.error('   Connection refused - Is the Functions emulator running?');
      console.error('   Run: firebase emulators:start --only firestore,functions');
    } else if (error.response) {
      console.error('   Status:', error.response.status);
      console.error('   Response:', error.response.data);
    } else {
      console.error('   Message:', error.message);
    }
    console.log('');
  } finally {
    // Exit cleanly
    console.log('🏁 Test completed\n');
    process.exit(0);
  }
}

// ============== Run Test ==============

testWebhook();
