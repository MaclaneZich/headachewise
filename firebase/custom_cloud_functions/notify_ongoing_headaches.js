const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.notifyOngoingHeadaches = functions.pubsub
  .schedule("every 15 minutes")
  .onRun(async () => {
    const db = admin.firestore();

    const HOURS = 8; // <— only change needed
    const nowMs = Date.now();
    const cutoffMs = nowMs - HOURS * 60 * 60 * 1000;
    const cutoffDate = new Date(cutoffMs);

    const qSnap = await db
      .collectionGroup("Headaches")
      .where("ongoing", "==", true)
      .where("startTime", "<=", cutoffDate)
      .where("notifiedOngoing5h", "==", false) // keeping old flag is fine
      .get();

    if (qSnap.empty) return null;

    const messaging = admin.messaging();
    const batch = db.batch();

    for (const doc of qSnap.docs) {
      const h = doc.data();

      if (h.endTime && h.endTime.toDate && h.endTime.toDate() <= cutoffDate) {
        batch.update(doc.ref, {
          ongoing: false,
          notifyNote: "ended_before_threshold",
        });
        continue;
      }

      const userRef = doc.ref.parent.parent; // users/{uid}
      if (!userRef) continue;
      const uid = userRef.id;

      const userSnap = await userRef.get();
      const tokens = (userSnap.get("fcmTokens") || []).filter(
        (t) => typeof t === "string",
      );
      if (!tokens.length) {
        batch.update(doc.ref, {
          notifiedOngoing5h: true,
          notifyNote: "no_tokens",
        });
        continue;
      }

      await messaging.sendEachForMulticast({
        tokens,
        notification: {
          title: "Check-in: headache > 8 hours",
          body: "Log an update, hydrate, and review your care plan.",
        },
        data: { type: "ONGOING_8H", uid, headacheId: doc.id },
      });

      batch.update(doc.ref, {
        notifiedOngoing5h: true, // still using existing flag
        notifiedAt: admin.firestore.Timestamp.now(),
      });
    }

    await batch.commit();
    return null;
  });
