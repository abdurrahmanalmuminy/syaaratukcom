/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");
// const functions = require('firebase-functions');

const {notifyOnOfferAccepted} = require("./notify_offer_accepted");
exports.notifyOnOfferAccepted = notifyOnOfferAccepted;

const {handleOrderCancellation} = require("./notify_offer_accepted");
exports.handleOrderCancellation = handleOrderCancellation;

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
