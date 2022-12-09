import * as admin from "firebase-admin";
import * as Functions from "firebase-functions";
// import {CLOUD_REGION} from "./feature/in_app_purchase/constants";

admin.initializeApp();
// Functions.region(CLOUD_REGION);
export const functions = Functions;


// auth
export {deleteAnonymousUsers, deleteAnonymousUsersFromRealtimeDatabase} from './feature/auth/auth';
// bluetooth
export {decreaseLabelCount, increaseLabelCount} from './feature/bluetooth/bluetooth';
// in_app_purchase
export {expireSubscriptions, handleAppStoreServerEvent, handlePlayStoreServerEvent, verifyPurchase} from './feature/in_app_purchase/in_app_purchase';
// presence_users
export {onUserStatusChanged} from './feature/presence_user/presence_user';


