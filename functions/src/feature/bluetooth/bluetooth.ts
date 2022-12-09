import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

const firestore = admin.firestore();

const increment = admin.firestore.FieldValue.increment(1);
const decrement = admin.firestore.FieldValue.increment(-1);

export const increaseLabelCount = functions.firestore
  .document("bluetoothes/{deviceId}/labels/{uid}")
  .onCreate(async (snap, context) => {
    const bluetooth = snap.get("bluetooth");
    const deviceId = bluetooth.deviceId as string;
    const bluetoothRef = firestore.doc("bluetoothes/" + deviceId);
    bluetoothRef.update({ labelCount: increment });
  });

export const decreaseLabelCount = functions.firestore
  .document("bluetoothes/{deviceId}/labels/{uid}")
  .onDelete(async (snap, context) => {
    const bluetooth = snap.get("bluetooth");
    const deviceId = bluetooth.deviceId as string;
    const bluetoothRef = firestore.doc("bluetoothes/" + deviceId);
    bluetoothRef.update({ labelCount: decrement });
  });
