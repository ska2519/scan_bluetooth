import * as admin from "firebase-admin";
import * as Functions from "firebase-functions";
// import {CLOUD_REGION} from "./feature/in_app_purchase/constants";

admin.initializeApp();
// Functions.region(CLOUD_REGION);
export const functions = Functions;

 // in_app_purchase
export {verifyPurchase} from './feature/in_app_purchase/in_app_purchase';
export {handleAppStoreServerEvent} from './feature/in_app_purchase/in_app_purchase';
export {handlePlayStoreServerEvent} from './feature/in_app_purchase/in_app_purchase';
export {expireSubscriptions} from './feature/in_app_purchase/in_app_purchase';

// presence_users
export {onUserStatusChanged} from './feature/presence_user/presence_user';

// bluetooth
export {increaseLabelCount} from './feature/bluetooth/bluetooth';
export {decreaseLabelCount} from './feature/bluetooth/bluetooth';
