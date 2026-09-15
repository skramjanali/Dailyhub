const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

/*
 * Create customer profile
 */
exports.createUserProfile = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Please login first."
    );
  }

  const uid = request.auth.uid;
  const userRef = db.collection("users").doc(uid);
  const userSnapshot = await userRef.get();

  if (!userSnapshot.exists) {
    const referralCode =
      "DH-" + uid.substring(0, 8).toUpperCase();

    await userRef.set({
      uid: uid,
      displayName:
        request.auth.token.name || "DailyHub User",
      email:
        request.auth.token.email || null,

      walletBalance: 0,

      referralCode: referralCode,

      totalReferralEarned: 0,
      totalCommission: 0,
      totalTransactions: 0,

      accountStatus: "ACTIVE",

      createdAt:
        admin.firestore.FieldValue.serverTimestamp(),

      updatedAt:
        admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  return {
    success: true,
    message: "User profile created successfully.",
  };
});


/*
 * Create commission record after
 *
