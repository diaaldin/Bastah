/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {setGlobalOptions} from "firebase-functions";
import {onRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";
import {onDocumentCreated, onDocumentUpdated} from "firebase-functions/v2/firestore";

admin.initializeApp();

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

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

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// Cloud Function to send notification to Admin when a new order is placed
export const onNewOrder = onDocumentCreated('orders/{orderId}', async (event) => {
  const orderData = event.data?.data();
  if (!orderData) {
    logger.error('No data found for new order event.');
    return;
  }

  const customerName = orderData.customerName || 'Unknown Customer';
  const totalAmount = orderData.totalAmount || 0;

  // Fetch admin FCM tokens (you would store these in Firestore or a similar database)
  // For simplicity, let's assume a single admin token for now, or a topic subscription
  // In a real app, you'd query a collection of admin users and their tokens.
  const adminFCMToken = 'YOUR_ADMIN_FCM_TOKEN'; // Replace with actual admin token or topic

  const message = {
    notification: {
      title: 'New Order Placed!',
      body: `A new order from ${customerName} for $${totalAmount.toFixed(2)} has been placed.`,
    },
    token: adminFCMToken, // Or topic: 'admin_notifications'
  };

  try {
    const response = await admin.messaging().send(message);
    logger.info('Successfully sent new order notification to admin:', response);
  } catch (error) {
    logger.error('Error sending new order notification to admin:', error);
  }
});

// Cloud Function to send notification to Customer when order status changes
export const onOrderStatusChange = onDocumentUpdated('orders/{orderId}', async (event) => {
  const oldOrderData = event.data?.before.data();
  const newOrderData = event.data?.after.data();

  if (!oldOrderData || !newOrderData) {
    logger.error('No data found for order status change event.');
    return;
  }

  if (oldOrderData.status === newOrderData.status) {
    logger.info('Order status did not change. No notification sent.');
    return;
  }

  const customerUid = newOrderData.customerUid; // Assuming customerUid is stored in the order document
  const newStatus = newOrderData.status;
  const orderId = event.params.orderId;

  if (!customerUid) {
    logger.error('Customer UID not found in order document. Cannot send notification.');
    return;
  }

  // Fetch customer's FCM token (you would store this in Firestore, e.g., in a 'users' collection)
  // For simplicity, let's assume customer tokens are stored in a 'users' collection
  const customerDoc = await admin.firestore().collection('users').doc(customerUid).get();
  const customerFCMToken = customerDoc.data()?.fcmToken;

  if (!customerFCMToken) {
    logger.error(`FCM token not found for customer ${customerUid}. Cannot send notification.`);
    return;
  }

  const message = {
    notification: {
      title: 'Order Status Updated!',
      body: `Your order #${orderId} status has changed to ${newStatus}.`,
    },
    token: customerFCMToken,
  };

  try {
    const response = await admin.messaging().send(message);
    logger.info('Successfully sent order status update notification to customer:', response);
  } catch (error) {
    logger.error('Error sending order status update notification to customer:', error);
  }
});