const admin = require("firebase-admin");

// Check if Firebase Admin has already been initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

module.exports = admin;
