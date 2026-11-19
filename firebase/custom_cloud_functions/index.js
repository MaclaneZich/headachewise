const admin = require("firebase-admin/app");
admin.initializeApp();

const notifyOngoingHeadaches = require("./notify_ongoing_headaches.js");
exports.notifyOngoingHeadaches = notifyOngoingHeadaches.notifyOngoingHeadaches;
