const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.handleOrderCancellation = functions.firestore
    .document("orders/{orderId}")
    .onUpdate(async (change, context) => {
        const before = change.before.data();
        const after = change.after.data();

        // Check if the status was not "ملغي" before and now it is "ملغي"
        if (before.status !== "ملغي" && after.status === "ملغي") {
            // Check if paymentOption is "الدفع الإلكتروني"
            if (after.paymentOption === "الدفع الإلكتروني") {
                const orderId = context.params.orderId;
                const userId = after.user;
                const offerId = after.offerId;

                try {
                    // Get the offer document to fetch the price
                    const offerSnapshot = await admin.firestore()
                        .collection("offers")
                        .doc(offerId)
                        .get();

                    if (!offerSnapshot.exists) {
                        console.error("No such offer document!");
                        return null;
                    }

                    const offerPrice = offerSnapshot.data().price;

                    // Add the offer price to the user's balance
                    const userRef = admin.firestore().collection("users").doc(userId);
                    await admin.firestore().runTransaction(async (transaction) => {
                        const userDoc = await transaction.get(userRef);

                        if (!userDoc.exists) {
                            throw new Error("No such user document!");
                        }

                        const userData = userDoc.data();
                        const currentBalance = userData.balance || 0;
                        const newBalance = currentBalance + offerPrice;

                        // Update the user's balance
                        transaction.update(userRef, {balance: newBalance});

                        // Create a new transaction record
                        const transactionData = {
                            transaction: `استرجاع رسوم الطلب ${orderId}`,
                            amount: offerPrice,
                            dueAt: admin.firestore.Timestamp.now(),
                        };

                        const transactionRef = userRef.collection("transactions").doc();
                        transaction.set(transactionRef, transactionData);
                    });

                    console.log("User balance updated and transaction created successfully");
                } catch (error) {
                    console.error("Error processing order cancellation:", error);
                }
            } else {
                console.log("Payment option is not 'الدفع الإلكتروني'. No action taken.");
            }
        } else {
            return null;
        }
    });
