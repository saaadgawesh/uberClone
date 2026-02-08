// /**
//  * Import function triggers from their respective submodules:
//  *
//  * const {onCall} = require("firebase-functions/v2/https");
//  * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
//  *
//  * See a full list of supported triggers at https://firebase.google.com/docs/functions
//  */

// const {setGlobalOptions} = require("firebase-functions");
// const {onRequest} = require("firebase-functions/https");
// const logger = require("firebase-functions/logger");

// // For cost control, you can set the maximum number of containers that can be
// // running at the same time. This helps mitigate the impact of unexpected
// // traffic spikes by instead downgrading performance. This limit is a
// // per-function limit. You can override the limit for each function using the
// // `maxInstances` option in the function's options, e.g.
// // `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// // NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// // functions should each use functions.runWith({ maxInstances: 10 }) instead.
// // In the v1 API, each function can only serve one request per container, so
// // this will be the maximum concurrent request count.
// setGlobalOptions({ maxInstances: 10 });

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started

// // exports.helloWorld = onRequest((request, response) => {
// //   logger.info("Hello logs!", {structuredData: true});
// //   response.send("Hello from Firebase!");
// // });
// const functions = require('firebase-functions');
// const admin = require('firebase-admin');

// admin.initializeApp();

// // ================= Example HTTP Function =================
// exports.helloWorld = functions.https.onRequest((req, res) => {
//   console.log("helloWorld function called");
//   res.send("Hello from Firebase Functions!");
// });

// // ================= Example Callable Function =================
// exports.createPayment = functions.https.onCall(async (data, context) => {
//   console.log("createPayment called with data:", data);

//   // مثال بسيط: استقبال بيانات الدفع
//   const amount = data.amount || 0;
//   const riderId = data.riderId || "unknown";

//   // حفظ الدفع في Firestore Emulator
//   try {
//     const paymentRef = admin.firestore().collection("payments").doc();
//     await paymentRef.set({
//       paymentId: paymentRef.id,
//       riderId: riderId,
//       amount: amount,
//       status: "pending",
//       createdAt: admin.firestore.FieldValue.serverTimestamp(),
//     });

//     return { success: true, paymentId: paymentRef.id };
//   } catch (err) {
//     console.error("Error creating payment:", err);
//     throw new functions.https.HttpsError('internal', 'Failed to create payment');
//   }
// });
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { setGlobalOptions } = require("firebase-functions");
const { onRequest } = require("firebase-functions/https");
const logger = require("firebase-functions/logger");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp();

exports.onTripStatusChanged = functions.firestore
  .document('trips/{tripId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    // لو الحالة لم تتغير
    if (before.status === after.status) return;

    const riderToken = after.riderToken;
    if (!riderToken) return;

    let payload = null;

    if (after.status === 'accepted') {
      payload = {
        notification: {
          title: '✅ تم قبول الرحلة',
          body: 'السائق في الطريق إليك 🚗'
        },
        data: {
          type: 'trip_accepted',
          tripId: context.params.tripId
        }
      };
    }

    if (after.status === 'rejected') {
      payload = {
        notification: {
          title: '🚗 تم رفض الرحلة',
          body: 'نبحث عن سائق قريب'
        },
        data: {
          type: 'driver_rejected',
          tripId: context.params.tripId
        }
      };
    }

    if (after.status === 'no_driver') {
      payload = {
        notification: {
          title: '🚫 لا يوجد سائق متاح',
          body: 'نعتذر، لا يوجد سائق متاح حاليا'
        },
        data: {
          type: 'no_driver',
          tripId: context.params.tripId
        }
      };
    }

    if (payload) {
      await admin.messaging().sendToDevice(riderToken, payload);
    }
  });
