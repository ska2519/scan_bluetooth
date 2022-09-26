
import * as Functions from "firebase-functions";

import * as firebase from "firebase-admin";

import { productDataMap } from "./feature/in_app_purchase/products";
import { PurchaseHandler } from "./feature/in_app_purchase/purchase-handler";
import { GooglePlayPurchaseHandler } from "./feature/in_app_purchase/google-play.purchase-handler";
import { AppStorePurchaseHandler } from "./feature/in_app_purchase/app-store.purchase-handler";
import { CLOUD_REGION } from "./feature/in_app_purchase/constants";
import {
  IapRepository,
  IAPSource,
} from "./feature/in_app_purchase/iap.repository";
import { HttpsError } from "firebase-functions/lib/providers/https";

const functions = Functions.region(CLOUD_REGION);
firebase.initializeApp();

//
// Dependencies
//

const iapRepository = new IapRepository(firebase.firestore());
const purchaseHandlers: { [source in IAPSource]: PurchaseHandler } = {
  google_play: new GooglePlayPurchaseHandler(iapRepository),
  app_store: new AppStorePurchaseHandler(iapRepository),
};

//
// Callables
//

// Verify Purchase Function
interface VerifyPurchaseParams {
  source: IAPSource;
  verificationData: string;
  productId: string;
}

// Handling of purchase verifications
export const verifyPurchase = functions.https.onCall(
  async (data: VerifyPurchaseParams, context): Promise<boolean> => {
    // Check authentication
    if (!context.auth) {
      console.warn("verifyPurchase called when not authenticated");
      throw new HttpsError("unauthenticated", "Request was not authenticated.");
    }
    // Get the product data from the map
    const productData = productDataMap[data.productId];
    // If it was for an unknown product, do not process it.
    if (!productData) {
      console.warn(
        `verifyPurchase called for an unknown product ("${data.productId}")`
      );
      return false;
    }
    // If it was for an unknown source, do not process it.
    if (!purchaseHandlers[data.source]) {
      console.warn(
        `verifyPurchase called for an unknown source ("${data.source}")`
      );
      return false;
    }
    // Process the purchase for the product
    return purchaseHandlers[data.source].verifyPurchase(
      context.auth.uid,
      productData,
      data.verificationData
    );
  }
);

// Handling of AppStore server-to-server events
export const handleAppStoreServerEvent = (
  purchaseHandlers.app_store as AppStorePurchaseHandler
).handleServerEvent;

// Handling of PlayStore server-to-server events
export const handlePlayStoreServerEvent = (
  purchaseHandlers.google_play as GooglePlayPurchaseHandler
).handleServerEvent;

// Scheduled job for expiring subscriptions in the case of missing store events
export const expireSubscriptions = functions.pubsub
  .schedule("every 1 mins")
  .onRun(() => iapRepository.expireSubscriptions());
