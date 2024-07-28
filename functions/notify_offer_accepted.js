const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.notifyOnOfferAccepted = functions.firestore
    .document("offers/{offerId}")
    .onUpdate(async (change, context) => {
        const before = change.before.data();
        const after = change.after.data();

        if (before.status !== "تم القبول" && after.status === "تم القبول") {
            const offerId = context.params.offerId;
            const providerId = after.serviceProvider[0];

            const message = {
                notification: {
                    title: "تم قبول عرضك",
                    body: `تم قبول عرضك ${offerId}، يرجى التفاعل مع المستخدم`,
                },
                token: "", // Token will be set after fetching from Firestore
            };

            try {
                const userSnapshot = await admin.firestore()
                    .collection("providers")
                    .doc(providerId)
                    .get();

                if (!userSnapshot.exists) {
                    console.error("No such user document!");
                    return null;
                }

                const userToken = userSnapshot.data().fcmToken;

                if (!userToken) {
                    console.error("FCM token is null or undefined!");
                    return null;
                }

                // Update message object with the user token
                message.token = userToken;

                // Send the notification
                await admin.messaging().send(message);
                console.log("Notification sent successfully");
            } catch (error) {
                console.error("Error sending notification:", error);
            }
        } else {
            return null;
        }
    });

