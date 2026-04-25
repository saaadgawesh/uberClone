const admin = require("firebase-admin");
const functions = require("firebase-functions");

admin.initializeApp();

exports.onTripCreated = functions.firestore
  .document("trips/{tripId}")
  .onCreate(async (snapshot, context) => {
    const trip = snapshot.data() || {};
    const tripId = context.params.tripId;

    if (!trip.driverId) return null;

    const driverToken = await getUserToken("Driver", trip.driverId);
    if (!driverToken) return null;

    return sendToTokens([driverToken], {
      notification: {
        title: "رحلة جديدة",
        body: "تم إرسال طلب رحلة جديد إليك",
      },
      data: {
        type: "new_trip",
        tripId,
      },
    });
  });

exports.onTripUpdated = functions.firestore
  .document("trips/{tripId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data() || {};
    const after = change.after.data() || {};
    const tripId = context.params.tripId;
    const tasks = [];

    if (
      before.driverId !== after.driverId &&
      after.driverId &&
      (after.status === "requested" || after.status === "pending")
    ) {
      const newDriverToken = await getUserToken("Driver", after.driverId);
      if (newDriverToken) {
        tasks.push(
          sendToTokens([newDriverToken], {
            notification: {
              title: "رحلة جديدة",
              body: "تم توجيه الرحلة إليك",
            },
            data: {
              type: "new_trip",
              tripId,
            },
          }),
        );
      }
    }

    if (before.status === after.status) {
      return Promise.all(tasks);
    }

    const riderToken = after.riderId
      ? await getUserToken("Rider", after.riderId)
      : null;

    const driverToken = after.driverId
      ? await getUserToken("Driver", after.driverId)
      : null;

    if (after.status === "accepted" && riderToken) {
      tasks.push(
        sendToTokens([riderToken], {
          notification: {
            title: "تم قبول الرحلة",
            body: "السائق وافق على الرحلة وهو في الطريق إليك",
          },
          data: {
            type: "trip_accepted",
            tripId,
          },
        }),
      );
    }

    if (after.status === "rejected" && riderToken) {
      tasks.push(
        sendToTokens([riderToken], {
          notification: {
            title: "تم رفض الرحلة",
            body: "السائق رفض الرحلة وجارٍ البحث عن بديل",
          },
          data: {
            type: "driver_rejected",
            tripId,
          },
        }),
      );
    }

    if (after.status === "no_driver" && riderToken) {
      tasks.push(
        sendToTokens([riderToken], {
          notification: {
            title: "لا يوجد سائق متاح",
            body: "لم يتم العثور على سائق متاح حاليًا",
          },
          data: {
            type: "no_driver",
            tripId,
          },
        }),
      );
    }

    if (after.status === "completed" && riderToken) {
      tasks.push(
        sendToTokens([riderToken], {
          notification: {
            title: "انتهت الرحلة",
            body: "تم إنهاء الرحلة بنجاح",
          },
          data: {
            type: "trip_completed",
            tripId,
          },
        }),
      );
    }

    if (after.status === "cancelled") {
      const tokens = [riderToken, driverToken].filter(Boolean);
      if (tokens.length > 0) {
        tasks.push(
          sendToTokens(tokens, {
            notification: {
              title: "تم إلغاء الرحلة",
              body: "تم إلغاء الرحلة الحالية",
            },
            data: {
              type: "trip_cancelled",
              tripId,
            },
          }),
        );
      }
    }

    return Promise.all(tasks);
  });

exports.onPaymentCreated = functions.firestore
  .document("payments/{paymentId}")
  .onCreate(async (snapshot) => {
    const payment = snapshot.data() || {};
    const tokens = [];

    if (payment.riderId) {
      const riderToken = await getUserToken("Rider", payment.riderId);
      if (riderToken) tokens.push(riderToken);
    }

    if (payment.driverId) {
      const driverToken = await getUserToken("Driver", payment.driverId);
      if (driverToken) tokens.push(driverToken);
    }

    if (tokens.length === 0) return null;

    return sendToTokens(tokens, {
      notification: {
        title: "تحديث دفع",
        body: "تم إنشاء عملية دفع جديدة مرتبطة بالرحلة",
      },
      data: {
        type: "payment_created",
        tripId: payment.tripId || "",
      },
    });
  });

exports.onSupportRequestCreated = functions.firestore
  .document("support_requests/{requestId}")
  .onCreate(async (snapshot, context) => {
    const supportRequest = snapshot.data() || {};
    const adminsSnapshot = await admin.firestore().collection("Admin").get();

    const tokens = adminsSnapshot.docs
      .map((doc) => doc.data().fcmToken)
      .filter(Boolean);

    if (tokens.length === 0) return null;

    return sendToTokens(tokens, {
      notification: {
        title: "طلب دعم جديد",
        body: `${supportRequest.riderName || "راكب"} أرسل ${
          supportRequest.type === "complaint" ? "شكوى" : "استفسار"
        }`,
      },
      data: {
        type: "support_request_created",
        requestId: context.params.requestId,
        riderId: supportRequest.riderId || "",
      },
    });
  });

async function getUserToken(collection, userId) {
  const doc = await admin.firestore().collection(collection).doc(userId).get();
  if (!doc.exists) return null;

  return doc.data().fcmToken || null;
}

async function sendToTokens(tokens, payload) {
  const uniqueTokens = [...new Set(tokens.filter(Boolean))];
  if (uniqueTokens.length === 0) return null;

  return admin.messaging().sendEachForMulticast({
    tokens: uniqueTokens,
    notification: payload.notification,
    data: stringifyData(payload.data || {}),
  });
}

function stringifyData(data) {
  return Object.entries(data).reduce((result, [key, value]) => {
    result[key] = value == null ? "" : String(value);
    return result;
  }, {});
}
